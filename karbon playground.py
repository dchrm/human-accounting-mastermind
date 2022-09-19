

import basic_karbon_get_function

## this section will hold the code you want to actually execute
# put your query parameters in the text section here
api_reqeust_parameters = 'Timesheets?$filter=StartDate gt 2021-12-31&$expand=TimeEntries'

# put your code here -- what functions do you wnat to call?
rows = basic_karbon_get_function(api_reqeust_parameters)