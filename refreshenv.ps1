# Chocolatey has a refreshenv function that allows you to refresh the environment variables on the fly. Until this is available, this
#       allows the path to be refreshed without interrupting the script.

function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

$refreshEnv = get-alias -name refreshenv 

if($refreshEnv.count -lt 1){ 
    Set-Alias refreshenv Refresh-Path
      Write-Host "refreshenv not present - adding temporary alias"
 }
 else {
     Write-Host "refreshenv already present - skipping"
 }
