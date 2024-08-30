using namespace System.Net
using namespace Azure.CosmosDB


param($Request, $WebsiteCounter)



#[CosmosClient]::new($endpoint, $key)

Write-Host 'PowerShell HTTP trigger function processed a request'



if (-not $WebsiteCounter) { 
    Write-Host 'a bunch of '

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
            StatusCode = [HttpStatusCode]::NotFound 
            Body       = $ToDoItem.Description 
        })

}
else {



    Write-Host "Found Counter item, Description=$($WebsiteCounter.Count)"

    $counter = [int]($WebsiteCounter.Count)
    $updatedCount = $counter + 1

    Write-Host "This has been viewed " $updatedCount " times."

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
            StatusCode  = [HttpStatusCode]::OK 
            ContentType = "application/json"
            Body        = @{"count" = $updatedCount }
        }) 

        
        
}
# this is working now. need to put this to just 1/1 for the counter and make the function to return the trigger and output it +1`
From function.json

{
    "name": "InputDocumentOut",
    "type": "CosmosDB",
    "databaseName": "ToDoItems",
    "collectionName": "Items",
    "createIfNotExists": false,
    "partitionKey": "{queueTrigger_payload_property}",
    "connectionStringSetting": "CosmosDBConnection",
    "direction": "out"
},






try {
    $query = "SELECT * FROM c WHERE c.id='$documentId'"
    
    $iterator = $container.GetItemQueryIterator([QueryDefinition]::new($query))

    $results = @()
    
    while ($iterator.HasMoreResults) {
        $response = $iterator.ReadNextAsync().Result
        $results += $response.Resource
    }
    $Response = @{
        status = 200
        body   = $results
    }
}
catch {
    $Response = @{
        status = 500
        body   = "Error retrieving data from CosmosDB"
    }
}
return $Response

# # Write to the Azure Functions log stream.
# Write-Host "PowerShell HTTP trigger function processed a request."

# # Interact with query parameters or the body of the request.
# $name = $Request.Query.Name
# if (-not $name) {
#     $name = $Request.Body.Name
# }

# $body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

# if ($name) {
#     $body = "Hello, $name. This HTTP triggered function executed successfully."
# }

# # Associate values to output bindings by calling 'Push-OutputBinding'.
# Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
#     StatusCode = [HttpStatusCode]::OK
#     Body = $body
# })
