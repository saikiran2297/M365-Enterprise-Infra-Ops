# Patching, Updates, Lifecycle Management

## Patching strategy
- Rings:
  - Ring 0: IT/early adopters
  - Ring 1: Core business (50%)
  - Ring 2: Remaining (50%)
- Maintenance windows: defined per ring
- Pre-checks: backups, service health, change freeze calendar
- Post-checks: auth, core app sign-in, key service validations

## Lifecycle management
- Upgrade plan template:
  - inventory → dependency mapping → pilot → phased rollout → validation
- Migration plan template:
  - rollback path defined, data integrity checks, comms plan
- Decommission checklist:
  - confirm no dependencies, archive configs, revoke credentials, remove DNS, update CMDB

## Evidence to include
- Redacted patch compliance report output (script)
- Sample change request PR using templates
