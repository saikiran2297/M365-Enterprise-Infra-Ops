targetScope = 'resourceGroup'

param location string
param projectName string
param environment string

var saName = toLower('sa${uniqueString(resourceGroup().id, projectName, environment)}')

resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: saName
  location: location
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
  }
}

output storageAccountName string = sa.name
output storageAccountId string = sa.id
