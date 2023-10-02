$configPath = $pwd.path
echo 'configPath:'$configPath  
[Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME',$configPath)

$statePath = Join-Path -Path $configPath -ChildPath "data"
echo 'statePath data:'$statePath
[Environment]::SetEnvironmentVariable('XDG_STATE_HOME',$statePath)
[Environment]::SetEnvironmentVariable('XDG_DATA_HOME',$statePath)

$npmPath = Join-Path -Path $configPath -ChildPath "npm" | Join-Path -ChildPath ".npmrc"
echo 'npmPath:'$npmPath
[Environment]::SetEnvironmentVariable('NPM_CONFIG_USERCONFIG',$npmPath)

