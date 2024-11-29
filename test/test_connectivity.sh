#!/bin/bash
set -e

DB_HOST=`cat terraform_output.json`
DB_USER=app_admin
DB_NAME=devdatabase

psql -h "$DB_HOST" -U "$DB_USER" -c "\conninfo"