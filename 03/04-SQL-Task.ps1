# Connect-AzAccount
# The SubscriptionId in which to create these objects
##$SubscriptionId = ''
# Set the resource group name and location for your source server
$sourceResourceGroupName = "mySourceResourceGroup-$(Get-Random)"
$sourceResourceGroupLocation = "westus2"
# Set the resource group name and location for your target server
$targetResourceGroupname = "myTargetResourceGroup-$(Get-Random)"
$targetResourceGroupLocation = "eastus"
# Set an admin login and password for your server
$adminSqlLogin = "SqlAdmin"
$password = "P@ssw0rd123"
# The logical server names have to be unique in the system
$sourceServerName = "source-server-$(Get-Random)"
$targetServerName = "target-server-$(Get-Random)"
# The sample database name
$sourceDatabaseName = "mySampleDatabase"
$targetDatabaseName = "CopyOfMySampleDatabase"
# The ip address range that you want to allow to access your servers
$sourceStartIp = "197.211.61.0"
$sourceEndIp = "197.211.61.255"
$targetStartIp = "197.211.61.0"
$targetEndIp = "197.211.61.255"

# Set subscription 
#Set-AzContext -SubscriptionId $subscriptionId 

# Create two new resource groups
New-AzResourceGroup -Name $sourceResourceGroupName -Location $sourceResourceGroupLocation
New-AzResourceGroup -Name $targetResourceGroupname -Location $targetResourceGroupLocation

# Create a server with a system wide unique server name
New-AzSqlServer -ResourceGroupName $sourceResourceGroupName `
    -ServerName $sourceServerName `
    -Location $sourceResourceGroupLocation `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
New-AzSqlServer -ResourceGroupName $targetResourceGroupname `
    -ServerName $targetServerName `
    -Location $targetResourceGroupLocation `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))

# Create a server firewall rule that allows access from the specified IP range
New-AzSqlServerFirewallRule -ResourceGroupName $sourceResourceGroupName `
    -ServerName $sourceServerName `
    -FirewallRuleName "AllowedIPs" -StartIpAddress $sourcestartip -EndIpAddress $sourceEndIp
 New-AzSqlServerFirewallRule -ResourceGroupName $targetResourceGroupname `
    -ServerName $targetServerName `
    -FirewallRuleName "AllowedIPs" -StartIpAddress $targetStartIp -EndIpAddress $targetEndIp

# Create a blank database in the source-server with an S0 performance level
New-AzSqlDatabase  -ResourceGroupName $sourceResourceGroupName `
    -ServerName $sourceServerName `
    -DatabaseName $sourceDatabaseName -RequestedServiceObjectiveName "S0" `
    -SampleName "AdventureWorksLT"

# Copy source database to the target server 
New-AzSqlDatabaseCopy -ResourceGroupName $sourceResourceGroupName `
    -ServerName $sourceServerName `
    -DatabaseName $sourceDatabaseName `
    -CopyResourceGroupName $targetResourceGroupname `
    -CopyServerName $targetServerName `
    -CopyDatabaseName $targetDatabaseName 

# Clean up deployment 
# Remove-AzResourceGroup -ResourceGroupName $sourceResourceGroupName
# Remove-AzResourceGroup -ResourceGroupName $targetResourceGroupname