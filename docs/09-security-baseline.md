# Security Baseline

## Identity
- Separate admin accounts
- Break-glass accounts (documented)
- MFA required for privileged roles
- Conditional Access strategy (document)

## Infrastructure
- NSGs deny-by-default inbound
- Least privilege RBAC in Azure
- Log retention and audit trail (Log Analytics + Activity Logs)

## Repo hygiene
- Secret scanning workflow enabled
- No credentials committed
- Example configs use placeholders only
