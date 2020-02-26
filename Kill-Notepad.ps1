#Created by Chris Sanders
#This will open a desired number of instances of notepad and then close ALL notepads that are open. (Even the ones that this script didn't start)
#Why?...well, because I can! 

Function Kill-Notepad{
            Param(
                [Parameter(mandatory=$true)]
                [String] $How_Many?
                )
$n = (1..$How_Many?)
Foreach($i in $n){
    	sleep -s 1
    	start-process notepad.exe
        $helper = New-Object -ComObject Shell.Application
        $helper.CascadeWindows()
        #$f = Get-Process | where -Property ProcessName -EQ powershell*
        Write-Host "There's $i notepad(s)"
        }
        sleep -Seconds 1
    Add-Type -AssemblyName System.Windows.Forms    
    $objForm = New-Object System.Windows.Forms.Form
    $objForm.Text = "Hi!!"
    $objForm.Size = New-Object System.Drawing.Size(220,100)
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(40,20) 
    $objLabel.Size = New-Object System.Drawing.Size(200,20)
    $objLabel.Text = "That's a lot of Notepads!!!"
    $objForm.Controls.Add($objLabel)
    $objForm.Show()| Out-Null
    Start-Sleep -Seconds 3
    $objForm.Controls.Remove($objLabel)
    $objLabel.Text = "Let's do something about that..."
    $objForm.Controls.Add($objLabel)
    Start-Sleep -Seconds 3
    $objForm.Controls.Remove($objLabel)
    $objLabel.Text = "Time to die!"
    $objForm.Controls.Add($objLabel)
    Start-Sleep -Seconds 3
    $objForm.Close() | Out-Null
        
Foreach($i in (Get-Process | where -Property ProcessName -EQ notepad)){
     
        Get-Process | where -Property ProcessName -EQ notepad | select -First 1 | kill
        Get-Process | where -Property ProcessName -EQ notepad | select id, ProcessName |ft        
        sleep 1
        $helper = New-Object -ComObject Shell.Application
        $helper.CascadeWindows()
        }
    Add-Type -AssemblyName System.Windows.Forms    
    $objForm = New-Object System.Windows.Forms.Form
    $objForm.Text = "Hi!!"
    $objForm.Size = New-Object System.Drawing.Size(220,100)
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(40,20) 
    $objLabel.Size = New-Object System.Drawing.Size(200,20)
    $objLabel.Text = "There! I cleaned it up!"
    $objForm.Controls.Add($objLabel)
    $objForm.Show()| Out-Null
    Start-Sleep -Seconds 4
    $objForm.Close() | Out-Null
}
