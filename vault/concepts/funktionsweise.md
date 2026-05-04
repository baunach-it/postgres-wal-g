---
type: concept
repo: postgres-wal-g
status: active
tags: [postgres, wal-g, archiving, s3, db-image]
---

# Funktionsweise — postgres-wal-g

Erweitert das offizielle PostgreSQL-Docker-Image (17+) um die WAL-G-Binary
(v3.0.7, Ubuntu 24.04, amd64) und konfiguriert Continuous WAL Archiving.

## Setup im Image

- WAL-G-Binary wird im Build-Prozess heruntergeladen und in `$PATH` installiert.
- Standard-PostgreSQL-Entrypoint bleibt erhalten.
- Archiving wird ueber PostgreSQL-Konfigurations-Parameter aktiviert (zur Laufzeit per
  Container-Start uebergeben — siehe `concepts/empfohlene-postgres-parameter.md`):
  - `archive_mode=on`
  - `archive_command='wal-g wal-push %p'`
  - `wal_level=replica`

## Tag-Format

`postgres-{POSTGRES_VERSION}-wal-g-{WAL_G_VERSION}-ubuntu-24.04`

Zwei explizite Versions-Achsen: PostgreSQL Major-Version + WAL-G Patch-Version.

## Befehle

```bash
# Base Backup erstellen (auf laufendem Container)
docker exec -it my-database wal-g backup-push /var/lib/postgresql/data

# Liste aller Base Backups
docker exec -it my-database wal-g backup-list
```

## Storage-Konfiguration

| Variable | Wert | Hinweis |
|---|---|---|
| `WALG_S3_PREFIX` | `s3://bucket/path` | Pfad fuer Base Backups + WAL-Segmente |
| `AWS_ACCESS_KEY_ID` / `_SECRET_ACCESS_KEY` | — | S3-Credentials |
| `AWS_REGION` | `eu-central-1` | Default |
| `AWS_ENDPOINT` | `https://s3.eu-central-1.amazonaws.com` | Default — auf Hetzner-Endpoint umstellen |
| `AWS_S3_FORCE_PATH_STYLE` | `true` | Pflicht fuer Hetzner Object Storage |

## Bezug

- Workspace-Vault: `concepts/wal-g-archiving.md`, `concepts/pg-dump-vs-wal-g.md`,
  `decisions/2026-05-04-multi-arch-ausser-wal-g.md`
- Empfohlene Parameter: `concepts/empfohlene-postgres-parameter.md`
- Doku-Output: `docs/src/content/docs/projekte/docker-images/Postgres-WAL-G/uebersicht.md`
