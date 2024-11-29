#!/bin/bash
set -e

DB_HOST=`cat terraform_output.json`
DB_USER=app_admin

psql -h dev-aurora-cluster.cluster-cj8e6euumn25.us-east-1.rds.amazonaws.com -U $DB_USER -d $DB_NAME -f ./create_schema.sql