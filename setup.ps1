$configPath = $pwd.path
echo 'configPath:'$configPath  
[SYSTEM.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME',$configPath, [System.EnvironmentVariableTarget]::User)

$tmpPath = Join-Path -Path $configPath -ChildPath "tmp"

$dataPath = Join-Path -Path $tmpPath -ChildPath "data"
echo 'dataPath:'$dataPath
[SYSTEM.Environment]::SetEnvironmentVariable('XDG_DATA_HOME',$dataPath, [System.EnvironmentVariableTarget]::User)

$statePath = Join-Path -Path $tmpPath -ChildPath "state"
echo 'statePath:'$statePath
[SYSTEM.Environment]::SetEnvironmentVariable('XDG_STATE_HOME',$statePath, [System.EnvironmentVariableTarget]::User)

$runtimePath = Join-Path -Path $tmpPath -ChildPath "runtime"
echo 'runtimePath data:'$runtimePath
[SYSTEM.Environment]::SetEnvironmentVariable('XDG_RUNTIME_HOME',$runtimePath, [System.EnvironmentVariableTarget]::User)

$npmPath = Join-Path -Path $configPath -ChildPath "npm" | Join-Path -ChildPath ".npmrc"
echo 'npmPath:'$npmPath
[SYSTEM.Environment]::SetEnvironmentVariable('NPM_CONFIG_USERCONFIG',$npmPath, [System.EnvironmentVariableTarget]::User)


$komorebiPath = Join-Path -Path $configPath -ChildPath "komorebi"
echo 'komorebiPath data:'$komorebiPath
[SYSTEM.Environment]::SetEnvironmentVariable('KOMOREBI_CONFIG_HOME',$komorebiPath, [System.EnvironmentVariableTarget]::User)

$scriptsPath = Join-Path -Path $configPath -ChildPath "scripts"

# Get the current PATH environment variable
$currentPath = [SYSTEM.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)

# Check if the folder is already in the PATH
if ($currentPath -split ';' -notcontains $scriptsPath) {
# If it's not in the PATH, add it
    [SYSTEM.Environment]::SetEnvironmentVariable("PATH", "$currentPath;$scriptsPath", [System.EnvironmentVariableTarget]::User)
        echo "Added '$scriptsPath' to the PATH."
            $newPath = [SYSTEM.Environment]::GetEnvironmentVariable("PATH")
            echo "New PATH: "$newPath 
} else {
    echo "'$scriptsPath' is already in the PATH."
}
