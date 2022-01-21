#requires -module ActiveDirectory

# [CmdletBinding()]
# param(
#     [Parameter(Mandatory)]
#     [ValidateNotNullOrEmpty()]
#     [string]$FirstName = "alan",
    
#     [Parameter(Mandatory)] 
#     [ValidateNotNullOrEmpty()]
#     [string]$LastName = "Watson",
    
#     [Parameter(Mandatory)]
#     [ValidateNotNullOrEmpty()] 
#     [string]$Department = "Janitor"
    
# )

$FirstName = "alan"
$LastName = "Watson"
$Department = "Janitor"
$HomeDir = "`\`\blah`\blahs`$`\"

try {
    if ($LastName.length -gt 6){
        $username = '{0}{1}' -f $LastName.Substring(0,6), $FirstName.Substring(0,1)
    }
    else {
        $username ='{0}{1}' -f  $LastName.Substring(0,$LastName.Length),$FirstName.Substring(0,1)
    }
    $i=2
    while ((Get-ADUser -Filter "samAccountName -eq '$username'") -and ($username.Length -lt 10 )) {
        Write-Warning -Message "The username $($username) already exists. "
        Write-Warning -Message "The user account is for $(Get-ADUser -Identity $username | Select-Object Name )"
        $username = '{0}{1}' -f $LastName.Substring(0,6), $FirstName.Substring(0,$i)
        Start-Sleep -Seconds 2
        $i++
    }
    Add-Type -AssemblyName System.Web;
    # $password = [System.Web.Security.Membership]::GeneratePassword(12,3)

    $newUserParams = [ordered]@{
        GivenName             = $FirstName
        Surname               = $LastName
        Name                  = $userName
        DisplayName           = "$LastName, $FirstName"
        AccountPassword       = $password
        #ChangePasswordAtLogon = $true
        #Enabled               = $true
        Department            = $Department
        HomeDirectory         = "$Homedir$username"
        #Confirm               = $false
    }

$newUserParams

}   catch {
    Write-Error -Message $_.exception.message
}
