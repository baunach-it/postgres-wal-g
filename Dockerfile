# Use build arguments for PostgreSQL and WAL-G versions
ARG BASE_IMAGE_VERSION=latest
ARG WAL_G_VERSION=v3.0.7/wal-g-pg-ubuntu-24.04-amd64

# Base image with configurable PostgreSQL version
FROM postgres:${BASE_IMAGE_VERSION}

ARG BASE_IMAGE_VERSION
ARG WAL_G_VERSION

# Install dependencies and WAL-G
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget ca-certificates \
    && wget -O /usr/local/bin/wal-g https://github.com/wal-g/wal-g/releases/download/${WAL_G_VERSION} \
    && chmod +x /usr/local/bin/wal-g \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set WAL-G environment variables
ENV PGUSER=$POSTGRES_USER
ENV PGPASSWORD=$POSTGRES_PASSWORD
ENV PGDATABASE=$POSTGRES_DB
ENV PGHOST=localhost
ENV PGPORT=5432
ENV WALG_S3_PREFIX=s3://bucket/path
ENV AWS_ACCESS_KEY_ID=your-access-key
ENV AWS_SECRET_ACCESS_KEY=your-secret-key
ENV AWS_S3_FORCE_PATH_STYLE=true
ENV AWS_REGION=eu-central-1
ENV AWS_ENDPOINT=https://s3.eu-central-1.amazonaws.com

# Set entrypoint to PostgreSQL
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]