#!/bin/bash

python posts_pipeline.py

# fetching and load data
POSTGRES="psql -U dummy -d dummyproject"

# update the 
echo "Update data mart daily_activity_per_city"
$POSTGRES <<-EOSQL
REFRESH MATERIALIZED VIEW dw."daily_activity_per_city";
EOSQL