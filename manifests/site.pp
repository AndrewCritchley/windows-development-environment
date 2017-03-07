include chocolatey

node default {

  Package { provider => chocolatey, }
  
  $chocolateyPackages = [ 'git'
                  , 'sourcetree'
                  , 'poshgit'
                  , 'python'
                  , 'vagrant'
                  , 'virtualbox'
                  , 'conemu'
                  , 'googlechrome'
                  , 'postman'
                  , 'phantomjs'
                  , 'selenium-chrome-driver'
                  , 'winmerge'
                  , 'grepwin'
                  , 'pycharm-community'
                  , 'visualstudiocode'
                  , 'notepadplusplus.install'
                  , 'linqpad'
                  , 'nuget.commandline'
                  , 'autohotkey'
                  , 'chocolateygui'
                  , 'slack'
                  , 'glasswire'
                  , 'f.lux'
                  , 'Carbon'
                  , 'unxutils' ]

  package { $chocolateyPackages: 
    ensure => 'installed' 
  }

  vcsrepo { 'D:\Github\VagrantBoxes':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/AndrewCritchley/VagrantFiles.git',
  }

  vcsrepo { 'D:\Github\DeveloperMachineConfig':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/AndrewCritchley/WindowsDevelopmentEnvironment.git',
  }

  # need to add this path in order to have ssh in the PATH
  windows_path { 'C:\Program Files\Git\usr\bin':
      ensure => present,
  }
  
  class { 'windows_autoupdate': 
    no_auto_reboot_with_logged_on_users => '1' 
  }

  exec { 'change-iis-default-log-path':
    command   => 'Import-Module WebAdministration; Set-WebConfigurationProperty "/system.applicationHost/sites/siteDefaults" -name logfile.directory -value D:\Logging\IIS',
    provider  => powershell,
    logoutput => true,
  }
  
}