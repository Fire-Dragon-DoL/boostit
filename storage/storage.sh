#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE boom_development;
    CREATE DATABASE boom_production;
    \c boom_development
    CREATE EXTENSION IF NOT EXISTS pgcrypto;
    \c boom_production
    CREATE EXTENSION IF NOT EXISTS pgcrypto;
EOSQL
result=$?

echo 'Boom database initialized'

exit $result
