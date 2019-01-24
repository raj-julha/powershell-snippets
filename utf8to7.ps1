$utf8Text = "\\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ397_Customer.fpr"
$expectedText = "+AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ397+AF8-Customer.fpr"
$utf7Enc = [System.Text.Encoding]::UTF7
$textBytes = $utf7Enc.GetBytes($utf8Text)

$utf8Enc = [System.Text.Encoding]::UTF8

$convText = $utf8Enc.GetString($textBytes) # Output: +AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ397+AF8-Customer.fpr
$convText 
$convText -eq $expectedText