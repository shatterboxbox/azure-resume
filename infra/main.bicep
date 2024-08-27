targetScope = 'subscription'

@description('Azure Cosmos DB account name')
param accountName string

@description('Location for the deployment.')
param location string = deployment().location

@description('The name for the database')
param databaseName string = 'database1'

@description('The name for the container')
param containerName string = 'container1'

@description('The partition key for the container')
param partitionKeyPath string

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' existing = {
  name: 'rg-azureresume'
  scope: subscription()
}

module cosmosDB 'cosmosdb.bicep' = {
  name: 'cosmosDB'
  scope: resourceGroup(rg.name)
  params: {
    accountName: accountName
    location: location
    databaseName: databaseName
    containerName: containerName

    partitionKeyPath: partitionKeyPath
  }
}
