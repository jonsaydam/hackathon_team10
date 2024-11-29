#!/bin/bash
set -e

psql -h $DB_HOST -U ${{ secrets.DB_USER }} -d ${{ secrets.DB_NAME }} -f ./create_schema.sql
