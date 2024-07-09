$Credential = Get-Credential

$ComputerName = "PSSec-PC01.PSSec.local"
$EventLog = "Microsoft-Windows-Sysmon/Operational"
$LogEntries = Get-WinEvent -LogName $EventLog -ComputerName $ComputerName -Credential $Credential
$LogEntries | Where-Object { $_.Id -eq 7 -and ($_.Message -like "*System.Management.Automation*" -or $_.Message -like "*System.Reflection*") }
