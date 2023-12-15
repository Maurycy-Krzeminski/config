echo 'glazewm'

$configPath = $env:XDG_CONFIG_HOME
echo 'configPath:'$configPath  
$glazeWMPath = Join-Path -Path $configPath -ChildPath 'glaze-wm\config.yaml'
echo $glazeWMPath 
#glazewm.exe --config=
