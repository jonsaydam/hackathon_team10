#!/bin/bash
set -e

psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f ./schemas/create_schema.sql
