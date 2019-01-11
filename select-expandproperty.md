###### Use the -ExpandProperty argument in select when we need to get a list items as string rather than the typed object


```powershell
Get-Service | get-member
#  TypeName: System.ServiceProcess.ServiceController
Get-Service | Select DisplayName | gm # TypeName: Selected.System.ServiceProcess.ServiceController
Get-Service | Select -ExpandProperty DisplayName | gm #  TypeName: System.String

```

###### Use calculated properties when there's a need to combine or transform properties
[https://technet.microsoft.com/en-us/library/ff730948.aspx](https://technet.microsoft.com/en-us/library/ff730948.aspx)

```powershell
Get-Service | Select @{n="DisplayName"; e={$_.MachineName + "\"+$_.ServiceName}}

```
