<#
.SYNOPSIS
 Demonstrate piping of some of the command line arguments. See notes about helper functions

.DESCRIPTION
 Demonstrate how to pass multiple items through pipe
 
 NOTE: A script that consumes from a pipeline must have the BEGIN/PROCESS/END blocks or else
       it is considered as having just the END block and will therefore be executed after the 
       last item

https://mohitgoyal.co/2019/03/11/implement-pipeline-support-for-advanced-functions-in-powershell/
#>


[cmdletbinding()]
param (
    [Parameter(Mandatory=$true,ValuefromPipelineByPropertyName=$true)]
    [string]$InputFile,
    [Parameter(Mandatory=$true,ValuefromPipelineByPropertyName=$true)]
    [string]$CountryCode,
    [Parameter(Mandatory=$true,ValuefromPipelineByPropertyName=$true)]
    [string]$AccountNo,
    #[Parameter(Mandatory=$true,ValuefromPipelineByPropertyName=$true)]
    [string]$TargetLocation
)

begin {"Test Begin"
    $Ctr = 0
    <#
    .SYNOPSIS
     Any function to support this script must be define din the BEGIN block
     as scripts that process pipelines should always have the 
     BEGIN/PROCESS/END blocks and no code outside
    #>
    Function SomeHelper {
        Param($SomeArg)
        write-verbose "$($SomeArg) passed to function"
    }
}

process {
    Write-Host "InputFile is $InputFile ; CountryCode is $CountryCode ;" + `
    "AccountNo is $AccountNo; and TargetLocation is $TargetLocation"
    SomeHelper -SomeArg "any value"
    $Ctr++
}
end {
    "Test End. ${Ctr} Items"
}


# Test End
#  Get-ChildItem c:\junk | select @{n="InputFile"; e={$_.Fullname}}, @{n="CountryCode"; e={"MU"}}, name | .\Try-PwsPipe.ps1 -AccountNo "1233"
#  Get-ChildItem c:\logs | select @{n="InputFile"; e={$_.Fullname}}, @{n="CountryCode"; e={"MU"}}, @{n="BuiltName"; e={$_.Name.Substring(0,3) + $_.LastWriteTime.ToString('yyyyMMdd_HHmmss')}} , name

