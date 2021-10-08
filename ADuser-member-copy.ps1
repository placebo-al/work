function copy-ActiveUser {
param(
    [Parameter(Mandatory)]
    [string] $CopyToUser = (Read-Host -Prompt 'Please enter the user you want to add to: '),
    [Parameter(Mandatory)]
    [string] $CopyFromUser = (Read-Host -Prompt 'Please enter a username for the user you want to copy: ')
)

$CFUser = Get-ADUser $CopyFromUser -Properties MemberOf
$CTUser = Get-ADUser $CopyToUser -Properties MemberOf
$CFUser.MemberOf | Where-Object{$CTUser.MemberOf -notcontains $_} |  Add-ADGroupMember -Members $CTUser
}