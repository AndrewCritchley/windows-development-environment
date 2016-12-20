## Author: Andrew Critchley
## Date: 19/12/2016
## Description:
#### Template for my basic development environment
## Manual Actions:
#### - https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
#### - Set execution policy for powershell
#### - 

## Parameters
$github_passphrase = Read-Host 'Passphrase for Github SSH Key?' -AsSecureString

# Generate SSH Keys
mkdir "E:\SSH_KEYS"
ssh-keygen -t rsa -b 4096 -C "github_andrew" -f E:\ssh_keys\github_andrew -P $github_passphrase

## Install chocolatey and puppet agent

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install puppet-agent -y

## Add puppet modules
puppet module install --target-dir ./modules puppetlabs-chocolatey --version 2.0.0
puppet module install --target-dir ./modules basti1302-windows_path --version 0.1.1
puppet module install --target-dir ./modules puppetlabs-vcsrepo --version 1.0.2

puppet apply --modulepath ./modules manifests/site.pp --verbose