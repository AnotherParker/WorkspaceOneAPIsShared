
. ..\Core\ConnectionStrings.ps1

#################################
# Token Access
#################################

$header = @{
    'Content-type' = 'application/x-www-form-urlencoded'
}

####################################
# Change here for Cert or Prod
###################################

$Environment = "Cert"

if ($environment -match "Prod"){

$body = @{
                'client_ID' = ($clientIdProd | convertfrom-securestring -AsPlainText)
                'client_secret' = (clientsecretprod | ConvertFrom-SecureString -asplaintext)
                    'Grant_type' = "client_Credentials"
}

$apikey = (Apikeyprod | Convertfrom-securestring -asplaintext)
$apiHost = $(apihostprod)
}
Elseif ($environment -match "Cert"){
    $body = @{
        'client_ID' = ($ClientIDCert | convertfrom-securestring -AsPlainText)
        'client_secret' = ($clientSecretCert | ConvertFrom-SecureString -asplaintext)
            'Grant_type' = "client_Credentials"
}
$apikey = ($ApiKeyCert | Convertfrom-securestring -asplaintext)
$apiHost = $(apihostprod)
}

try {
$response = invoke-restmethod $resturl -method 'post' -headers $headers -Body $body
$token = $response.access_token
$AuthorizationHeader = "brearer $token"

}
Catch {
    write-error $_.Exception.Message
}
$body = ""
$Response = ""
$Token = ""