#!/bin/bash
set -e # exit immediately if a command exits with a non-zero status.

POSTGRES="psql -U dummy -d dummyproject"

# create database for superset
echo "Creating schema: dw"
$POSTGRES <<-EOSQL
CREATE SCHEMA dw ;
EOSQL

psql --username dummy -d dummyproject < "../backup/backup.sql"