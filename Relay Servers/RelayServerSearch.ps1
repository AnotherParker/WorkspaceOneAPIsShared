. ..\Core\ConnectionStrings.ps1
. ..\Core\OauthConnection.ps1
. ..\Core\RelayCredentials.ps1

##############################
# Command Run
##############################

$headers2 = @{
    'Accept' = 'application/json;version=2'
    'Authorization' = $AuthorizationHeader
    'aw-tenant-code' = $apikey
    "Content-Type" = "application/json"
}

$Headers3 = @{
    'Accept' = 'application/json;version=2'
    'Authorization' = $AuthorizationHeader
    'aw-tenant-code' = $apikey
    "Content-Type" = "application/json"
}

# For each will need cahnging on how many you want to do 0 is the beginning e.g. 700 will do 0 to 700 in its DB

    try{
        $groupsresponse = invoke-restmethod -uri "https://$apihost/api/mdm/relayservers/6" - headers $headers2
    } catch {write-error $_.Exception.Message}

Write-Host $groupsresponse

. ..\Core\wipe.ps1