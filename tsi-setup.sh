echo off

az login --use-device-code

spName='TSI-SP'
servicePrincipalAppId=$(az ad app create --display-name $spName --identifier-uris "https://$spName"  --oauth2-allow-implicit-flow true --required-resource-accesses '[{"resourceAppId":"120d688d-1518-4cf7-bd38-182f158850b6","resourceAccess":[{"id":"a3a77dfe-67a4-4373-b02a-dfe8485e2248","type":"Scope"}]}]' --query appId -o tsv)
servicePrincipalObjectId=$(az ad sp create --id $servicePrincipalAppId --query objectId -o tsv)
servicePrincipalSecret=$(az ad app credential reset --id $servicePrincipalAppId --credential-description "TSI Token" --query password -o tsv)
servicePrincipalTenantId=$(az ad sp show --id $servicePrincipalAppId --query appOwnerTenantId -o tsv)
echo 'Service Principal App Id    : ' $servicePrincipalAppId
echo 'Service Principal Password  : ' $servicePrincipalSecret
echo 'Service Principal Tenant Id : ' $servicePrincipalTenantId
echo 'Service Principal Object Id : ' $servicePrincipalObjectId