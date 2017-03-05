include chocolatey

node default {

  Package { provider => chocolatey, }
  
  $chocolateyPackages = [ 'git'
				  , 'sourcetree'
				  , 'poshgit'
				  , 'python'
                  , 'vagrant'
                  , 'virtualbox'
				  , 'docker'
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

  windows_path { 'C:\Program Files\Git\usr\bin':
      ensure => present,
  }
  
  class { 'windows_autoupdate': 
    no_auto_reboot_with_logged_on_users => '1' 
  }
  
  $windowsFeatures = [ 'Web-Server'
                  , 'Web-Asp-Net45' ]
  
  $windowsFeatures.each |$feature| { 
      dsc_windowsfeature { $feature: 
	     dsc_ensure => 'present',
	     dsc_name => $feature,
	  }
  }
  
}