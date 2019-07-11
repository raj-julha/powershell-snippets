<#
.SYNOPSIS
 Demonstrate usage of Enums in powershell for command line arguments

.DESCRIPTION
 The script will use an enum argument named whattodo to determine what tasks should be performed.

.PARAMETER WhatToDo
 This is an enum and can be passed as a coma separated list inside double quotes
 Possible values are: None, Action01, Action02, Action03, Action04.

#>

[CmdletBinding()]
Param(    
    $WhatToDo = "None"
)

# See http://www.latkin.org/blog/2012/07/08/using-enums-in-powershell/ for enum and bitwise support in powershell scripts
# Must use powers of 2 for bitwise operators to work
# NOTE: if we update the Add-Type code content below we must close the powershell session and start a new one to 
#       avoid the error "type already exists"

Add-Type -TypeDefinition @"
    [System.Flags]
    public enum ActionEnumType
    {
        None = 0, 
        Action01 = 1,
        Action02 = 2,
        Action03 = 8,
        Action04 = 16
    }
"@


$WhatToDo = [ActionEnumType]$WhatToDo


if($WhatToDo -band [ActionEnumType]::Action02){
    Write-Verbose "Action02 Tasks started."
    Write-Verbose "Do something for action02"

    Write-Verbose "Action02 Tasks completed."
}
else {
    Write-Verbose "Action02 Tasks will not be executed."
}
        
if($WhatToDo -band [ActionEnumType]::Action03){
    Write-Verbose "Action03 Tasks started."
   
    Write-Verbose "Action03 Tasks Completed."
}
else{
    Write-Verbose "Action03 Tasks will not be executed."
}

                
if($WhatToDo -band [ActionEnumType]::Action04){
    Write-Verbose "Action04 Tasks started."     
}
else{
    Write-Verbose "Action04 Tasks will not be executed."
}
