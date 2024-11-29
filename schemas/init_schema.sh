#!/bin/bash
set -e

DB_HOST=`cat terraform_output.json | sed 's/"//g'`
DB_USER=app_admin

psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f ./create_schema.sql
