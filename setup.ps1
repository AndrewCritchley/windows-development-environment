#Requires -RunAsAdministrator
#Requires -Version 5
## Author: Andrew Critchley
## Date: 19/12/2016
## Description:
#### Template for my basic development environment

Import-Module .\refreshenv.ps1
Import-Module .\check-command.ps1

Set-ExecutionPolicy RemoteSigned

## Install chocolatey and puppet agent

$isChocoInstalled = Check-Command choco
if($isChocoInstalled -eq $true) {
	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
	Write-Host "Chocolatey already installed, skipping..."
}

refreshenv

choco install puppet-agent -y

refreshenv

## Install puppet modules

$puppetModules = @(
    @{ module = "puppetlabs-chocolatey"; version = "2.0.0" },
    @{ module = "basti1302-windows_path"; version = "0.1.1" },
    @{ module = "puppetlabs-vcsrepo"; version = "1.5.0" },
    @{ module = "puppetlabs-dsc"; version = "1.2.0" },
    @{ module = "puppet-windows_autoupdate"; version = "1.2.0" },
    @{ module = "puppet-iis"; version = "3.0.0" }
)

$puppetModules | % {
    puppet module install $_.module --version $_.version
}

## Apply the puppet manifest on a masterless setup

puppet apply manifests/site.pp --verbose

## Install Visual Studio Code Extensions

$vsCodeExtensions = @(
    "Borke.puppet",
    "donjayamanne.python",
    "ms-vscode.csharp",
    "ms-vscode.PowerShell",
    "PeterJausovec.vscode-docker",
    "bbenoist.vagrant",
    "vscodevim.vim"
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
    "IIS-WebSockets",
	"Microsoft-Windows-Subsystem-Linux"
)

$windowsFeatures | % { 
    Write-Host "Enabling $_..."
    DISM /online /enable-feature /featurename:$_ 
}

# TODO:
# http://stackoverflow.com/questions/40033608/enable-windows-10-developer-mode-programmatically