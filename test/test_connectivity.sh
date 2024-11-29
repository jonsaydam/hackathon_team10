#!/bin/bash
set -e

psql -h $DB_HOST -U ${{ secrets.DB_USER }} -c "\conninfo"
