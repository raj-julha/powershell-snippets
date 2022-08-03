<#
.SYNOPSIS
 A sample script to read an external JSON file and add Methods and properties to the resulting PSCustomObject
 It an be used for configuration files or lookup up files

.DESCRIPTION

.NOTES
#>

$SampleMapJson = @"
{
    SampleMap : [
        {"InputType": "100", "OutputType" : "105"},
        {"InputType": "102", "OutputType" : "107"},
        {"InputType": "104", "OutputType" : "109"},
        {"InputType": "106", "OutputType" : "111"}
    ]   
}
"@

$LookupMap = ConvertFrom-Json -InputObject $BatchTypeMapJson

$LookupMap.SampleMap.Count


# Define a scriptblock
$DeriveNewType = {
    Param($InputType, $DefaultIfNotFound = $InputType)

    # The Where filter always returns a list, not null so check for Count equal to 0 to consider
    # as no items qualifying filter

    $MappedType = $DefaultIfNotFound # $InputType
    
    $MatchingType = $this.SampleMap.Where({$InputType -match $_.InputType}, 'First')
    if($MatchingType.Count -gt 0){
        $MappedType = $MatchingType.OutputType
    }
    
    # $RetValue = "Map has $($this.SampleMap.Count) items. Input is $($InputType), mapped is $($MappedType) "

    return $MappedType
}

$LookupMap | Add-Member -Name "GetMappedType" -MemberType ScriptMethod -Value $DeriveNewType



$LookupMap.GetMappedType()

$LookupMap.GetMappedType("104")

$LookupMap.GetMappedType("XYZ")

$LookupMap.GetMappedType("ABC", "MUR")
