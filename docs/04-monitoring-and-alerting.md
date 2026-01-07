# Monitoring, Logs, Capacity

## Tooling (lab)
- Log Analytics workspace (central log store)
- Azure Monitor alerts (platform metrics + activity logs)
- Action group (email/webhook placeholders)

## What we monitor
- Platform: resource health, deployment failures, RBAC changes
- VM health: heartbeat, CPU, disk space, service status (where available)
- Identity signals (document approach): risky sign-ins, CA failures (tenant-dependent)

## KQL library
See: `scripts/powershell/log-analytics-query-library.kql`

## Proactive operations
- Weekly capacity review: CPU/memory/disk trends
- Alert tuning: remove noisy alerts, add meaningful thresholds
- Blameless trend analysis and preventative actions
