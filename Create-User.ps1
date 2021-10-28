#requires -module ActiveDirectory

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$FirstName = (read-host -Prompt "Enter the first name: "),
    [Parameter(Mandatory)] 
    [string]$LastName = (read-host -Prompt "Enter the last name: ")
    # [Parameter(Mandatory)] 
    # [string]$Department = (read-host -Prompt "Enter the department name: "),
    # [Parameter(Mandatory)]
    # [string]$end_date = (read-host -Prompt "Enter the users end date, if permanent just add permanent: "),
)

try {
    if ($LastName.length -gt 6){
        $username = '{0}{1}' -f $LastName.Substring(0,6), $FirstName.Substring(0,1)
    }
    else {
        $username ='{0}{1}' -f  $LastName.Substring(0,$LastName.Length),$FirstName.Substring(0,1)
    }

$i=2
while ((Get-ADUser -Filter "samAccountName -eq '$username'") -and ($username.Length -lt 10 )) {
    Write-Warning -Message "The username [$($username)] already exists. "
    Write-Warning -Message "The user account is for [$(Get-ADUser -Filter "samAccountName -eq '$username'"| Select-Object GivenName, Surname )]"
    $username = '{0}{1}' -f $LastName.Substring(0,6), $FirstName.Substring(0,$i)
    Start-Sleep -Seconds 2
    $i++
}

Write-Host $username

}   catch {
    Write-Error -Message $_.exception.message
}
