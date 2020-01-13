Import-Module BitsTransfer
Import-Module Microsoft.PowerShell.Management

function Install-AppFromRepository {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $RepositoryName,

        [Parameter(Mandatory = $true)]
        [string]
        $GitURL,

        [Parameter(Mandatory = $False)]
        [string]
        $BootstrapCmd,

        [Parameter(Mandatory = $False)]
        [string[]]
        $ArgumentsList = @()
    )

    $RepositoriesRoot = "$PSScriptRoot/repositories"
    New-Item -ItemType "directory" -Force -Path $RepositoriesRoot | out-null

    $Path = "$RepositoriesRoot/$RepositoryName"
    If (!(Test-Path $Path)) {
        & git clone $GitURL $Path
    }

    If (!([string]::IsNullOrWhitespace($BootstrapCmd))) {
        If ($ArgumentsList.Count -gt 0) {
            Start-Process -WorkingDirectory $Path -FilePath $BootstrapCmd -Verb RunAs -Wait -ArgumentList $ArgumentsList
        }
        Else {
            Start-Process -WorkingDirectory $Path -FilePath $BootstrapCmd -Verb RunAs -Wait
        }
    }

    Return $Path
}
Export-ModuleMember -Function Install-AppFromRepository
