#requires -Module ActiveDirectory

[CmdletBinding()]
param (
  [Parameter(Mandatory=$true)]
  [string]$Username,
  
  [Parameter(Mandatory=$true)]
  [string]$ImagePath
)

Import-Module ActiveDirectory -ErrorAction SilentlyContinue

Function ResizeForAD {
 param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Path,

    [Parameter(Mandatory)]
	  [ValidateNotNullOrEmpty()]
    [Int]$MaximumWidth,

    [Parameter(Mandatory)]
	  [ValidateNotNullOrEmpty()]
    [Int]$MaximumHeight
  )

    if (!$Path)
    {
      throw "Path Missing";
    }

    if (!(Test-Path -Path $Path))
    {
      throw "File $($Path) not found";
    }

    $parentPath = $Path | Split-Path
    $imageWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    $imageExt = [System.IO.Path]::GetExtension($Path)
    $newFileName = Join-Path -Path $parentPath -ChildPath "$imageWithoutExt-$MaximumWidth-$MaximumHeight$imageExt"

    $wia = New-Object -com wia.imagefile
    $wia.LoadFile($Path) 2>&1 | Out-Null
    $wip = New-Object -ComObject wia.imageprocess
    $scale = $wip.FilterInfos.Item("Scale").FilterId
    $wip.Filters.Add($scale)
    $wip.Filters[1].Properties("MaximumWidth") = $MaximumWidth
    $wip.Filters[1].Properties("MaximumHeight") = $MaximumHeight
    #aspect ratio should be set as false if you want the pics in exact size
    $wip.Filters[1].Properties("PreserveAspectRatio") = $true
    #$wip.Apply($wia)
    $newimg = $wip.Apply($wia)
    $newimg.SaveFile($newFileName) 2>&1 | Out-Null

    return $newFileName
}

if (!(Test-Path -Path $ImagePath))
{
  throw "File $($ImagePath) not found";
}

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/?proxyMethod=RPS -Credential (Get-Credential) -Authentication Basic -AllowRedirection
Import-PSSession $Session -AllowClobber -WarningAction SilentlyContinue -ErrorAction SilentlyContinue

$parentPath = $ImagePath | Split-Path
$imageWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($ImagePath)
$imageExt = [System.IO.Path]::GetExtension($ImagePath)
#$newFileName = Join-Path -Path $parentPath -ChildPath "$imageWithoutExt-96-96$imageExt"
#$azureFileName = Join-Path -Path $parentPath -ChildPath "$imageWithoutExt-512-512$imageExt"

$newFileName = ResizeForAD -Path $ImagePath -MaximumWidth 96 -MaximumHeight 96
$azureFileName = ResizeForAD -Path $ImagePath -MaximumWidth 512 -MaximumHeight 512

$photo = [byte[]] (Get-Content $newFileName -Encoding byte)
$azurePhoto = [byte[]] (Get-Content $azureFileName -Encoding byte)

Set-ADUser $Username -Replace @{thumbnailPhoto=$photo}
Set-UserPhoto -Identity $Username -PictureData $azurePhoto