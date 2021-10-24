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
    $username = '{0}{1}' -f $LastName.Substring(0,6), $FirstName.Substring(0,1)
    
}   catch {
    Write-Error -Message $_.exception.message
}



Write-Host $username
