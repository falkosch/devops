Import-Module BitsTransfer
Import-Module Microsoft.PowerShell.Management

function Install-AppFromDownload {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Filename,

        [Parameter(Mandatory = $true)]
        [string]
        $DownloadURL,

        [Parameter(Mandatory = $False)]
        [string[]]
        $ArgumentsList = @()
    )

    $DownloadRoot = "$PSScriptRoot/download"
    New-Item -ItemType "directory" -Force -Path $DownloadRoot | out-null

    $Path = "$DownloadRoot/$Filename"
    If (!(Test-Path $Path)) {
        Start-BitsTransfer -Source $DownloadURL -Destination $Path
    }

    If ($ArgumentsList.Count -gt 0) {
        Start-Process -FilePath $Path -Wait -Verb RunAs -ArgumentList $ArgumentsList
    }
    Else {
        Start-Process -FilePath $Path -Wait -Verb RunAs
    }

    Return $Path
}
Export-ModuleMember -Function Install-AppFromDownload
