# dummybi

## Instractions

### Clone the repo
``` 
git clone https://github.com/christosgeorgoulis/dummybi
```
### Run the elt-dw app
``` 
cd dummybi
docker-compose up -d
```
### Connect to Data Warehouse from host machine
``` 
user: dummy
pass: dummy
url : '0.0.0.0'
port: 5432
```

The pipelines are to be executed daily midnight.


## Codebase description
 ```
 | -- backup
 |    | -- backup.sql
 |
 | -- config
 |    | -- postgres.env

 | -- datamarts
 |    | -- comment_lag.sql
 |    | -- daily_activity_per_city.sql
 |    | -- daily_new_users.sql
 |
 | -- pipelines
 |    | -- tooling
 |    |    | -- helpers
 |    |    |    | -- fetch.py
 |    |    |
 |    |    | -- dummyapitopostgres.py
 |    |
 |    | -- comments_pipeline.py
 |    | -- posts_pipeline.py
 |    | -- users_pipeline.py
 |    
 | -- servises
 |    | -- eltworker
 |    |    | -- comment_pipeline.sh
 |    |    | -- post_pipeline.sh
 |    |    | -- user_pipeline.sh
 |    |    | -- entrypoint.sh
 |    |
 |    | -- postgres
 |         | -- 00_create_user.sh
 |         | -- 01_create_db.sh
 |         | -- 02_load_schema.sh
 | -- Dockerfile
 | -- docker-compose.yml
 ```

 ### DevOps
 #### DB
 For db we have set up a postgres instance. We deploy it through a docker container, using the 'docker-compose.yml' and the env variables from file:
 ```
 condifg\postgres.env
 ```

 On start of the container, the bash scripts of directory
 ```
 services\postgres
 ```
 are executed. They are responsible for setting up the db, with a dummy user, a dw schema, the apropriate tables and the materialized views needed for the Data Mart layer. The shcema related info lays on: 
 ```
 backup\backup.sql
```
The queries for materialized view are presented through directory:
```
datamarts
```
for easy access reasons only.

#### Elt worker
For data transfers and validation we use a python based (python official image) container, created by and image build out of the present Dockerfile. This container is build and deployed using the docker-compose.yml file. 

This container is responsible for pipeline execution and orchertation, due to the project "dimesnion" these functionalities are executed from one worker.

For orchestration of the pipeline tasks, are employeed the bash scripts laying on directory: 
```
services\eltworker
``` 
They are responsible for execution both python and plain sql based tasks.

On execution of all pipelines is triggered from start up of the container, and all of them are scheduled with a cron job for daily execution at midnight.

### Pipelines
For data transfer part of pipelines, a python based architecture has been developed.


