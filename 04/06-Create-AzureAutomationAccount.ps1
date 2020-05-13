# Variables for common values
$resourceGroup = "myResourceGroup"
$location = "westeurope"
$automationAccountName = "myAutomationAccount"

New-AzAutomationAccount -Name $automationAccountName `
-Location $location `
-ResourceGroupName $resourceGroup
