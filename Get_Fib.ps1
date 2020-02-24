Function Get-Fib{
    Param(
    [Parameter(Mandatory=$true)]
    [int64] $What_should_we_count_to?
        )
    $x = 1
    $y = 1
    $i = 1
    While($x -lt $What_should_we_count_to?){
        "Iteration $i is $x"
        $z = $x + $y
        $x = $y
        $y = $z
        $i = $i + 1
                                            }
                }