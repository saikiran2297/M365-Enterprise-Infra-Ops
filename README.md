# M365 Enterprise Infra Ops Lab (Portfolio)

This repository demonstrates real-world **Microsoft 365 + Identity + Infrastructure Operations** skills aligned to a senior (3rd-line) M365/Infrastructure Engineer role:
- Hybrid identity: **Active Directory + Microsoft Entra ID**
- Secure network design: **VNet/Subnets/NSGs + optional Azure Firewall pattern**
- Operations: **monitoring, patching, lifecycle management**
- **3rd-line escalation**: incident runbooks, recovery playbooks, PIRs
- **Change management**: risk assessment, approvals, rollbacks
- Continuous improvement: automation, standardisation, integration

> ⚠️ Safety: This repo is designed to avoid secrets. Use placeholders. Never commit tenant IDs, real domains, keys, or user data.

---

## Responsibilities → Evidence Map

| Expected Responsibility | Where it is demonstrated |
|---|---|
| Enterprise infrastructure services (servers/virtualisation/storage/identity/cloud) | `docs/01-architecture.md`, `iac/bicep/*`, `docs/02-identity-ad-entra.md` |
| 3rd line escalation / outage leadership | `runbooks/incidents/*`, `docs/06-incident-management-runbooks.md` |
| AD + Entra ID admin (users/groups/devices/sync/auth policies) | `docs/02-identity-ad-entra.md`, `scripts/powershell/*` |
| Network/firewall operations | `docs/03-network-and-firewall.md`, `iac/bicep/modules/network.bicep`, `iac/bicep/modules/security.bicep` |
| Patching + lifecycle management | `docs/05-patching-and-lifecycle.md`, `runbooks/operations/patching-playbook.md` |
| Monitoring + logs + capacity | `docs/04-monitoring-and-alerting.md`, `scripts/powershell/log-analytics-query-library.kql` |
| Change management (risk/doc/rollback/preventative actions) | `docs/07-change-management.md`, `.github/PULL_REQUEST_TEMPLATE.md`, `runbooks/changes/*` |
| Continuous improvement (automation/standardisation/integration) | `docs/08-continuous-improvement-automation.md`, `scripts/*`, `.github/workflows/*` |

---

## Quickstart (Azure IaC)

### Prerequisites
- Azure subscription
- Azure CLI + Bicep
- PowerShell 7 (recommended)

### Deploy (Bicep)
```bash
az login
az account set --subscription "<SUBSCRIPTION_ID>"
az group create -n rg-m365-infra-lab -l uksouth

az deployment group create \
  -g rg-m365-infra-lab \
  -f iac/bicep/main.bicep \
  -p @iac/bicep/parameters/dev.parameters.json
