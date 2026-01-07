# Architecture

## Overview
This lab models a typical enterprise hybrid environment:
- On-prem simulation: Windows Server VM hosting AD DS/DNS (virtualisation platform of choice)
- Cloud: Azure resource group with VNet, subnets, security controls, monitoring, storage, and a jump host
- Identity: Microsoft Entra ID with documented sync and authentication policy approach
- Ops: monitoring, patching, incident response and change management

## Logical components
- Identity
  - AD DS (users/devices/groups/GPO concept)
  - Entra ID (users/groups/devices/CA design)
  - Sync (Entra Connect / Cloud Sync)
- Network
  - VNet + separate subnets: web/app, data, management
  - NSGs and “deny by default” approach
  - Optional firewall pattern
- Monitoring
  - Log Analytics workspace
  - Azure Monitor alerts (VM health, platform signals)
  - Action group (email/webhook placeholder)
- Storage
  - Storage account (log archive / scripts output / backups - design)
- Compute
  - Jump host VM (optional) OR use Bastion (optional)

## Data flows (high level)
1. User/device objects managed in AD/Entra
2. Sync service replicates identities to Entra
3. Secure connectivity enforced via NSGs and optional firewall
4. Logs/metrics ingested into Log Analytics for alerting & dashboards
