$uri = 'https://raw.githubusercontent.com/PacktPublishing/PowerShell-Automation-and-Scripting-for-Cybersecurity/master/Chapter01/HelloWorld.ps1'
$file = Invoke-WebRequest -Uri $uri
$file | Set-Content PSOutFile.ps1
 Get-Content .\PSOutFile.ps1






 

$uri = 'https://raw.githubusercontent.com/CodingSpencer/PowerShell/main/DownloadFile.ps1'
$newFile = Invoke-WebRequest -Uri $uri
$newFile
$HttpRequest = New-Object -ComObject Microsoft.XMLHTTP
$HttpRequest.open('GET', $uri, $false)
$HttpRequest.send()
Invoke-Expression $HttpRequest.responseText