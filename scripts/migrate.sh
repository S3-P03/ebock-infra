#!/bin/sh
set -e

echo "Running migrations..."


PGPASSWORD="$PGPASSWORD" psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "
CREATE TABLE IF NOT EXISTS ebock.schema_migrations (
  version TEXT PRIMARY KEY,
  applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
"

for file in /migrations/*.sql; do
  version=$(basename "$file")

  applied=$(psql -h db -U $POSTGRES_USER -d $POSTGRES_DB -tAc \
    "SELECT 1 FROM ebock.schema_migrations WHERE version = '$version'")

  if [ "$applied" != "1" ]; then
    echo "Applying $version"
    
    psql -h db -U $POSTGRES_USER -d $POSTGRES_DB -f "$file"

    psql -h db -U $POSTGRES_USER -d $POSTGRES_DB -c \
      "INSERT INTO ebock.schema_migrations (version) VALUES ('$version');"
  else
    echo "Skipping $version (already applied)"
  fi
done

echo "Migrations complete!"