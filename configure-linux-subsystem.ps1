## Reference: http://stackoverflow.com/questions/40033608/enable-windows-10-developer-mode-programmatically

function EnableWindowsDeveloperMode() {
	# Create AppModelUnlock if it doesn't exist, required for enabling Developer Mode
	$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
	if (-not(Test-Path -Path $RegistryKeyPath)) {
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force
	}

	# Add registry value to enable Developer Mode
	New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1
}

function SetDockerClientToUseDockerForWindows() {
	Write-Host "Seting docker client to use daemon running on windows"
	bash -c echo 'DOCKER_HOST=tcp://0.0.0.0:2375 export PATH=$PATH:~/bin' >> ~/.bashrc 
}

function EnableWindowsSubsystemForLinuxFeature() {
	Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online -All -LimitAccess -NoRestart
}

EnableWindowsDeveloperMode
EnableWindowsSubsystemForLinuxFeature
SetDockerClientToUseDockerForWindows