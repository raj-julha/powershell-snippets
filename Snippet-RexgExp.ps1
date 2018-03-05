<#
.SYNOPSIS
 Append a new extension or change extension of files that match a specific regular expression

.DESCRIPTION
 Append a new extension or change extension of files that match a specific regular expression
 This sample also illustrates usage of named matches in regular expressions

.NOTES
 Date Created: 2018-03-05
#>


$FilesLocation = "d:\junk"
Get-ChildItem -Path $FilesLocation | Where-Object { $_.Extension -match "\d{3}$" } | ForEach-Object {
    $MyMatch = $_.FullName -match "(?<TheExt>\d{3}$)"
    
    # Write-Host $MyMatch  #["TheExt"] 
    # Write-Host $Matches["TheExt"] 

    $NewName = $_.FullName -replace "\d{3}$", ($Matches["TheExt"] + ".tif")
    Write-Host $NewName
    Copy-Item -Path $_.FullName -Destination $NewName
}
