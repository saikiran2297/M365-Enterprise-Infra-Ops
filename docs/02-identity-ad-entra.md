# Identity: Active Directory + Microsoft Entra ID

## AD Design (lab/on-prem simulation)
Recommended OU layout:
- OU=Corp
  - OU=Users
  - OU=Devices
  - OU=Groups
  - OU=Admins
  - OU=ServiceAccounts

Group strategy:
- Role-based groups (e.g., GRP-App-XYZ-Users)
- Admin separation (GRP-Admin-Workstation, GRP-Admin-Server)
- Avoid nesting complexity unless required

## Entra ID (Azure AD) administration
Core operations to demonstrate:
- User & group lifecycle: joiners/movers/leavers
- Device lifecycle: stale device cleanup process
- Authentication policies: MFA/Conditional Access approach (documented safely)

## Sync (choose one)
### Option A: Entra Connect (classic)
- Best for deeper hybrid scenarios
- Document: staging mode, scheduler, connectors, export errors

### Option B: Entra Cloud Sync
- Lighter footprint, modern approach (where applicable)
- Document: agent health, scoping filters

## Conditional Access design (safe portfolio)
- Break-glass accounts (2) with strong controls + monitoring
- Admin role accounts separate from daily accounts
- Require MFA for admins; require compliant device for sensitive apps (document)
- Block legacy authentication (document)

## Troubleshooting playbook references
- Sync failure runbook: `runbooks/incidents/entra-connect-sync-failure.md`
- Auth outage runbook: `runbooks/incidents/sev1-auth-outage.md`
