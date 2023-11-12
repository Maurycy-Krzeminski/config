# Prompt for osc7 for wezterm https://wezfurlong.org/wezterm/shell-integration.html?h=osc#osc-7-on-windows-with-powershell
# To have the file path in the prompt when wezterm is spliting pane or tabs
function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
    }
    "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) ";
}

# prompt for starship to use osc7 
#
# $prompt = ""
# function Invoke-Starship-PreCommand {
#    $current_location = $executionContext.SessionState.Path.CurrentLocation
#    if ($current_location.Provider.Name -eq "FileSystem") {
#        $ansi_escape = [char]27
#        $provider_path = $current_location.ProviderPath -replace "\\", "/"
#        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
#    }
#    $host.ui.Write($prompt)
#}

# Function testing if programm is installed
# Example usage:
# if(Test-Installation -ProgramName "bat")
function Test-Installation {
    param ([string]$ProgramName)
    $null -ne (Get-Command $ProgramName -ErrorAction SilentlyContinue)
}

Write-Host "Profile start."
if (Test-Installation -ProgramName "bat") {
    Write-Host "Bat is installed."
    Set-Alias -Name cat -Value bat  -Option AllScope
    Write-Host "Bat is used instead of cat."
} else {
    Write-Host "Bat is not installed."
    Set-Alias -Name cat -Value Get-Content  -Option AllScope
    Write-Host "Get-Content is used."
}
