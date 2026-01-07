targetScope = 'resourceGroup'

param location string
param projectName string
param environment string
param vnetId string
param snetWebId string
param snetDataId string
param snetMgmtId string

var nsgWebName  = 'nsg-${projectName}-${environment}-web'
var nsgDataName = 'nsg-${projectName}-${environment}-data'
var nsgMgmtName = 'nsg-${projectName}-${environment}-mgmt'

resource nsgWeb 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: nsgWebName
  location: location
  properties: {
    securityRules: [
      // Allow HTTPS inbound (example for web tier)
      {
        name: 'Allow-HTTPS-In'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
        }
      }
      // Deny all inbound (explicit)
      {
        name: 'Deny-All-In'
        properties: {
          priority: 4096
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource nsgData 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: nsgDataName
  location: location
  properties: {
    securityRules: [
      // Allow SQL from web subnet only (example)
      {
        name: 'Allow-SQL-From-Web'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '1433'
          sourceAddressPrefix: '10.10.1.0/24'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'Deny-All-In'
        properties: {
          priority: 4096
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource nsgMgmt 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: nsgMgmtName
  location: location
  properties: {
    securityRules: [
      // Allow RDP from your public IP only (replace with your IP for real usage)
      {
        name: 'Allow-RDP-In'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '0.0.0.0/0'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'Deny-All-In'
        properties: {
          priority: 4096
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource webAssoc 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' = {
  name: '${split(last(split(snetWebId, '/subnets/')), '/')[0]}/snet-web'
  parent: resourceId('Microsoft.Network/virtualNetworks', split(last(split(snetWebId, '/subnets/')), '/')[0])
  properties: {
    networkSecurityGroup: { id: nsgWeb.id }
  }
}

resource dataAssoc 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' = {
  name: '${split(last(split(snetDataId, '/subnets/')), '/')[0]}/snet-data'
  parent: resourceId('Microsoft.Network/virtualNetworks', split(last(split(snetDataId, '/subnets/')), '/')[0])
  properties: {
    networkSecurityGroup: { id: nsgData.id }
  }
}

resource mgmtAssoc 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' = {
  name: '${split(last(split(snetMgmtId, '/subnets/')), '/')[0]}/snet-mgmt'
  parent: resourceId('Microsoft.Network/virtualNetworks', split(last(split(snetMgmtId, '/subnets/')), '/')[0])
  properties: {
    networkSecurityGroup: { id: nsgMgmt.id }
  }
}

output nsgWebId string = nsgWeb.id
output nsgDataId string = nsgData.id
output nsgMgmtId string = nsgMgmt.id
