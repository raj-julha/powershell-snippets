<#
#>
Function ConvertTo-PascalCase
{
    [CmdLetBinding()]
    Param([string]$InputStr)

    $MatchEval = {$args[0].Value.ToUpper()}
    $Pattern = "^."
    [System.Text.RegularExpressions.Regex]::Replace($InputStr, $Pattern, $MatchEval)
}

Function Convert-SnakeCaseToCamelCase
{
    [CmdLetBinding()]
    Param([string]$InputStr)

    $MatchEval = {
        $args[0].Value.Replace("_", "").ToUpper()
    }
    $Pattern = "(_[a-z])+"
    [System.Text.RegularExpressions.Regex]::Replace($InputStr, $Pattern, $MatchEval)        
}

Export-ModuleMember -Function ConvertTo-PascalCase

# Usage
#  Import-Module .\TextConversionUtils.psm1
# 