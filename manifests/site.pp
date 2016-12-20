include chocolatey

node default {

	if $::kernel == 'windows' {
	  Package { provider => chocolatey, }
	}

  $chocolateyPackages = [ 'git'
									, 'vagrant'
									, 'virtualbox'
									, 'conemu'
									, 'googlechrome'
									, 'postman'
									, 'winmerge'
									, 'visualstudiocode'
									, 'unxutils' ]

  package { $chocolateyPackages: 
		ensure => 'installed' 
	}

	vcsrepo { 'E:\Github\VagrantBoxes':
	  ensure   => present,
	  provider => git,
	  source   => 'https://github.com/AndrewCritchley/VagrantFiles.git',
	}

	vcsrepo { 'E:\Github\DeveloperMachineConfig':
	  ensure   => present,
	  provider => git,
	  source   => 'https://github.com/AndrewCritchley/WindowsDevelopmentEnvironment.git',
	}

	windows_path {'C:\Program Files\Git\usr\bin':
			ensure => present,
	}
	
}