﻿
### Define Deployment Variables
{
$resourceGroupName = 'pfl-simple-iaas'
$resourceProviderNamespace = 'Microsoft.Network'
$resourceTypeName = 'virtualNetworks'
$resourceGroupLocation = 'North Central US'

$vNetName = 'vnet-pfl'
$vNetAddressPrefix = '172.16.0.0/16'
$vNetSubnet1Name = 'subnet-1'
$vNetSubnet1Prefix = '172.16.1.0/24'
$vNetSubnet2Name = 'subnet-2'
$vNetSubnet2Prefix = '172.16.2.0/24'

$randomString = ([char[]]([char]'a'..[char]'z') + 0..9 | Sort-Object {Get-Random})[0..8] -join ''
$storageAccountNamePrefix = 'storage'
$storageAccountType = 'Standard_LRS'
$storageAccountName = $storageAccountNamePrefix + ($storageAccountType.Replace('Standard_','')).ToLower() + $randomString
}

### Get ARM Provider Locations
{
((Get-AzResourceProvider `
    -ProviderNamespace "$resourceProviderNamespace").ResourceTypes | `
    Where-Object {$_.ResourceTypeName -eq "$resourceTypeName"}).Locations | `
    Sort-Object
}

### Create ARM Resource Group
{
$resourceGroup = New-AzResourceGroup `
    -Name $resourceGroupName `
    -Location $resourceGroupLocation `
    -Verbose -Force
}

### Create Virtual Network Subnets
{
$vNetSubnet1 = New-AzVirtualNetworkSubnetConfig `
    -Name $vNetSubnet1Name `
    -AddressPrefix $vNetSubnet1Prefix `
    -Verbose

$vNetSubnet2 = New-AzVirtualNetworkSubnetConfig `
    -Name $vNetSubnet2Name `
    -AddressPrefix $vNetSubnet2Prefix `
    -Verbose
}

### Create Virtual Network
{
$vNet = New-AzVirtualNetwork `
    -ResourceGroupName $resourceGroup.ResourceGroupName `
    -Location $resourceGroup.Location `
    -Name $vNetName `
    -AddressPrefix $vNetAddressPrefix `
    -Subnet $vNetSubnet1,$vNetSubnet2 `
    -Verbose -Force
}

### Create Storage Account
{
$storageAccount = New-AzStorageAccount `
    -ResourceGroupName $resourceGroup.ResourceGroupName `
    -Location $resourceGroup.Location `
    -Name $storageAccountName `
    -Type $storageAccountType `
    -Verbose
}