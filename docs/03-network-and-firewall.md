# Network and Firewall Operations

## Principles
- Least privilege, deny-by-default inbound
- Segmentation by function (mgmt/web/data)
- Clear escalation handoffs to specialist network engineers

## Addressing (example)
- VNet: 10.10.0.0/16
- snet-web: 10.10.1.0/24
- snet-data: 10.10.2.0/24
- snet-mgmt: 10.10.3.0/24

## Security Controls
- NSGs applied at subnet level
- Allow mgmt subnet to RDP/SSH to workloads (lab)
- Restrict data subnet to only required inbound from web/app subnet
- Optional Azure Firewall design: central egress, DNS proxy, logging

## Escalation checklist (what you send to network team)
- Impacted services, time started, scope (#users/regions)
- Traceroute/ping results, DNS resolution checks
- Firewall deny logs (if available), NSG flow logs
- Change correlation: any deployments/patches in last 60 minutes
