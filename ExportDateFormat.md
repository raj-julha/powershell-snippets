# Manage Date Formats using Export-CSV

When exporting a DataTable using Export-CSV as in
```powershell
data | export-csv "fielname.csv" -NoTypeInformation
```
the date columns are exported according to the systems's regional settings and this might not be consistent 
so we explicitly set the date format to yyyy-MM-dd HH:mm:ss.fff

Code picked up from discussions in [https://stackoverflow.com/questions/22826185/setup-default-date-format-like-yyyy-mm-dd-in-powershell](https://stackoverflow.com/questions/22826185/setup-default-date-format-like-yyyy-mm-dd-in-powershell)

```powershell
function SetExportDateFormat {
<#
.SYNOPSIS
 Set the date to yyy-MM-dd HH:mm:ss.fff format in the current executing thread
.DESCRIPTION
 This is a replacement of the statements below as on some installations these properties are readonly 
 (Get-Culture).DateTimeFormat.ShortDatePattern = "yyyy-MM-dd"
 (Get-Culture).DateTimeFormat.ShortTimePattern = "HH:mm:ss.fff"
#>
    $currentThread = [System.Threading.Thread]::CurrentThread
    try { 
        $culture = [CultureInfo]::InvariantCulture.Clone() 
    } 
    Catch { 
        $culture = $CurrentThread.CurrentCulture.Clone() 
    }
    $culture.DateTimeFormat.ShortDatePattern = 'yyyy-MM-dd'
    $culture.DateTimeFormat.ShortTimePattern = 'hh:mm:ss.fff'
    $currentThread.CurrentCulture = $culture
    # Set below if the UI also needs to be updated
    # $currentThread.CurrentUICulture = $culture
}
```
