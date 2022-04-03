#!/bin/bash
set -e # exit immediately if a command exits with a non-zero status.

POSTGRES="psql -U postgres"

# create database for superset
echo "Creating database: dummyproject"
$POSTGRES <<-EOSQL
CREATE DATABASE dummyproject OWNER dummy;
EOSQL