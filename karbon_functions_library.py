"""
This project aims to build a tempalte to access pageanated api responses from karbon
"""

import requests
import json
import config
import pyodbc
import sqlalchemy
from sqlalchemy.engine import URL
import pandas as pd

# template api request function for paginated api requests
def qpi_request_tempalte(request_perameters):
    
    # define headers for the api request
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + config.BearerToken,
        'AccessKey': config.AccessKey
    }

    # make the qpi reqeust use the request paamerters passed to the function
    response = requests.request(
        'GET', 
        config.base_url + request_perameters, 
        headers=headers
        )

    # convert response to json
    json_object = json.loads(response.text)

    # extracts the value array
    values = json_object['value']
    
    ## you may want to add functions here to work with your data incrimentally.
    ## as it comes from the API. If so, add the appropriate functions in this section.
    ## alternatively, this function return all the values for operation as on a large 
    ## dataset.



    # call the next page if it exists
    if '@odata.nextLink' in json_object:
        
        # since the next link provided by karbon doesn't work, peel off the new parameters
        next_parameters = json_object['@odata.nextLink'].split('V3/',1)

        # call this function again to get the rows from the next group
        timesheet_api_request(next_parameters[1])
    
    # returns the values from the request
    return(values)
    

# function requests timesheet and 
def timesheet_api_request(request_perameters):
    
    # define headers for the api request
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + config.BearerToken,
        'AccessKey': config.AccessKey
    }

    # make the qpi reqeust use the request paamerters passed to the function
    response = requests.request(
        'GET', 
        config.base_url + request_perameters, 
        headers=headers
        )

    # convert response to json
    json_object = json.loads(response.text)

    # extracts the value array
    timesheets = json_object['value']

    # itialize the timesheet dictionary
    timesheet_data = dict.fromkeys([
        'TimesheetKey',
        'StartDate',
        'EndDate',
        'UserKey',
        'Status'
    ])

    # make the value for each key an empty list to prep for list extension
    for element in timesheet_data:
        timesheet_data[element] = []
    
    
    # initalize the time entry dictionary
    time_entry_data = dict.fromkeys([
        'TimesheetKey',
        'TimeEntryKey',
        'EntityKey',
        'WorkItemKey',
        'ClientKey',
        'ClientType',
        'RoleName',
        'TaskTypeName',
        'Minutes',
        'HourlyRate'
    ])

    # make the value for each key and empty list to prep for list extension
    for element in time_entry_data:
        time_entry_data[element] = []

    

    # pull time entry data from timesheets and put it in its own dictionary
    for timesheet in timesheets:

        # look for time entries
        for time_entry in timesheet['TimeEntries']:

            # remove descriptions from the data as we will not be adding this to the database
            time_entry.pop('Descriptions')

            # add timesheet key
            listval = list()
            listval.append(timesheet['TimesheetKey'])
            time_entry_data['TimesheetKey'].extend(listval)
            
            # add each value to the time_entry dictionary to prep for dataframe creation
            for key in time_entry:
                listval = list()
                listval.append(time_entry[key])
                time_entry_data[key].extend(listval)


        # remove unwanted elements from timesheet dictionary
        timesheet.pop('WorkItemKeys')
        timesheet.pop('TimeEntries')
        
        # add each value to the timesheet dictionsary to prep for dataframe creation
        for key in timesheet:
            listval = list()
            listval.append(timesheet[key])
            timesheet_data[key].extend(listval)
    

    # insert timesheet data for this page
    sql_insert(
        'dim_timesheets',
        timesheet_data
    )

    # insert time entry data for this page
    sql_insert(
        'fct_time_entries',
        time_entry_data
    )

    # when a next link exists, call it
    if '@odata.nextLink' in json_object:
        
        # since the next link provided by karbon doesn't work, this peels off the new parameters
        next_parameters = json_object['@odata.nextLink'].split('V3/',1)

        # this calls this same function again to get the rows from the next group
        timesheet_api_request(next_parameters[1])

# function uses pandas to insert data to a database table
def sql_insert(table,data_rows):

    # create the connection url
    connection_url = URL.create(
        'mssql+pyodbc', 
        query={'odbc_connect': config.sql_server_connection_string}
        )

    # create the database engine
    database_engine = sqlalchemy.create_engine(
        connection_url,
        fast_executemany=True,
        connect_args={'connect_timeout': 30}, 
        echo=False
        )

    # convert input to dataframe
    df = pd.DataFrame(data_rows)

    # insert the data to the database
    df.to_sql(
        con=database_engine,
        schema='dbo',
        name=table,
        if_exists='append',
        index=False,
        chunksize=1000
    )

# delete all existing rows in the table passed to the function
# (use for refreshing timesheet and time entry data)
def sql_delete(table):

    # build the sql statement
    query ='DELETE FROM '+table
    
    # connect to the sql instance
    conn = pyodbc.connect(config.sql_server_connection_string)

    # get curser
    cursor = conn.cursor()

    # execute query
    cursor.execute(query)

    #commit
    conn.commit()
    cursor.close()
    conn.close()