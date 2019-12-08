### Define Deployment Variables
{
$location = 'North Central US'
$resourceGroupName = 'pfl-simple-iaas-template'
$resourceDeploymentName = 'pfl-iaas-template-deployment'
#$templatePath = $env:SystemDrive + '\' + 'pluralsight'
$templatePath = 'C:\Users\purpl\Development\Training\Azure\ARM\pluralsight-Mastering_Azure_Resource_Manager\pluralsight\microsoft-azure-resource-manager-mastering'
$templateFile = 'updatedsimpleiaas.json'
$template = $templatePath + '\' + $templateFile
}

### Create Resource Group
{
New-AzResourceGroup `
    -Name $resourceGroupName `
    -Location $location `
    -Verbose -Force
}

### Deploy Resources
{
New-AzResourceGroupDeployment `
    -Name $resourceDeploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $template `
    -Verbose -Force
}