<#
.SYNOPSIS
 Sample code to demonstrate compression of files without using any third party libraries

.DESCRIPTION
 This code demonstrates how we can zip file by using the System.IO.Compression.FileSystem assembly that comes
 with .NET 4.5

.NOTES
 DateCreated: 2017-10-09
 Author: Raj Julha
#>
[CmdletBinding()]
Param()


Function Zip-Delivery {
    [CmdletBinding()]
    Param(
        [string]$ArchiveFilename,
        [parameter(ValueFromPipeLine)]
        [string]$ZipItem
    )
    
    BEGIN {
        Add-Type -Assembly "System.IO.Compression.FileSystem";
        # [System.IO.Compression.ZipFile]::CreateFromDirectory("<sourcefolder>", "target1.zip") 
        $CurZipFile = [System.IO.Compression.ZipFile]::Open($ArchiveFilename, [System.IO.Compression.ZipArchiveMode]::Create)
        Write-Verbose "Created zip $ArchiveFilename"
    }
    PROCESS {
        Write-Verbose "Appending $ZipItem to $ArchiveFilename"
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($CurZipFile, $ZipItem, (Split-Path -Path $ZipItem -Leaf), [System.IO.Compression.CompressionLevel]::Fastest) > $null
        
    }
    END {    
         
        If ($CurZipFile -ne $null) {
            $CurZipFile.Dispose()
            $CurZipFile = $null 
        }        
        
    }

}

$SourceFilesLocation = "C:\temp\subfolder1\subfolderx"
$ArchiveFileName = "C:\temp\myzipfile.zip"
# ExpandProperty ensures outcome is a string, otherwise it is still a FileInfo object
Get-ChildItem $SourceFilesLocation -File | select -ExpandProperty fullname | Zip-Delivery -ArchiveFilename $ArchiveFileName

