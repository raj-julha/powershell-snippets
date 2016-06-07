<#
2016-06-07 (Raj)
Powershell commands to read delimited files
http://ss64.com/ps/convertfrom-csv.html

http://stackoverflow.com/questions/3473357/quick-way-to-read-a-tab-delimited-file-and-sort-by-date-column-using-powershell
#>


Get-Content -Path C:\top\sub1\TabDelimfile.txt | ConvertFrom-Csv -Delimiter "`t" | Out-GridView

Import-Csv -Path C:\top\sub1\TabDelimfile.txt -Delimiter "`t" | Out-GridView

Import-Csv -Path C:\top\sub1\TabDelimfile.txt -Delimiter "`t" | sort {$_."colname with same space"} | select 'colname with same space', 'Col A/B sample'

Import-Csv -Path C:\top\sub1\TabDelimfile.txt -Delimiter "`t" | sort {$_."colname with same space"} | select 'colname with same space', 'Col A/B sample'


http://serverfault.com/questions/141923/importing-from-csv-and-sorting-by-date
The sample from the above url demonstrates how we can add proeprties on the fly and also perform field transformations
such as conversion to DateTime for sorting
ft below is short form of Format-Table

Import-CSV -delimiter "`t" Output.tab | Where-Object {$_.'First Name' -like '*And*'} | add-member scriptproperty -name 'HireDateTyped' -value { [DateTime]::Parse($this.'Hire Date') } -passthru | Sort-Object 'HireDateTyped' | ft 'Hire Date', 'First Name'
 