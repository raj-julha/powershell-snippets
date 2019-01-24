# Convert UTF8 Text to UTF7

* Instantiate a UTF7 encoder
* Invoke the GetBytes method of the UTF7 encoder and passing the UTF8 string as argument
* Instantiate a UTF8 encoder
* Invoke the GetString method of the UTF8 encoder and passing the byte array from the UTF7 encoder

```powershell
$utf8Text = "\\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ397_Customer.fpr"
$expectedText = "+AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ397+AF8-Customer.fpr"
$utf7Enc = [System.Text.Encoding]::UTF7
$textBytes = $utf7Enc.GetBytes($utf8Text)

$utf8Enc = [System.Text.Encoding]::UTF8

$convText = $utf8Enc.GetString($textBytes) 

$convText 
# Output: +AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ397+AF8-Customer.fpr
$convText -eq $expectedText


```

# Convert UTF7 Text to UTF8

* Instantiate a UTF8 encoder
* Invoke the GetBytes method of the UTF8 encoder and passing the UTF7 string as argument
* Instantiate a UTF7 encoder
* Invoke the GetString method of the UTF7 encoder and passing the byte array from the UTF8 encoder

```powershell
$utf7Text = "+AFwAXA-SERVER04+AFw-SHARE1+AFw-Level1+AFw-PROJ+AF8-Level2+AFw-XYZ397+AF8-Customer.fpr"
$expectedText = "\\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ397_Customer.fpr"
$utf8Enc = [System.Text.Encoding]::UTF8
$textBytes = $utf8Enc.GetBytes($utf7Text)

$utf7Enc = [System.Text.Encoding]::UTF7

$convText = $utf7Enc.GetString($textBytes) 
$convText
# Output: \\SERVER04\SHARE1\Level1\PROJ_Level2\XYZ397_Customer.fpr
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