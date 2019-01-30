 <#
2016-06-07 (Raj)
Powershell commands to read delimited files
http://ss64.com/ps/convertfrom-csv.html

http://stackoverflow.com/questions/3473357/quick-way-to-read-a-tab-delimited-file-and-sort-by-date-column-using-powershell
#>

# Display CSV file contents in a grid-view. Considers the first row as header
Import-Csv .\filename.csv | Out-GridView 

# The file filewithoutheaderrow.csv has data as from first row so the system  infers the
# header. If the file has more than 3 fields it will only show the first 3 columns
# with header ColA, ColB and ColC. As we add more header fieldnames further columns can be displayed
Import-Csv -Path .\filewithoutheaderrow.csv  -Header ColA,ColB,ColC | out-gridview


Get-Content -Path C:\top\sub1\TabDelimfile.txt | ConvertFrom-Csv -Delimiter "`t" | Out-GridView

Import-Csv -Path C:\top\sub1\TabDelimfile.txt -Delimiter "`t" | Out-GridView

Import-Csv -Path C:\top\sub1\TabDelimfile.txt -Delimiter "`t" | sort {$_."colname with same space"} | select 'colname with same space', 'Col A/B sample'

Import-Csv -Path C:\top\sub1\TabDelimfile.txt -Delimiter "`t" | sort {$_."colname with same space"} | select 'colname with same space', 'Col A/B sample'


http://serverfault.com/questions/141923/importing-from-csv-and-sorting-by-date
The sample from the above url demonstrates how we can add proeprties on the fly and also perform field transformations
such as conversion to DateTime for sorting
ft below is short form of Format-Table

Import-CSV -delimiter "`t" Output.tab | Where-Object {$_.'First Name' -like '*And*'} | add-member scriptproperty -name 'HireDateTyped' -value { [DateTime]::Parse($this.'Hire Date') } -passthru | Sort-Object 'HireDateTyped' | ft 'Hire Date', 'First Name'
# The line below must be tested (2019-01-31)
Import-CSV -delimiter "`t" Output.tab | Where-Object {$_.'First Name' -like '*And*'} | [PSCustomObject]@{ HireDateTyped = [DateTime]::Parse($this.'Hire Date') -passthru | Sort-Object 'HireDateTyped' | ft 'Hire Date', 'First Name'

#
get-childitem -Path .\ -Filter .\data\file0?.txt |%{write-host "headerline" }{ import-csv -path $_.FullName -Delimiter '|'} 
# The command below loops throughg all files like file01.txt, file02.txt and creates a merged output file mfile02.txt
# It automatically takes care of header line in each file
get-childitem -Path d:\topfolder -recurse -file -Filter file0?.txt |% {write-host "headerline" $_.FullName } { import-csv -path $_.FullName -Delimiter '|'} | Export-Csv -Path .\data\mfile02.txt -Append -NoTypeInformation -Delimiter '|' 
