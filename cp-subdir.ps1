<#
.SYNOPSIS
 Copy contents of subfolders into a target while preserving the subfolder names
 of the source file

.DESCRIPTION
 Copy contents of subfolders into a target while preserving the subfolder names
 of the source file. The files to be copied will be indicated by the caller
 through an argument
  

.PARAMETER src1
 The source location that contains subfolders from which files should be copied to target

.PARAMETER targ1
 The target location where the subfolders in src1 source will be created if they don't exist
 and file smatching the pattern will be copied

.PARAMETER pattern
 The pattern to be used while copying files.
 
.EXAMPLE
 CopySubDirContents "c:\dir1\subdir1" "c:\target\topdir" "*.pdf"


.NOTES
 Date Created: 2016-06-01
        
#>
Function CopySubDirContents($src1, $targ1, $pattern)
{    
    Get-ChildItem -Path $src1 | where {$_.PSISContainer} |% { 
        $tempSourceFiles = (join-path -path $_.Fullname -childpath $pattern) # This will result in something like D:\working\suba\*.pdf
        $subdir = $_.BaseName        
        $targetsubdir = Join-Path -Path $targ1 -ChildPath $subdir

        if(!(Test-Path -Path $targetsubdir -PathType Container))
        {
            # Target location $targetsubdir does not exist, creating folder
            # and redirect output to avoid console clutter
            New-Item -ItemType directory -Path $targetsubdir > $null            
        }
        
        Copy-Item -Path $tempSourceFiles -Destination $targetsubdir 
    }
}


$source = "D:\working\57d17d"
$target = "D:\Transfer\TestTarg1"

Write-Host "Copy subdirectory contents"

CopySubDirContents $source $target "*.pdf"
