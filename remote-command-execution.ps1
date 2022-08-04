<#
.SYNOPSIS
 Remotely execute commands on multiple servers using Invoke-Command

.DESCRIPTION
#>
$Servers = @("server1", "server2")

$Servers = Get-Content -Path .\serverlist.txt

$Servers | ForEach-Object { 
    Invoke-Command -ComputerName $_ -ScriptBlock {Get-ChildItem C:\Temp}
}

$ScriptCode = {
  Get-ChildItem C:\Temp
}


$Servers | ForEach-Object { 
    Invoke-Command -ComputerName $_ -ScriptBlock $ScriptCode
}

$ScriptCode1 = {
  Param($SearchFolder)
  Get-ChildItem $SearchFolder
}


$Servers | ForEach-Object { 
    Invoke-Command -ComputerName $_ -ScriptBlock $ScriptCode1 -ArgumentList "C:\Temp"
}

