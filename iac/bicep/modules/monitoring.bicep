targetScope = 'resourceGroup'

param location string
param projectName string
param environment string

var lawName = 'law-${projectName}-${environment}'
var agName = 'ag-${projectName}-${environment}'

resource law 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: lawName
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
  }
}

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: agName
  location: 'global'
  properties: {
    groupShortName: 'OpsAG'
    enabled: true
    emailReceivers: [
      {
        name: 'OpsEmail'
        emailAddress: 'replace-me@example.com'
        useCommonAlertSchema: true
      }
    ]
  }
}

output workspaceId string = law.id
output actionGroupId string = actionGroup.id
