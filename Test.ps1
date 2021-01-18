
param([string]$fname = "fname", [string]$lname ="lname",
$user_name = "uname", $end_date = "end_date",
$link_to_account = "Link_to_account")


# clear the screen for the readout
Clear-Host

# print the details to the screen for copy and paste

$screen = @" 
-----------------------------------------------------------------------
 
$lname, $fname 
 
$user_name

$fname.$lname@yarracity.vic.gov.au

“This account needs to be extended to: $end_date

\\yarrahome\users$\%username%


"@
write-host $screen

# the code to open the Outlook draft window for content Manager

$ol = New-Object -comObject Outlook.Application

$mail = $ol.CreateItem(0)
$null = $mail.recipients.add("alan.watson@yarracity.vic.gov.au")
$mail.Subject = "New Content Manager account creation – $fname $lname"
$mail.Body = @" 
Dear Records
 
Please create new accounts in HP Content manager for $fname $lname : 
 
Name: $lname, $fname 
 
Username: $user_name

Email: $fname.$lname@yarracity.vic.gov.au

Account expiry date: $end_date
 
Link to sharepoint form: 
$Link_to_account

Thanks for your help

"@

$mail.save()

$inspector = $mail.GetInspector
$inspector.Display()


