# SEV1: Authentication Outage (M365 / Entra)

## Severity definition
SEV1 when:
- Users cannot authenticate to core M365 apps at scale OR admin access blocked OR widespread MFA failure.

## First 10 minutes (triage)
1. Confirm scope: affected apps (Teams/Outlook/SharePoint), regions, device types.
2. Check Microsoft 365 Service Health (admin center) and any advisories.
3. Check Entra sign-in logs (if available):
   - Are failures spiking? Any common error code?
4. Validate break-glass admin access (do NOT use unless necessary).
5. Freeze changes: pause non-essential deployments.

## Containment & mitigation
- If Conditional Access change suspected:
  - Identify last CA policy changes (Azure Activity / change PR)
  - Roll back via known-good policy state (use change records)
- If sync issue suspected:
  - Validate Entra Connect/Cloud Sync health (agent/service)
- If network issue suspected:
  - Validate DNS resolution for login endpoints
  - Escalate to network team with evidence checklist

## Recovery steps
- Revert high-risk changes first (CA policies, DNS, proxy/firewall rules)
- Validate sign-in with test users across locations
- Monitor sign-in failure trend for 30 minutes

## Validation checklist
- Successful sign-in: Teams, Outlook, SharePoint
- Admin portal access stable
- No continuing spikes in failed sign-ins

## Communications cadence
- Every 15 minutes during SEV1
- Provide: impact, actions taken, next ETA checkpoint, workaround

## PIR requirements
- Root cause category (policy/change/provider/network)
- What detection signal failed?
- Preventative actions (alerts, change gates, peer review)
