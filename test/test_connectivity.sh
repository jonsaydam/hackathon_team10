#!/bin/bash
set -e

psql -h $DB_HOST -U $DB_USER -c "\conninfo"
