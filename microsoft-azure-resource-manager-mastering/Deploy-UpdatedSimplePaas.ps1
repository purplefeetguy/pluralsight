﻿
### Define Deployment Variables
{

    $resourceGroupName = 'pfl-simple-paas'
    $resourceProviderNamespace = 'Microsoft.Web'
    $resourceTypeName = 'sites'
    $resourceGroupLocation = 'North Central US'

    $randomString = ([char[]]([char]'a'..[char]'z') + 0..9 | Sort-Object { Get-Random })[0..8] -join ''
    $appNamePrefix = 'pfl'
    $appServicePlanName = $appNamePrefix + $randomString
    $webAppName = $appNamePrefix + $randomString

}

### Get ARM Provider Locations

{

    ((Get-AzResourceProvider `
                -ProviderNamespace "$resourceProviderNamespace").ResourceTypes | `
            Where-Object { $_.ResourceTypeName -eq "$resourceTypeName" }).Locations | `
        Sort-Object

}

### Create ARM Resource Group

{

    New-AzResourceGroup `
        -Name $resourceGroupName `
        -Location $resourceGroupLocation `
        -Verbose -Force

}

### Create App Service Plan

{
    $appServicePlan = New-AzAppServicePlan `
        -ResourceGroupName $resourceGroupName `
        -Location $resourceGroupLocation `
        -Name $appServicePlanName `
        -Tier Standard `
        -WorkerSize Small `
        -Verbose

}

### Create Web App

{

    New-AzWebApp `
        -ResourceGroupName $resourceGroupName `
        -Location $resourceGroupLocation `
        -AppServicePlan $appServicePlan.ServerFarmWithRichSkuName `
        -Name $webAppName `
        -Verbose

}