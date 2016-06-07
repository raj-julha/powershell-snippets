<#
2016-06-07 (Raj)
Powershell commands to read delimited files
http://ss64.com/ps/convertfrom-csv.html

http://stackoverflow.com/questions/3473357/quick-way-to-read-a-tab-delimited-file-and-sort-by-date-column-using-powershell
#>


Get-Content -Path C:\top\sub1\TabDelimfile.txt | ConvertFrom-Csv -Delimiter "`t" | Out-GridView

Import-Csv -Path C:\top\sub1\TabDelimfile.txt -Delimiter "`t" | Out-GridView