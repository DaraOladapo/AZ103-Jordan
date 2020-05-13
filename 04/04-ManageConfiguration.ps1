#Install-Module 'PSDscResources'

Configuration IIS
{
    #Import-DscResource -ModuleName 'PSDscResources'
    Node $env:ComputerName
    {
        WindowsFeature IIS {
            Ensure = 'Present'
            Name = 'Web-Server'
        }
    }
}


IIS -OutputPath:"C:\Configs\ServerFeatures"