# Pass arguments to powershell script

#### Parameter definition
```powershell
[CmdletBinding()]
Param(
    [datetime]$StartDateTime = (get-date).AddMinutes(-120),
    [datetime]$EndDateTime = (get-date),
    [ValidateScript({
        If(Test-Path $_ -PathType Container){             
            $true
        } Else {

            Throw "Target folder $_ does not  exist or is not accessible"
        }
    })]    
    [string]$Target = "D:\mytopfolder\subfolder1",    
    [string]$Loglocation = "D:\myLoglocation",
    [string]$Workfolder =  (join-path -path ([environment]::getfolderpath("CommonApplicationData")) -childpath "scriptname1"),
    [switch]$OverwriteExisting = [switch]::Present,
    [switch]$RetainWorkfolder = $false,
    [string[]]$Users = $null,
    [string]$Recipients = ((Get-Content -Path .\recipients.txt) -join ",") # Here the argument is expecting a coma separated list of recipients; recipients.txt contains one line per recipient
)
```

Assuming script name is myscript.ps1

## Date Argument
Works with Powershell ver 5 onwards
```powershell
# Here we are passing 11 Jan 2019 14:30:25 to the script
myscript.ps1 -StartDate ([DateTime]::new(2019, 1, 11, 14, 30, 25))
```

## Array of items
```powershell
 
myscript.ps1 -Users (@("user1", "user2", "user3"))  
```

## Coma seperated list

```powershell
# 
myscript.ps1 -Recipients "user1@gmail.com, user2@gmailcom, user3@gmail,com"
```


