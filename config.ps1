$config = @{
	puppetModules = @(
		@{ module = "puppetlabs-chocolatey"; version = "2.0.0" },
		@{ module = "basti1302-windows_path"; version = "0.1.1" },
		@{ module = "puppetlabs-vcsrepo"; version = "1.5.0" },
		@{ module = "puppetlabs-dsc"; version = "1.2.0" },
		@{ module = "puppet-windows_autoupdate"; version = "1.2.0" },
		@{ module = "puppet-iis"; version = "3.0.0" }
	),
	
	vsCodeExtensions = @(
		"bbenoist.vagrant",
		"Borke.puppet",
		"donjayamanne.python",
		"eamodio.gitlens",
		"ipatalas.vscode-conemu",
		"johnpapa.Angular2",
		"mrmlnc.vscode-scss",
		"ms-mssql.mssql",
		"ms-vscode.csharp",
		"ms-vscode.PowerShell",
		"msjsdiag.debugger-for-chrome",
		"PeterJausovec.vscode-docker",
		"sanderledegen.angular-follow-selector",
		"steoates.autoimport",
		"vscodevim.vim",
	),
	
	windowsFeatures = @(
		"IIS-WebServer",
		"IIS-StaticContent",
		"IIS-ASPNET45",
		"IIS-WebSockets",
	)
}