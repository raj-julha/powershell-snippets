$InputFolder = "E:\temp\Test1"
$TargetLocation = "E:\temp\Test1\Output"
# apply rename to files that have a plus sign in the name
# Note: the -split argument takes a regular expression
Get-ChildItem $InputFolder\*.txt | Where-Object {$_.Name -match "\+"} | ForEach-Object {
    $NewName = ($_.Name -split "\+")[1]
    $NewFilePath = Join-Path -Path $TargetLocation -ChildPath $NewName
    $_.CopyTo($NewFilePath, $true)
}


