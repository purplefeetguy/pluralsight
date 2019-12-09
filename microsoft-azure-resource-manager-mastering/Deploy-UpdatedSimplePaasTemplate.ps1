### Define Deployment Variables
{
$location = 'North Central US'
$resourceGroupName = 'pfl-simple-paas-template'
$resourceDeploymentName = 'pfl-paas-template-deployment'
#$templatePath = $env:SystemDrive + '\' + 'pluralsight'
$templatePath = $home + '\Development\Training\' + 'Azure\ARM\pluralsight-Mastering_Azure_Resource_Manager\' + 'pluralsight\microsoft-azure-resource-manager-mastering'
$templateFile = 'UpdatedsimplePaasTemplate.json'
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