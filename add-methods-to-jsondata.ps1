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

$LookupMap = ConvertFrom-Json -InputObject $SampleMapJson

$LookupMap.SampleMap.Count


# Define a scriptblock
$DeriveNewType = {
    Param($InputType, $DefaultIfNotFound = $InputType)

    # The Where filter always returns a list, not null so check for Count equal to 0 to consider
    # as no items qualifying filter

    $MappedType = $DefaultIfNotFound # $InputType
    # Do not use -match below or else teh regexp matches partial data
    $MatchingType = $this.SampleMap.Where({$InputType -eq $_.InputType}, 'First')
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

# To remove a dynamically added method
# $LookupMap.psobject.properties.remove('GetMappedType')

# Sample below shows how to add methods when the JSON data is an array, it starts with [ and not {
# The JSON data is first converted as an array and that array is used as a property in a newly created PSCustomObject

$SampleMapJson2 = @"
[
        {"InputType": "100", "OutputType" : "105"},
        {"InputType": "102", "OutputType" : "107"},
        {"InputType": "104", "OutputType" : "109"},
        {"InputType": "106", "OutputType" : "111"}
]   
"@

$TempLookupList = ConvertFrom-Json -InputObject $SampleMapJson2
$LookupMap2 = [PSCustomObject]@{ LookupList = TempLookupList }
$ScriptCode = {
 Param($InputType, $DefaultIfNotFound = $InputType)
   # The Where filter always returns a list, not null so check for Count equal to 0 to consider
    # as no items qualifying filter

    $MappedType = $DefaultIfNotFound # $InputType
    # Do not use -match below or else the regexp matches partial data
    $MatchingType = $this.LookupList.Where({$InputType -eq $_.InputType}, 'First')
    if($MatchingType.Count -gt 0){
        $MappedType = $MatchingType.OutputType
    }
    
    # $RetValue = "Map has $($this.SampleMap.Count) items. Input is $($InputType), mapped is $($MappedType) "

    return $MappedType
}

$LookupMap2 | Add-Member -Name "GetMappedType" -MemberType ScriptMethod -Value $ScriptCode

$LookupMap2.GetMappedType("104")
