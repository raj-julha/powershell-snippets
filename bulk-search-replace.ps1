 $SourceFolder = "E:\Temp\Input"
 $TargetFolder  = "E:\Temp\Output"
 
 Get-ChildItem -Path $SourceFolder -Filter "*.xml" | ForEach-Object {
    $OutputFile = Join-Path $TargetFolder -ChildPath $_.Name
    (Get-Content $_.FullName -Raw) -replace "2022-01-28", "2022-02-23" | Out-File -FilePath $OutputFile -Encoding utf8 
 }

