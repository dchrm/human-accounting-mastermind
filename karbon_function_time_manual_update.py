# this function fills your database with timesheet and time entry data
# there are two tables related to time in the database
# the first table is the dimension (dim) table which keeps track of the timesheet data
# the second table is the fact (fct) table which keeps track of the time entry data
# there are no webhooks available to karbon users related to timesheet or time entry data
# the information must be refreshed on an interval (once per night might make sense) 


import karbon_functions_library as kfl
## this section will hold the code you want to actually execute
# put your query parameters in the text section here
api_reqeust_parameters = 'Timesheets?$filter=EndDate gt 2021-12-31&$expand=TimeEntries'

# define the list of columns to treat as datetime for sql
# json passes text values to our functions, but we need to import the data as type datetimeoffset to match the database datatype
date_time_fields = [
    "StartDate",
    "EndDate"
]

# delete the fct table first
# it must be deleted frist because of the database relationship rules
# every time entry must relate to a timesheet, so the time entries must be deleted before the timesheets 
kfl.sql_delete('[dbo].[fct_time_entries]')

# delete the timesheet data to prepare for refresh
kfl.sql_delete('[dbo].[dim_timesheets]')

# call function to add updated timesheet and time entry data back to the database
kfl.timesheet_api_request(api_reqeust_parameters,date_time_fields)