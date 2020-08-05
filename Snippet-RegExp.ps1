<#
.SYNOPSIS
 Commonly used regular expressions

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


# Turn snake case to camel case
$InputStr = "this_is_my_text_with_underscore"
$Pattern = "(_[a-z])+"

# https://stackoverflow.com/questions/8163061/passing-a-function-to-powershells-replace-function
# https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions
# https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.matchevaluator?view=netframework-4.7.2
# http://duffney.io/APracticalGuideforUsingRegexinPowerShell
# 
# https://social.msdn.microsoft.com/Forums/en-US/5ae2778b-2e1a-4e3b-8471-3fe97e268f72/does-u-convert-to-uppercase-work-in-net-regex?forum=regexp

# https://powershellone.wordpress.com/2015/08/19/powershell-tricks-replace-and-transform-a-value-within-a-string/
$MatchEval = {
    $args[0].Value.Replace("_", "").ToUpper()
}

[System.Text.RegularExpressions.Regex]::Replace($InputStr, $Pattern, $MatchEval)
# This one uses the scriptblock in the call itself
[System.Text.RegularExpressions.Regex]::Replace($InputStr, $Pattern, {
        $args[0].Value.Replace("_", "").ToUpper()
    })

# Get server name from url
$Url = "http://localhost:1234"
[string]$ServerRegExp = "^http://(?<servername>.*):(?<port>[0-9]*)"
$Url -match $ServerRegExp  # returns True if match exists
$Matches
$Matches["servername"]
$Matches["servernamex"] # returns blank if it doesn't exist


# Search for all spaces except for CRLF
# Can be used to replace space between columns with TAB
\s+[^\S\r\n]
