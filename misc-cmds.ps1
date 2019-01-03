<#
2016-11-24
This file will hold powershell commands as I find them before they go into their specific modules
#>

# List files from a folder containing huge number of files
# Get-ChildItem builds files list in memory before proceeding so use the commadn below to get teh first file immediately for processing
# See http://powershell-guru.com/fastest-powershell-2-count-all-files-in-large-network-share/

[System.IO.Directory]::EnumerateFiles("\\servername\share\", "*.*")

$Di = New-Object -TypeName System.IO.DirectoryInfo("d:\mysource")
$Di.EnumerateFileSystemInfos("*.txt", [System.IO.SearchOption]::AllDirectories) | Where-Object {$_.LastWriteTime -lt (get-date -Year 2018 -Month 1 -Day 1)}

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


# Export CSV file from a .NET DataTable object 
# Ensure dates are exported in yyyy-MM-dd HH:mm:ss format. Without the two statements below
# dates are export as per server format, i.e. dd/MM/yyyy HH:mm:ss or MM/dd/yyyy
(Get-Culture).DateTimeFormat.ShortDatePattern = "yyyy-MM-dd"
(Get-Culture).DateTimeFormat.ShortTimePattern = "HH:mm:ss.fff"

# We want a separate file per a unique field, e.g. per region code
# Consider how ew could use LINQ
$UniqueFields01 = $data | select-Object Field01 -Unique
        
$UniqueFields01 | ForEach-Object {
    $curField01 = $_.Field01
                           
    # The first line will contain "#TYPE System.Data.DataRow" without the -NoTypeInformation                
    $outfile = Join-Path -Path "D:\somelocation" -ChildPath ("{0}-Out_{1:yyyyMMdd}.csv" -f $curField01, (get-date))
    $data | where {$_.Field01 -eq $curField01 } | Export-Csv -Path $outfile -NoTypeInformation        
 }    
 
 # Output into clipboard
 
 Get-Process | clip
 
 # Open an editor and paste
 
 # Create an event source
 new-eventlog -source "Custom Source" -LogName "Application"
 
# https://stackoverflow.com/questions/32511325/invoke-sqlcmd-with-either-windows-authentication-or-sql-authentication
# requires sql client on workstation
$auth = @{} # for windows authentication
Invoke-Sqlcmd -ServerInstance DBSERVERNAME -Database DBNAME  -Query "SELECT top 10 * from Information_Schema.TABLES" @auth
