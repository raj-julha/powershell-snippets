<#
.SYNOPSIS
 Reorganise pictures based on name mask into subfolders
 
.DESCRIPTION
 

 Enable powershell permission with command below
 Set-ExecutionPolicy -ExecutionPolicy UnRestricted

.NOTES
 Filename: ReorgPics.ps1
 Date Created: 2018-11-14
 Author: Raj

 TODO: Use validate script in arg to validate root, target folders etc.
 TODO: Prompt user before proceeding

#>

[CmdletBinding()]
Param(
    [ValidateScript({
        If(-not (Test-Path $_ -PathType Container)){ 
            Write-Host "Root folder does not exist"
            $false
        } Else {
            $true
        }
    })]
    [string]$RootFolder = "C:\junk\camera",
    [ValidateScript({ Test-Path $_ -PathType Container })]
    [string]$TargetFolder = "C:\junk\camera\reorg",
    [string]$FilterMask = "^(?<YearPart>\d{4})(?<MonthPart>\d{2})(?<DayPart>\d{2})_(?<TimePart>\d{6}).*\.jpg$",
    [switch]$Copy = $false
)


# Use Enumeration rather than plain Get-ChildItem to avoid buffering
$Di = New-Object -TypeName System.IO.DirectoryInfo($RootFolder)
# We use the where-object instead of the overloaded method that takes 
# a search mask so that we can use regexps.
$Di.EnumerateFileSystemInfos() | Where-Object {$_.Name -match $FilterMask } | ForEach-Object {
    
    $Matches
    
    $TargetSubFolder = Join-path -path $TargetFolder -ChildPath "$($Matches['YearPart'])_$($Matches['MonthPart'])"
    If(-not (Test-Path -Path $TargetSubFolder -PathType Container)){
        New-Item -Path $TargetSubFolder -ItemType Directory | Out-Null
        Write-Verbose "Successfully created $TargetSubFolder"
    }

    Write-Verbose "Processing $($_.Name), moving to $TargetSubFolder"
    Move-Item -Path $_.FullName -Destination $TargetSubFolder -Force
}
