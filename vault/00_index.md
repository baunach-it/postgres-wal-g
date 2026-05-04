---
type: index
repo: postgres-wal-g
workspace: baunach-postgres
tenant: baunach
---

# postgres-wal-g Repo-Vault

Image-spezifische Doku fuer `postgres-wal-g` — **das DB-Image** mit WAL-G fuer
Continuous Archiving und Point-in-Time Recovery.

## Inhalt

- `concepts/funktionsweise.md` — Postgres + WAL-G Binary, archive_command-Setup
- `concepts/empfohlene-postgres-parameter.md` — empfohlene `-c` Flags fuer den Container-Start
- `decisions/` — Image-spezifische Entscheidungen (TBD)
- `playbooks/` — Image-spezifische Prozeduren (TBD: `base-backup-erstellen.md`, `pitr-restore.md`)
- `troubleshooting/` — Fehlerbilder (z.B. WAL-Lag, Archive-Fehler)

## Besonderheit: ist das DB-Image

Anders als die drei anderen Images ist `postgres-wal-g` **kein Tool-Container**, sondern das
PostgreSQL-Image selbst, das in `infrastructure-production` und `infrastructure-test` als
DB-Container laeuft. Continuous Archiving ist ein Konfigurations-Layer **auf** PostgreSQL.

## Cross-Image-Themen → Workspace-Vault

- WAL-G Continuous Archiving: `concepts/wal-g-archiving.md`
- pg_dump vs. WAL-G: `concepts/pg-dump-vs-wal-g.md`
- Multi-Arch-Asymmetrie (WAL-G amd64-only): `decisions/2026-05-04-multi-arch-ausser-wal-g.md`
- Image-Konventionen: `stack/image-konventionen.md`
- Project-MOC: `projects/postgres-wal-g.md`

## Doku-Output

`docs/src/content/docs/projekte/docker-images/Postgres-WAL-G/`
