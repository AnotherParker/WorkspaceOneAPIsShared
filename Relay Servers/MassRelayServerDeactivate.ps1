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

Foreach ($Relay in 0..700){
    try{
        $groupsresponse = invoke-restmethod -uri "https://$apihost/api/mdm/relayservers/$relay" - headers $headers2
    } catch {}

Write-host '-------------'
Write-host 'starting validations'
Write-host $groupsresponse.general.name 'Relay is set to' $groupsresonse.general.active

#If the relay is True / online do this

if ($groupsresponse.general.active -contains "True") {
    write-host 'Amending Database'
    #Changes the relay to 'False' / Offline
    $groupsresponse.general.active = "False"
    $groupsresponse.deviceconnection.password = ($relayacc | convertfrom-securestring -asplaintext)
    write-host $groupsresponse.deviceconnection.hostname
}

$groupsresponse2 = $groupsresponse | ConvertTo-Json

Try {
    invoke-restmethod -method put -uri "https://$apihost/api/mdm/relayservers" -Headers $headers2 -body $groupsresponse2
}
Catch {
    Write-host 'Error Not Amended'
    Write-error ($_ | Format-List * -Force | Out-String)
}
}

. ..\core\wipe.ps1