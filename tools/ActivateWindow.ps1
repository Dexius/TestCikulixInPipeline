Add-Type -AssemblyName Microsoft.VisualBasic
$process  = Get-Process 1cv8* | Select -Last 1
[Microsoft.VisualBasic.Interaction]::AppActivate($process.id)