# this function fills your database with the initial work item information
# there are two tables related to work items in the database
# the first table is the dimension (dim) table which keeps track of the work item information that does not change (key, title, etc.)
# the secon table is the fact (fct) table which keeps track of the work item information that changes (assignee, due date, etc.) 

# all of the functions used to accomplish these tasks are housed in the 'karbon_functions_library' file
# import the functions library
import karbon_functions_library as kfl

# define query parameters 
# (everything after 'https://api.karbonhq.com/v3/')
api_reqeust_parameters = 'WorkItems'

# define the list of columns to pull out of json and pass to the database
# only a few of the available columns make sense to add to your own database
# -- this section pulls the dim table data for work items
columns_to_database = [
    "WorkItemKey",
    "Title",
    "ClientKey",
    "RelatedClientGroupKey",
    "WorkType"
]

# define the list of columns to pull out of json and pass to the database
# only a few of the available columns make sense to add to your own database
# -- this section pulls the fct table data for work items
columns_to_database2 = [
    "WorkItemKey",
    "AssigneeKey",
    "StartDate",
    "DueDate",
    "CompletedDate",
    "WorkStatus",
    "LastUpdateDateTime"
]

# define the list of columns to treat as datetime for sql
# json passes text values to our functions, but we need to import the data as type datetimeoffset to match the database datatype 
columns_to_database2_datetime = [
    "StartDate",
    "DueDate",
    "CompletedDate",
    "LastUpdateDateTime"
]

# get the work item data from the api
values = kfl.api_request_template(api_reqeust_parameters)

# prep the api values for dataframe
# -- create a dataframe for the work item dim table
prepped_work_item_df = kfl.create_data_frame(columns_to_database,values)
# -- create a dataframe for the work item fct table
prepped_work_item_flow_df = kfl.create_data_frame_flow(columns_to_database2,values)

# delete the values in the database
# only one record of each work item allowed for the database to work properly
kfl.sql_delete("[dbo].[dim_work_items]")

# delete the work item fct tabel
# this is only necessary when pulling a fresh set of data
# most times you will leave this commented to process an update to catch any missing data in the work fct table
# kfl.sql_delete("[dbo].[fct_work_item_flow]")

# send data to the database
# -- insert work item dim table
kfl.sql_insert("dim_work_items",prepped_work_item_df)
# -- insert work item fct table
kfl.sql_insert("fct_work_item_flow",prepped_work_item_flow_df,columns_to_database2_datetime)