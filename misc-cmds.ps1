<#
2016-11-24
This file will hold powershell commands as I find them before they go into their specific modules
#>

# Search text in a list of files

get-childitem -Path toplevelfolder -Filter *.TXT -Recurse | WHERE { select-string "text to search" $_ } | select fullname 

# Display CSV file contents in a trig-view
Import-Csv .\filename.csv | Out-GridView 

