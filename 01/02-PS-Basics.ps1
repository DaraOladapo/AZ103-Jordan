# change directory/Set location
$Path="C:\"
Set-Location $Path #or chdir

# Do Maths
$Value1=5
$Value2=2
$Value3=$Value1+$Value2
Write-Output "The sum of $Value1 and $Value2 = $Value3"

# clear host
cls
Clear-Host

# Get Running Services
Get-Service

# Set Alias for Service
Set-Alias -Name gsvc -Value Get-Service

# Get Stopped Services
gsvc | Where-Object {$_.status -eq "stopped"}

# Get Running Services
gsvc | Where-Object {$_.status -eq "running"}

# get running services with filter
# gsvc | Where-Object {$_.displayname -contains 'Adobe'}

# List Commands
get-command

# get help
get-help

get-help Get-Service

get-help Get-Service -online

# Get script excecution policy
Get-ExecutionPolicy

# Set Execution policy (Run PowerShell as admin)
Set-ExecutionPolicy Unrestricted

# Get Process list
Get-Process

# Get a specific process or list of processes using wildcard
Get-Process -processname note*

# Convert to secure string
$SomeString='Lorem Ipsum dolum kishom'
ConvertTo-SecureString -String $SomeString -AsPlainText -Force

# Select object
Get-Process | Sort-Object name -Descending | Select-Object -Index 0,1,2,3,4

