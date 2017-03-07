#Requires -RunAsAdministrator
#Requires -Version 5
## Author: Andrew Critchley
## Date: 19/12/2016
## Description:
#### Template for my basic development environment

Import-Module .\refreshenv.ps1

Set-ExecutionPolicy RemoteSigned

## Install chocolatey and puppet agent

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

refreshenv

choco install puppet-agent -y

refreshenv

## Install puppet modules

puppet module install puppetlabs-chocolatey --version 2.0.0
puppet module install basti1302-windows_path --version 0.1.1
puppet module install puppetlabs-vcsrepo --version 1.5.0
puppet module install puppetlabs-dsc --version 1.2.0
puppet module install puppet-windows_autoupdate --version 1.2.0
puppet module install puppet-iis --version 3.0.0

puppet apply manifests/site.pp --verbose

## Install Visual Studio Code Extensions

$vsCodeExtensions = @(
    "Borke.puppet",
    "donjayamanne.python",
    "ms-vscode.csharp",
    "ms-vscode.PowerShell"
)

$vsCodeExtensions | % { 
    Write-Host "Installing VSCode Extension $_..."
    code --install-extension $_ 
}

## Install Windows Features

$windowsFeatures = @(
    "IIS-WebServer",
    "IIS-StaticContent",
    "IIS-ASPNET45",
    "IIS-WebSockets"
)

$windowsFeatures | % { 
    Write-Host "Enabling $_..."
    DISM /online /enable-feature /featurename:$_ 
}