<#
Active Directory common commands
#>

<# Display list of groups to which the user is a member #>
$meinad = Get-ADUser -Identity windowsid -Properties *
$meinad.MemberOf
