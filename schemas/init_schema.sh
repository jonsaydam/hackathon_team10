#!/bin/bash
set -e

DB_HOST=`cat terraform_output.json`
DB_USER=app_admin

psql -h "$DB_HOST" -U "$DB_USER" -d postgres -f ./create_schema.sql