targetScope = 'resourceGroup'

param location string
param projectName string
param environment string

var vnetName = 'vnet-${projectName}-${environment}'
var addressSpace = '10.10.0.0/16'

resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: { addressPrefixes: [ addressSpace ] }
    subnets: [
      { name: 'snet-web'  properties: { addressPrefix: '10.10.1.0/24' } }
      { name: 'snet-data' properties: { addressPrefix: '10.10.2.0/24' } }
      { name: 'snet-mgmt' properties: { addressPrefix: '10.10.3.0/24' } }
    ]
  }
}

output vnetId string = vnet.id
output snetWebId string = vnet.properties.subnets[0].id
output snetDataId string = vnet.properties.subnets[1].id
output snetMgmtId string = vnet.properties.subnets[2].id
