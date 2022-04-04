#!/bin/bash

python users_pipeline.py

# fetching and load data
POSTGRES="psql -U dummy -d dummyproject"

# update the 
echo "Update data mart comment_lag"
$POSTGRES <<-EOSQL
REFRESH MATERIALIZED VIEW dw."comment_lag";
EOSQL