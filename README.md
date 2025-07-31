# Docker Image for Postgres bundled with WAL-G

[Dockerfile](https://github.com/baunach-it/postgres-wal-g/blob/main/Dockerfile)

## Usage
### WAL archiving (docker compose)
```
my-database:
    image: baunach/postgres-wal-g:postgres-17.5-wal-g-3.0.7-ubuntu-24.04
    container_name: my-database
    restart: always
    user: root
    expose:
      - 5432
    environment:
      - POSTGRES_USER=my_db_user
      - POSTGRES_PASSWORD=my_db_password
      - POSTGRES_DB=my_db_name
      - PGHOST=localhost
      - PGUSER=my_db_user
      - PGPASSWORD=my_db_password
      - PGDATABASE=my_db_name
      - PGPORT=5432
      - WALG_S3_PREFIX=s3://bucket/path
      - AWS_ACCESS_KEY_ID=my_aws_access_key
      - AWS_SECRET_ACCESS_KEY=my_aws_secret_key
      - AWS_S3_FORCE_PATH_STYLE=true
      - AWS_REGION=eu-central-1
      - AWS_ENDPOINT=https://s3.eu-central-1.amazonaws.com
    volumes:
      - my-database-volume:/var/lib/postgresql/data
    command: >
      postgres
      -c min_wal_size=512MB
      -c max_wal_size=4GB
      -c max_worker_processes=8
      -c max_parallel_workers_per_gather=4
      -c max_parallel_workers=8
      -c max_parallel_maintenance_workers=4
      -c archive_mode=on
      -c archive_command='wal-g wal-push %p'
      -c wal_level=replica
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -d my_db_name -U my_db_user"]
      start_period: 20s
      interval: 30s
      retries: 5
      timeout: 5s
```
### Base backups (docker compose)
`docker exec -it my-database wal-g backup-push /var/lib/postgresql/data`
