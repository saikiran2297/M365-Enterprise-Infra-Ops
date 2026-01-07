targetScope = 'resourceGroup'

@description('Deployment location')
param location string = resourceGroup().location

@description('Project prefix for naming')
param projectName string = 'm365infralab'

@allowed([
  'dev'
  'prod'
])
param environment string = 'dev'

@description('Admin username for jump host (if enabled)')
param adminUsername string = 'azureadmin'

@secure()
@description('Admin password for jump host (if enabled)')
param adminPassword string

@description('Deploy a small jump host VM for ops validation')
param deployJumpHost bool = true

module network 'modules/network.bicep' = {
  name: '${projectName}-network'
  params: {
    location: location
    projectName: projectName
    environment: environment
  }
}

module security 'modules/security.bicep' = {
  name: '${projectName}-security'
  params: {
    location: location
    projectName: projectName
    environment: environment
    vnetId: network.outputs.vnetId
    snetWebId: network.outputs.snetWebId
    snetDataId: network.outputs.snetDataId
    snetMgmtId: network.outputs.snetMgmtId
  }
}

module monitoring 'modules/monitoring.bicep' = {
  name: '${projectName}-monitoring'
  params: {
    location: location
    projectName: projectName
    environment: environment
  }
}

module storage 'modules/storage.bicep' = {
  name: '${projectName}-storage'
  params: {
    location: location
    projectName: projectName
    environment: environment
  }
}

module compute 'modules/compute.bicep' = if (deployJumpHost) {
  name: '${projectName}-compute'
  params: {
    location: location
    projectName: projectName
    environment: environment
    adminUsername: adminUsername
    adminPassword: adminPassword
    snetMgmtId: network.outputs.snetMgmtId
  }
}

output vnetId string = network.outputs.vnetId
output logAnalyticsWorkspaceId string = monitoring.outputs.workspaceId
