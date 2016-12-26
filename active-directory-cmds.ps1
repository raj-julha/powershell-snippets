<#
Active Directory common commands
#>

<# Display list of groups to which teh uer is a member #>
$meinad = Get-ADUser -Identity windowsid -Properties *
$meinad.MemberOf
