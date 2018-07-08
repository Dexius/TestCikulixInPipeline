Add-Type -AssemblyName Microsoft.VisualBasic
$id  = (Get-Process 1cv8c).ID | Sort StartTime | Select -Last 1
[Microsoft.VisualBasic.Interaction]::AppActivate($id)