#Counter function by Chris Sanders
#Counts by desired interval to specified number, converts to binary, octal, and hexadecimal equivalent and outputs resultant object as a table
Function Count{
                Param(
                [Parameter(Mandatory=$true)]
                [int32]$Number_to_count_by?,
                [Parameter(Mandatory=$true)]
                [int32]$Number_to_count_to?
                )
                $x=0
                while($x -le ($Number_to_count_to?)){
                $Binary = [convert]::ToString($x,2)
                $Octal = [convert]::ToString($x,8)
                $Hexadecimal = [convert]::ToString($x,16)

                $obj = New-Object psobject -Property @{`
                        "Decimal" = $x;
                        "Binary" = $Binary;
                        "Octal" = $Octal;
                        "Hex" = $Hexadecimal}
                $obj | select Decimal,Binary,Octal,Hex

                $x = ($x + $Number_to_count_by?)
                }
                }