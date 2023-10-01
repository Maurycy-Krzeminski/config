$configPath = $pwd.path
echo 'configPath:'$configPath  
[Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME',$configPath)
$statePath = Join-Path -Path $configPath -ChildPath "data"
echo 'statePath:'$statePath
[Environment]::SetEnvironmentVariable('XDG_STATE_HOME',$statePath)


