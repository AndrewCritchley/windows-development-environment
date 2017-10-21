#Requires -RunAsAdministrator
#Requires -Version 5
## Author: Andrew Critchley
## Date: 19/12/2016
## Description:
#### Template for my basic development environment

Set-ExecutionPolicy Unrestricted

Import-Module .\refreshenv.ps1
Import-Module .\check-command.psm1
Import-Module .\config.ps1

## Install chocolatey and puppet agent

$isChocoInstalled = Check-Command choco
if($isChocoInstalled -eq $false ) {
	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
	Write-Host "Chocolatey already installed, skipping..."
}


refreshenv

choco install chocolatey-packages.config -y

refreshenv

## Install puppet modules

$config.puppetModules | % {
    Write-Host "Installing Puppet Module $($_.module) ..."
    puppet module install $_.module --version $_.version
}

## Apply the puppet manifest on a masterless setup

puppet apply manifests/site.pp --verbose

## Install Visual Studio Code Extensions

$config.vsCodeExtensions | % { 
    Write-Host "Installing VSCode Extension $_..."
    code --install-extension $_ 
}

## Install Windows Features

$config.windowsFeatures | % { 
    Write-Host "Enabling Windows Feature $_..."
    DISM /online /enable-feature /featurename:$_ 
}