<#
.SYNOPSIS
 combine multiple lists that have a common field into a list list with each list a a column
 in a new dataset

.DESCRIPTION
 combine multiple lists that have a common field into a list list with each list a a column
 in a new dataset

 ListA
 DocNo Field1
 ----- ------
 1     ListA_Field1_1
 2     ListA_Field1_2
 3     ListA_Field1_3
 
 ListB
 DocNo Field2
 ----- ------
 1     ListB_Field2_1
 2     ListB_Field2_2
 3     ListB_Field2_3

 ListC
 DocNo Field3
 ----- ------
 1     ListC_Field3_1
 2     ListC_Field3_2
 3     ListC_Field3_3

 Expected Merged List

 DocNo Field1           Field2          Field3
 ----- ------           ------          ------
 1     ListA_Field1_1   ListB_Field2_1  ListC_Field3_1
 2     ListA_Field1_2   ListB_Field2_2  ListC_Field3_2
 3     ListA_Field1_3   ListB_Field2_3  ListC_Field3_3



.NOTES

#>
$List1AsJson = @"
{
    "AccountNo":  [
                          {
                              "DocNo":  1,
                              "AccountNo":  "752318102"
                          },
                          {
                              "DocNo":  2,
                              "AccountNo":  "250263845"
                          }
                      ],
    "FirstName":  [
                          {
                              "DocNo":  1,
                              "FirstName":  "Joe"
                          },
                          {
                              "DocNo":  2,
                              "FirstName":  "Jane"
                          }
                      ],
    "ImageName":  [
                  {
                      "DocNo":  1,
                      "ImageName":  "INV_001.pdf"
                  },
                  {
                      "DocNo":  2,
                      "ImageName":  "INV_002.pdf"
                  }
              ]
}
"@

$List1 = ConvertFrom-Json -InputObject $List1AsJson

$List1 
<#
AccountNo                                                          FirstName                                               ImageName                                     
---------                                                          ---------                                               ---------                                     
{@{DocNo=1; AccountNo=752318102}, @{DocNo=2; AccountNo=250263845}} {@{DocNo=1; FirstName=Joe}, @{DocNo=2; FirstName=Jane}} {@{DocNo=1; ImageName=INV_001.pdf}, @{DocNo...

#>


$List1.AccountNo
<#
DocNo AccountNo
----- ---------
    1 752318102
    2 250263845

#>

$List1.ImageName
<#
DocNo ImageName  
----- ---------  
    1 INV_001.pdf
    2 INV_002.pdf
#>

# The $Record variable should be defined as a PSCustomObject, without it the list doesn't show as a table
$List1.AccountNo.ForEach({
        
        $Record = [PSCustomObject]@{
                AccountNo = $_.AccountNo
                ImageName = "ImageName $($_.DocNo)"
            }
        $Record
    }
)

$List1.AccountNo.ForEach({       
        $DocNo = $_.DocNo
        $Record = [PSCustomObject]@{
                DocNo = $DocNo
                AccountNo = $_.AccountNo
                FirstName = $List1.FirstName.Where({$_.DocNo -eq $DocNo}, 'First').FirstName
                ImageName = $List1.ImageName.Where({$_.DocNo -eq $DocNo}, 'First').ImageName # "Image $($_.DocNo)"
            }
        $Record
    }
)

<#
DocNo AccountNo FirstName ImageName  
----- --------- --------- ---------  
    1 752318102 Joe       INV_001.pdf
    2 250263845 Jane      INV_002.pdf


#>
