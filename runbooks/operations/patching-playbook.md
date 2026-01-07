# Patching Playbook

## Objective
Keep systems secure while minimising business impact.

## Maintenance window
- Ring 0: IT pilot
- Ring 1: 50%
- Ring 2: remaining

## Pre-checks
- Backup/restore point verified
- Known issues reviewed
- Change record created + comms sent
- Monitoring in place (alerts, dashboards)

## Execution
- Apply updates
- Reboot as required
- Record update KBs and timestamps

## Post-checks
- Auth + core apps verification
- Service health check
- Confirm no error spikes in logs

## Evidence
Attach patch report output:
- `scripts/powershell/patching-report.ps1`
