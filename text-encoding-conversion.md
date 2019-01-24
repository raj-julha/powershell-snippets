# Convert UTF7 Text to UTF8

```powershell
$utf7Text = "+AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ+AFw-20190124+AFw-XYZ+AF8-Customer.fpr"
$expectedText = "\\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ\20190124\XYZ_Customer.fpr"
$utf8Enc = [System.Text.Encoding]::UTF8
$textBytes = $utf8Enc.GetBytes($utf7Text)

$convText = $utf7Enc.GetString($textBytes) # Output: \\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ\20190124\XYZ_Customer.fpr
$expectedText -eq $convText

```

# Convert UTF8 Text to UTF7

```powershell
$utf8Text = "\\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ\20190124\XYZ_Customer.fpr"
$expectedText = "+AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ+AFw-20190124+AFw-XYZ+AF8-Customer.fpr"
$utf7Enc = [System.Text.Encoding]::UTF7
$textBytes = $utf7Enc.GetBytes($utf8Text)

$convText = $utf8Enc.GetString($textBytes) # Output: +AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ+AFw-20190124+AFw-XYZ+AF8-Customer.fpr
$convText 
$expectedText -eq $convText

```

```powershell
$enc = [System.Text.Encoding]::UTF8
$consumerkey ="vz1evFS4wEEPTGEFPHBog"
$encconsumerkey= $enc.GetBytes($consumerkey)
$encconsumerkey

$enc = [System.Text.Encoding]::ASCII
$enc.GetString($encconsumerkey)

```