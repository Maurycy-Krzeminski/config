$PSReadLine = Get-Module PSReadLine

if (!$PSReadLine) {
    Write-Host "PSReadLine is required"
        return
}
$defaultPSConsoleHostReadLine= $function:PSConsoleHostReadLine
$tests_id = 0

function PSConsoleHostReadLine {
## This needs to be done as the first thing because any script run will flush $?.
    $lastRunStatus = $?

        Microsoft.PowerShell.Core\Set-StrictMode -Off
        $OriginalReadLine = $defaultPSConsoleHostReadLine.invoke()
        $script:tests_id =  E:\programming\rust\tests\target\debug\tests.exe $OriginalReadLine
        return $OriginalReadLine
}
Export-ModuleMember -Function PSConsoleHostReadLine
