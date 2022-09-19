"""
This project aims to build a tempalte to access pageanated api responses from karbon
"""

import requests
import json
import config

# add funcitons here to use inside the basic_api_requests() function
def add_records_to_sql_database(array_of_rows,database,table,row_titles):

    # check if list of rows is over the insert limit
    if len(array_of_rows) > 1000:
        
        # split array into chunks of 1000


        # for each array chunk, insert the rows to the database


        pass

# this function makes all the necessary requests to get a full list of vlaues from paganated api responses
def basic_api_requests (request_perameters):
    
    # define heads for the api request
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + config.BearerToken,
        'AccessKey': config.AccessKey
    }

    # make the qpi reqeust
    response = requests.request("GET", config.base_url + request_perameters, headers=headers)

    # convert response to json
    json_object = json.loads(response.text)

    # extracts the value array
    rows = json_object["value"]

    # add any functions you want to use with your data here


    # when a next link exists, call it
    if "@odata.nextLink" in json_object:
        
        # since the next link provided by karbon doesn't work, this peels off the new parameters
        next_parameters = json_object["@odata.nextLink"].split("V3/",1)

        # this calls this same function again to get the rows from the next group
        next_rows = basic_api_requests(next_parameters[1])

        # combine this functions rows with the rows from the next link
        rows.extend(next_rows)

    # returns the rows from the value section of the api call
    return rows

## this section will hold the code you want to actually execute
# put your query parameters in the text section here
api_reqeust_parameters = 'Timesheets?$filter=StartDate gt 2021-12-31&$expand=TimeEntries'

# put your code here -- what do you wnat to do?
basic_api_requests(api_reqeust_parameters)