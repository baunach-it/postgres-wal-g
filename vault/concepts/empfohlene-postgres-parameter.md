---
type: concept
repo: postgres-wal-g
status: active
tags: [postgres, configuration, performance, wal]
---

# Empfohlene PostgreSQL-Parameter

Container-Start mit folgenden `-c`-Flags. Die Parameter aktivieren WAL-G-Archiving
und setzen sinnvolle Defaults fuer Parallelismus und WAL-Groesse.

```text
-c min_wal_size=512MB
-c max_wal_size=4GB
-c max_worker_processes=8
-c max_parallel_workers_per_gather=4
-c max_parallel_workers=8
-c max_parallel_maintenance_workers=4
-c archive_mode=on
-c archive_command='wal-g wal-push %p'
-c wal_level=replica
```

## Begruendung

| Parameter | Zweck |
|---|---|
| `archive_mode=on` | Aktiviert WAL-Archivierung — Voraussetzung fuer PITR |
| `archive_command` | Ruft WAL-G fuer jedes WAL-Segment auf |
| `wal_level=replica` | Pflicht-Level fuer Archiving (kein `minimal`) |
| `min_wal_size` / `max_wal_size` | Verhindert haeufiges WAL-Recycling unter Last |
| `max_worker_processes`, `max_parallel_*` | Default-Parallelismus fuer typische Hetzner-VPS-Groessen |

## Anpassung

- `max_parallel_*` an CPU-Kerne anpassen (Default-Setup fuer ~8 vCPU-Server).
- `max_wal_size` bei sehr write-heavy Workloads erhoehen (verhindert Checkpoint-Sturm).
- Bei sehr kleinen Containern (≤2 vCPU) Parallelismus reduzieren.

## Bezug

- `concepts/funktionsweise.md`
- Workspace-Vault: `concepts/wal-g-archiving.md`
