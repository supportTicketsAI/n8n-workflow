#!/bin/bash
set -e

echo "Starting n8n with Railway configuration..."

# Wait for database to be ready if using external PostgreSQL
if [ -n "$DB_POSTGRESDB_HOST" ] && [ "$DB_POSTGRESDB_HOST" != "localhost" ]; then
    echo "Waiting for PostgreSQL to be ready..."
    until pg_isready -h "$DB_POSTGRESDB_HOST" -p "${DB_POSTGRESDB_PORT:-5432}" -U "$DB_POSTGRESDB_USER"; do
        echo "Waiting for database..."
        sleep 2
    done
    echo "Database is ready!"
fi

# Run n8n
exec n8n start