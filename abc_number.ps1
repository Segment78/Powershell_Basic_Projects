#ABC-Number by Chris Sanders
#Creates function to provide corresponding alphabet letter to number input.
function ABC-Number{
                    Param(
                          [Parameter(Mandatory=$true)]
                          [string] $Letter_Number?
                          )
$alphabet = 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'
Write-host 'Letter', $Letter_Number?, 'is' $alphabet[($Letter_Number?-1)]
                    }