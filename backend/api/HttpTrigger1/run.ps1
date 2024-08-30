using namespace System.Net
using namespace Azure.CosmosDB


param($Request, $inputCounter)



#[CosmosClient]::new($endpoint, $key)

Write-Host 'PowerShell HTTP trigger function processed a request'



if (-not $inputCounter) { 
    Write-Host 'a bunch of '

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
            StatusCode = [HttpStatusCode]::NotFound 
            Body       = $ToDoItem.Description 
        })

}
else {

    Write-Host "Found Counter item, Description=$($inputCounter.Count)"

    #Get the count from Database, add 1 for view
    $counter = [int]($inputCounter.count)
    $updatedCount = $counter + 1
    $outputData = @{ id = "Counter"; count = $updatedCount }


    Write-Host "This has been viewed " $updatedCount " times."



    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
            StatusCode = [HttpStatusCode]::OK 
            #ContentType = "application/json"
            Body       = $updatedCount
            
        }) 

    Push-OutputBinding -Name outputCounter -Value $outputData
      
        
}