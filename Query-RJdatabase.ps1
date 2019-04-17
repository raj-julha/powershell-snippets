<#
.SYNOPSIS
 Query connect and query from a database to confirm permission and connectivity etc.
  
.DESCRIPTION
 Query connect and query from a databas to confirm permission and connectivity etc.
 Referenced the url below to develop scipt
 http://stackoverflow.com/questions/8423541/how-do-you-run-a-sql-server-query-from-powershell
.PARAMETER sqlQuery

.PARAMETER server
 The server hosting the SQL Server. Include the instance name if more than one instance is present.
 
.PARAMETER database
 The database name on which to execute the query

.PARAMETER target
 The location where the report should be copied. 
    
.PARAMETER loglocation
 The location where the action log will be created.     
                
.INPUTS
  <Inputs if any, otherwise state None>

.OUTPUTS
  

.NOTES
 File: Query-RJdatabase.ps1
 Version:        1.0
 Author:         Raj Julha
 Creation Date:  2017-12-142
 Purpose/Change: Initial script development
  
.EXAMPLE
.\Query-RJdatabase.ps1 

.EXAMPLE
 .\Query-RJdatabase.ps1  -Server <servername> -Database <databasename>
  
         
#>

[CmdletBinding()]
Param(
    [string]$Server = ".\SQLExpress",
    [string]$Database = "MASTER", 
    [ValidateScript({
        if (($_.Trim().StartsWith("SELECT ")) -and !($_.Contains(";"))) {
            $True
        }
        else {
            throw "$_ must start with SELECT statement and should not contain ; character."
        }
    })] 
    [string]$SqlQuery = "SELECT @@SERVERNAME As ServerName, @@VERSION As SqlVersion" 
)

$scriptVersion = "1.0"

## backtick character (`) ascii 96 is the escape character in powershell

#-----------------------------------------------------------[Functions]------------------------------------------------------------
<#
.SYNOPSIS
 Execute SQL statement against a database and return dataset
.DESCRIPTION
 Execute SQL statement against a database and return dataset

.PARAMETER dataSource
 This is the server name hosting the SQL Server

.PARAMETER database
 Database name

.PARAMETER sqlCommand
 A SELECT SQL statement 

.EXAMPLE
 An example

.NOTES
 Referenced the url below to develop scipt
 http://stackoverflow.com/questions/8423541/how-do-you-run-a-sql-server-query-from-powershell

 #>
Function Get-SqlData {
    param(
        [string]$dataSource = $Server,
        [string]$database = $Database,
        [string]$sqlCommand = "SELECT @@SERVERNAME, @@VERSION"
      )

    try
    {
        $connectionString = "Server=$dataSource; Database=$database;Trusted_Connection=True;" 
        $connection = new-object system.data.SqlClient.SQLConnection($connectionString)
        $command = new-object system.data.sqlclient.sqlcommand
        $command.CommandText = $sqlCommand
        $command.Connection = $connection
        $command.CommandType = [System.Data.CommandType]::Text
        # set command type (StoredProc or Text)
               
        $connection.Open()

        $adapter = New-Object System.Data.sqlclient.sqlDataAdapter $command
        $dataset = New-Object System.Data.DataSet
        $adapter.Fill($dataSet) | Out-Null

        $connection.Close()
    
        $connection = $null
    
    }
    catch
    {
        $script:errorOccurred = $true
        Write-Error ($_) 
    }
    finally
    {
        if($null -ne $connection)
        {
            $connection.Close()
            $connection = $null
        }
    }

    
    $dataSet.Tables[0].Rows.Count, $dataSet.Tables[0]

}


#-----------------------------------------------------------[MAIN]------------------------------------------------------------

$script:errorOccurred = $false
$script:itemCount = 0
$sw = [Diagnostics.Stopwatch]::StartNew()
        
try
{
                
    Write-Host "Excecuting script version $($scriptVersion) Testing Database Connectivity"
                            
    # The first line will contain "#TYPE System.Data.DataRow" without the -NoTypeInformation    
    # Get-SqlData -sqlCommand $SqlQuery | export-csv  $reportName -NoTypeInformation
    
    $rowCount, $data = Get-SqlData -sqlCommand $SqlQuery
    if($rowCount -gt 0)
    {
        $script:itemCount = $rowCount 
        $data | Format-List
        # $data | export-csv  $reportName -NoTypeInformation
    }
    else
    {
        Write-Verbose "No data returned from query"
    }    
}
catch
{
    $script:errorOccurred = $true
    Write-Error ($_) 
}
                 
# Return a value that can be picked up by the scheduler
$sw.Stop()
# $sw.Elapsed
# $script:errorOccurred
$successMsg = if($errorOccurred){"with errors"} else {"without errors"}
$timeMsg = "Process completed in {0:00}:{1:00}:{2:00}.{3} ({4} Minutes) {5}. {6} Items processed." -f $sw.Elapsed.Hours, $sw.Elapsed.Minutes, $sw.Elapsed.Seconds, $sw.Elapsed.Milliseconds,  $sw.Elapsed.TotalMinutes, $successMsg, $script:itemCount
Write-Verbose $timeMsg 
# Return a value that can be picked up by the scheduler
if($script:errorOccurred){exit 1} else {exit 0}

<#

.\Query-RJdatabase.ps1 -Server myservername -Database mydbname -SqlQuery "SELECT * FROM OPENROWSET(BULK '\\servershare\subfolder1\pipedelimfile.TXT', FORMATFILE='\\servershare\subfolder1\pipedelimfile\pipedelimfile.xml', FIRSTROW=1) as t1" -Verbose
#>