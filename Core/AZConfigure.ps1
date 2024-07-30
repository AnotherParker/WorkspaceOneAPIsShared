#This is used to configure Azure AD Connect and allow the scripts to access keyvaults
#Access to a keyvault is required

set-executionpolicy -executionpolicy remotesigned -scope CurrentUser
Get-executionpolicy -list
Install-module -Name Az -Repository PSGallery -Force
Connect-azaccount