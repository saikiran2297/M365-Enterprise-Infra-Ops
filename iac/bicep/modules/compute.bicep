targetScope = 'resourceGroup'

param location string
param projectName string
param environment string
param adminUsername string
@secure()
param adminPassword string
param snetMgmtId string

var nicName = 'nic-${projectName}-${environment}-jump'
var vmName  = 'vm-${projectName}-${environment}-jump'

resource pip 'Microsoft.Network/publicIPAddresses@2023-11-01' = {
  name: 'pip-${projectName}-${environment}-jump'
  location: location
  sku: { name: 'Standard' }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-11-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: { id: pip.id }
          subnet: { id: snetMgmtId }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: { vmSize: 'Standard_B2s' }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: { storageAccountType: 'Standard_LRS' }
      }
    }
    networkProfile: {
      networkInterfaces: [
        { id: nic.id }
      ]
    }
  }
}

output jumpHostPublicIpId string = pip.id
output jumpHostVmId string = vm.id
