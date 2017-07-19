node default {

  vcsrepo { 'D:\Github\vagrant-files':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/AndrewCritchley/vagrant-files.git',
  }

  vcsrepo { 'D:\Github\Windows-Development-Environment':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/AndrewCritchley/windows-development-environment.git',
  }

  # need to add this path in order to have ssh in the PATH
  windows_path { 'C:\Program Files\Git\usr\bin':
    ensure  => present,
  }
  
  class { 'windows_autoupdate': 
    no_auto_reboot_with_logged_on_users => '1' 
  }

  exec { 'change-iis-default-log-path':
    command   => 'Import-Module WebAdministration; Set-WebConfigurationProperty "/system.applicationHost/sites/siteDefaults" -name logfile.directory -value D:\Logging\IIS',
    provider  => powershell,
    logoutput => true,
  }

  exec { 'set-git-username':
    command   => 'git config --global user.name "AndrewCritchley"',
    provider  => powershell,
    logoutput => true,
  }
  
}