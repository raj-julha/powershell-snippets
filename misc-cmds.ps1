<#
2016-11-24
This file will hold powershell commands as I find them before they go into their specific modules
#>

# Search text in a list of files

get-childitem -Path toplevelfolder -Filter *.TXT -Recurse | WHERE { select-string "text to search" $_ } | select fullname 

# Display CSV file contents in a trig-view
Import-Csv .\filename.csv | Out-GridView 

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
