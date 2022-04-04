#!/bin/bash

python users_pipeline.py

# fetching and load data
POSTGRES="psql -U dummy -d dummyproject"

# update the 
echo "Update data mart daily_new_users"
$POSTGRES <<-EOSQL
REFRESH MATERIALIZED VIEW dw."daily_new_users";
EOSQL