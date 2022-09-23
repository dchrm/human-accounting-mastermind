

import karbon_functions_library
## this section will hold the code you want to actually execute
# put your query parameters in the text section here
api_reqeust_parameters = 'Timesheets?$filter=EndDate gt 2021-12-31&$expand=TimeEntries'

# put your code here -- what functions do you wnat to call?
karbon_functions_library.sql_delete('[dbo].[fct_time_entries]')
karbon_functions_library.sql_delete('[dbo].[dim_timesheets]')
karbon_functions_library.timesheet_api_request(api_reqeust_parameters)
