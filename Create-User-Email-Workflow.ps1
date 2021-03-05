<#
     .Synopsis
     Helper for when we are adding new user accounts.
     .DESCRIPTION
     Helper for when we are adding new user accounts.
     This script both shows some of the information required to be entered into our systems,
     ready to be copy and pasted in and also prepares the emails that need to be sent after making the accounts.
     .EXAMPLE
     Example of how to use this cmdlet
     .\User-add-prompt.ps1
     .EXAMPLE
     .\User-add-prompt.ps1 -fname Joe -lname Bloggs -user_name BloggsJ -end_date 3/3/2020 -link_to_account http://link-to-the-account.com
     .NOTES
     Author: Alan Watson
     Contact: placebo_al@hotmail.com
#>


param(
    [Parameter(Mandatory)]
    [string]$fname = (read-host -Prompt "Enter the first name: "),
    [Parameter(Mandatory)] 
    [string]$lname = (read-host -Prompt "Enter the last name: "),
    [Parameter(Mandatory)]
    [string]$user_name = (read-host -Prompt "Enter the user name: "),
    [Parameter(Mandatory)]
    [string]$end_date = (read-host -Prompt "Enter the users end date, if permanent just add permanent: "),
    [Parameter(Mandatory)]
    [string]$link_to_account = (read-host -Prompt "Add the link to the user form: ")
)

# clear the screen for the readout
Clear-Host

# print the details to the screen for copy and paste
$screen = @" 
-----------------------------------------------------------------------

$fname $lname

$lname, $fname 
 
$user_name

This account needs to be extended to: $end_date


-----------------------------------------------------------------------
"@
write-host $screen

# The one stop for the footer and header to try and tidy the code a little bit

$header = @"
<!DOCTYPE html>
<html>
<head>
<style>
<!--
pre { white-space: pre-wrap; font-family: calibri; color: #000000; background-color: #ffffff; }
body { font-family: calibri; color: #000000; background-color: #ffffff; }
* { font-size: 14px; }
-->
</style>
</head>
<body>
<pre id='vimCodeElement'>
"@

$footer = @'
<p>Thanks</p>
<span>Email: <a href="mailto:placebo_al@hotmail.com">placebo_al@hotmail.com</a></span>
</pre>
</body>
</html>
'@


# First email for account creation

$email1 = "records@gmail.com"
$Subject1 = "New account creation – $fname $lname"
$Body1 = @"
$header

We have just created the account for $fname $lname

Account expiring $end_date

Username: $user_name

$footer
"@


# Second email for account creation

$email2 = "records@gmail.com"
$Subject2 = "New account creation – $fname $lname"
$Body2 = @"
$header

We have just created the account for $fname $lname

Account expiring $end_date

Username: $user_name

$footer
"@


# Third email for account creation

$email3 = "records@gmail.com"
$Subject3 = "New account creation – $fname $lname"
$Body3 = @"
$header

We have just created the account for $fname $lname

Account expiring $end_date

Username: $user_name

$footer
"@


# Function for sending the emails
function SendEmail {
    param (
        [string]$To, 
        [string]$Subject, 
        [string]$Body
    )

    $ol = New-Object -comObject Outlook.Application
    $mail = $ol.CreateItem(0)
    
    $mail.To = $To
    $mail.Subject = "$Subject"
    $mail.HTMLBody = "$Body"

    $mail.save()
    $inspector = $mail.GetInspector
    $inspector.Display()
}


function Show-Menu
{
     param (
           [string]$Title = 'My Menu'
     )
     # cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' to email for Email 1."
     Write-Host "2: Press '2' to email for Email 2."
     Write-Host "3: Press '3' to email for Email 3."
     Write-Host "Q: Press 'Q' to quit."
}
do
{
     Show-Menu
     $email_choice = Read-Host "Please make a selection"
     switch ($email_choice)
     {
           '1' {
                Clear-Host
                'You chose option #Records'
                SendEmail -To $email1 -Subject $Subject1 -Body $Body1
           } '2' {
                Clear-Host
                'You chose option #Oracle'
                SendEmail -To $Email2 -Subject $Subject2 -Body $Body2
           } '3' {
                Clear-Host
                'You chose option #Enterprise'
                SendEmail -To $Email3 -Subject $Subject3 -Body $Body3
           }'q' {
                return
           }
     }
     # pause
}
until ($input -eq 'q')
