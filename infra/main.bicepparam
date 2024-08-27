using './main.bicep'

param accountName = 'azureresume-celleray'
param databaseName = 'AzureResume'
param containerName = 'Counter'

param partitionKeyPath = '/id'
