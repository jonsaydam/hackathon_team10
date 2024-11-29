#!/bin/bash
set -e

DB_HOST=`cat terraform_output.json | sed 's/"//g'`
psql -h $DB_HOST -U $DB_USER -c "\conninfo"
