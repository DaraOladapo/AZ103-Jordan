Install-Module 'PSDscResources'
param
(
    [string[]]$ComputerName='localhost'
)
#Import-DscResource -ModuleName 'PSDscResources'

Configuration MyDscConfiguration {
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Node $ComputerName {

        Environment CreatePathEnvironmentVariable
        {
            Name = 'TestPathEnvironmentVariable'
            Value = 'TestValue'
            Ensure = 'Present'
            Path = $true
        }
    }
}

MyDscConfiguration  -OutputPath:"C:\Configs\EnvVar"