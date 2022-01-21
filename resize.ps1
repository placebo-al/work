Function Resize-Photo {
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
    begin{    
        if (!(Test-Path -Path $Path))
        {
            throw "File $($Path) not found";
        }
    }
    process{
        # Rename the file
        $parentPath = $Path | Split-Path
        $imageWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($Path)
        $imageExt = [System.IO.Path]::GetExtension($Path)
        $newFileName = Join-Path -Path $parentPath -ChildPath "$imageWithoutExt-$MaximumWidth-$MaximumHeight$imageExt"
        # make the image file
        $wia = New-Object -com wia.imagefile
        $wia.LoadFile($Path) 2>&1 | Out-Null
        $wip = New-Object -ComObject wia.imageprocess
        $scale = $wip.FilterInfos.Item("Scale").FilterId
        $wip.Filters.Add($scale)
        $wip.Filters[1].Properties("MaximumWidth") = $MaximumWidth
        $wip.Filters[1].Properties("MaximumHeight") = $MaximumHeight
        # aspect ratio should be set to false if you want the pics in exact size
        $wip.Filters[1].Properties("PreserveAspectRatio") = $true
        $newimg = $wip.Apply($wia)
        $newimg.SaveFile($newFileName) 2>&1 | Out-Null
    }
    end{
        return $newFileName
    }
}



Resize-Photo -Path C:\Users\watsona\Desktop\danaroj2.jpg -MaximumWidth 256 -MaximumHeight 256
