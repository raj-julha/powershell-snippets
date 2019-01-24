$utf7Text = "+AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ397+AF8-Customer.fpr"
$expectedText = "\\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ397_Customer.fpr"
$utf8Enc = [System.Text.Encoding]::UTF8
$textBytes = $utf8Enc.GetBytes($utf7Text)


$utf7Enc = [System.Text.Encoding]::UTF7

$convText = $utf7Enc.GetString($textBytes) # Output: \\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ397_Customer.fpr
$convText
$expectedText -eq $convText
