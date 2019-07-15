<#
.SYNOPSIS

.DESCRIPTION
#>

[CmdletBinding()]
Param()


Function GitCommit {
    [CmdletBinding()]
    Param(
        [string]$ProjectLocation,
        [string]$Message
    )

    # 1. Save current folder
    # 2. change to expected folder
    # 3. check if folder is a git project (checking existence of .git subfolder)
    # 4. perform commit
    # 5. Get list of commits
    # 6. change back to orignal location


    try {
        Push-Location

        Set-Location $ProjectLocation

        if(-not (Test-Path -Path .\.git -PathType Container)) {
            throw "Not a git work folder"
        }

        $gitResult = @()

        # We could add a specific file only
        $gitCommand = "git add ."
        $gitResult = Invoke-Expression -Command $gitCommand

        Write-Verbose $gitCommand 


        $gitCommand = "git commit -m `"$Message`""
        Write-Verbose $gitCommand 
        $gitResult += Invoke-Expression -Command $gitCommand
        $gitExitCode = $LastExitCode
        $gitExitCode, $gitResult

    }
    catch {
        Write-Error $_
    }
    finally {
        Pop-Location
    }



}


Function GitTag {
    [CmdletBinding()]
    Param(
        [string]$ProjectLocation,
        [string]$Version,
        [string]$Message
    )

    # 1. Save current folder
    # 2. change to expected folder
    # 3. check if folder is a git project (checking existence of .git subfolder)
    # 4. perform tagging
    # 5. Get list of tags
    # 6. change back to orignal location


    try {
        Push-Location

        Set-Location $ProjectLocation

        if(-not (Test-Path -Path .\.git -PathType Container)) {
            throw "Not a git work folder"
        }

        $gitResult = @()

        $gitCommand = "git tag -a $Version -m `"$Message`""
        Write-Verbose $gitCommand 

        $gitResult = Invoke-Expression -Command $gitCommand
        $gitExitCode = $LastExitCode
        $gitExitCode, $gitResult

    }
    catch {
        Write-Error $_
    }
    finally {
        Pop-Location
    }

}


GitCommit -ProjectLocation "D:\projects\labs\myproj01" -Message "Auto commit"
<#
PS D:\projects\github\temp\pws> .\Try-GitCommand.ps1 -Verbose
VERBOSE: git commit -m "Auto commit"
1
On branch master
Changes not staged for commit:
	modified:   file01.txt
	modified:   git-tests.txt

no changes added to commit

PS D:\projects\github\temp\pws> 
#>

GitTag -ProjectLocation "D:\projects\labs\myproj01" -Version "7.2" -Message "Automated Tag"

# Shows existence of tag 7.2
#  git rev-parse 7.2