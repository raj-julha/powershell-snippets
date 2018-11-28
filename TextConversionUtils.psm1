<#
#>
Function ConvertTo-PascalCase
{
    [CmdLetBinding()]
    Param(
        [Parameter(ValueFromPipeline)]
        [string]$InputStr
        )

    $MatchEval = {$args[0].Value.ToUpper()}
    $Pattern = "^."
    [System.Text.RegularExpressions.Regex]::Replace($InputStr, $Pattern, $MatchEval)
}

Function Convert-SnakeCaseToCamelCase
{
    [CmdLetBinding()]
    Param(
        [Parameter(ValueFromPipeline)]
        [string]$InputStr
        )

    $MatchEval = {
        $args[0].Value.Replace("_", "").ToUpper()
    }
    $Pattern = "(_[a-z])+"
    [System.Text.RegularExpressions.Regex]::Replace($InputStr, $Pattern, $MatchEval)        
}


Function Convert-SnakeCaseToPascalCase
{
    [CmdLetBinding()]
    Param(
        [Parameter(ValueFromPipeline)]
        [string]$InputStr
        )
    $InputStr | Convert-SnakeCaseToCamelCase | ConvertTo-PascalCase

}


Export-ModuleMember -Function ConvertTo-PascalCase, Convert-SnakeCaseToCamelCase, Convert-SnakeCaseToPascalCase

# Usage
#  Import-Module .\TextConversionUtils.psm1
# Show available commands/functions
#  Get-Command -Module TextConversionUtils