# human-accounting-mastermind

this project aims to help acocunting firms focused on continuous improvement towards service excellence utilize the karbon (https://app.karbonhq.com) api to solve complex problems.

i have no formal training and also strugle to spell and punctuate, so feel free to create pull requests to fix comment errors, lol.

all are welcome to contrubute, no experience neccesary. 😀 all that's necesary is an attitude of colaboraton and a desire for continious improvement.

general setup steps i took:
 - provision a database (i use azure sql server)
 - provision azure logic apps as webhook handlers to feed up-to-minute changes in work items and contacts to your database
 - subscribe to karbon work items and contacts webhooks sending the response to your azure logic app webhook handler
 - run python scripts to request data from the karbon api to seed your database with initial data
 
 what i with the system:
 - [released] connect Power BI desktop (direct query) to database and [in-progress] build meaningful data visualizations
 - trigger bots to:
    - [released] ask humans to change the work type to something meaningufl when 'default' work type chosen
    - [planned] add note tempalte asking for details regarding external incoming and outgoing phone, teams, and zoom calls
    - [planned] programatically update clients on return status (pizza tracker-style)
    - [planned] send and receive threaded sms messages in notes
