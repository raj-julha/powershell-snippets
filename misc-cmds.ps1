<#
2016-11-24
This file will hold powershell commands as I find them before they go into their specific modules
#>

# Search text in a list of files

get-childitem -Path toplevelfolder -Filter *.TXT -Recurse | WHERE { select-string "text to search" $_ } | select fullname 

Get-ChildItem -Path \\server1\share1\folder1 -Recurse -Filter "ABC-2016????.csv" | Select-String -Pattern "(regex1*) | (regex2*)" | select Line | Format-Table -Wrap -AutoSize | Out-String -Width 2000| Out-File -FilePath D:\localfolder\myresult.csv

# Change extension of many files

get-childitem d:\folderlocation -Filter "*.ext" | Rename-Item -NewName { [io.path]::ChangeExtension($_.FullName, "newext")}

# View a CSV file hosted on a a web server
[System.Text.Encoding]::ASCII.GetString((Invoke-WebRequest -Uri http://sitename/subfolder/filename.csv).Content) | ConvertFrom-Csv | Out-GridView 

# Download a file from a web server
Invoke-WebRequest -Uri http://sitename/subfolder/filename.zip -OutFile D:\localfolder\locafilename.zip

# http://stackoverflow.com/questions/17325293/invoke-webrequest-post-with-parameters
# Invoke-WebRequest -UseBasicParsing http://eaxmple.com/service -ContentType "application/json" -Method POST -Body "{ 'ItemID':3661515, 'Name':'test'}"

$postParams = @{username='me';moredata='qwerty'}
$resp = Invoke-WebRequest -Uri http://example.com/foobar -Method POST -Body $postParams

# Identify AD membership
Get-ADuser userid -Properties MemberOf | select MemberOf |% {$_.MemberOf}

# http://woshub.com/copying-large-files-using-bits-and-powershell/
