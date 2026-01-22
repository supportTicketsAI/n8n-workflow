#!/bin/bash
set -e

echo "Starting n8n with Railway configuration..."

# Simple wait for database connection without pg_isready
if [ -n "$DB_POSTGRESDB_HOST" ] && [ "$DB_POSTGRESDB_HOST" != "localhost" ]; then
    echo "Waiting for PostgreSQL to be ready..."
    
    # Simple connection test using netcat or timeout
    for i in {1..30}; do
        if timeout 1 bash -c "exec 3<>/dev/tcp/${DB_POSTGRESDB_HOST}/${DB_POSTGRESDB_PORT:-5432}" 2>/dev/null; then
            echo "Database connection established!"
            exec 3<&-
            exec 3>&-
            break
        fi
        echo "Waiting for database... (attempt $i/30)"
        sleep 2
    done
fi

# Run n8n
exec n8n start