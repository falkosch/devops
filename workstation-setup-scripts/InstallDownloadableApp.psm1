Import-Module BitsTransfer
Import-Module Microsoft.PowerShell.Management

function Install-Downloadable-App {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Filename,

        [Parameter(Mandatory = $true)]
        [string]
        $DownloadURL,

        [Parameter()]
        [string[]]
        $Args = @()
    )

    New-Item -ItemType "directory" -Force -Path "$PSScriptRoot/download" | out-null
    $Path = "$PSScriptRoot/download/$Filename"

    If (!(Test-Path $Path)) {
        Start-BitsTransfer -Source $DownloadURL -Destination $Path
    }

    Start-Process -FilePath $Path -Wait -Verb RunAs -ArgumentList $Args
}
Export-ModuleMember -Function Install-App
