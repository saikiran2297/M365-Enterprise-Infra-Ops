# Entra Connect / Cloud Sync Failure

## Symptoms
- New users not appearing in Entra
- Password changes not syncing
- Export errors / connector errors
- Helpdesk reports login or licensing anomalies

## Quick triage
1. Confirm last successful sync time (server/agent dashboard).
2. Check service status on sync server/agent:
   - Entra Connect: ADSync service running?
3. Check disk space/CPU on sync host.
4. Check recent changes:
   - OU filtering, attribute mapping, UPN suffix changes
5. Review errors:
   - Duplicate attributes (UPN/proxyAddresses)
   - Permission issues on AD objects

## Recovery actions (safe order)
1. Restart sync service (if appropriate) and re-check health
2. Resolve duplicate attribute conflicts (document the fix)
3. If the server is unstable:
   - Failover to staging mode server (if designed)
   - Engage vendor/Microsoft support with logs

## Validation
- Create test user in scoped OU → confirm appears in Entra
- Reset test user password → confirm hash sync (time-bound)
- Confirm no ongoing export errors

## Preventative actions
- Alerts on “last sync time”
- Change control for OU filter and attribute mapping changes
- Documented staging mode/failover design (if applicable)
