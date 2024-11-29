#!/bin/bash
set -e

psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "INSERT INTO payee (email, name, phone_number) VALUES ('testuser@example.com', 'Test User', '1234567890');"
psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "SELECT * FROM payee;"
