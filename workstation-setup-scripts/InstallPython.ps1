Import-Module "$PSScriptRoot/InstallDownloadableApp.psm1"

Install-Downloadable-App -Filename "Anaconda3-2019.10-Windows-x86_64.exe" `
    -DownloadURL "https://repo.anaconda.com/archive/Anaconda3-2019.10-Windows-x86_64.exe" `
    -Args "/S","/InstallationType=AllUsers","/AddToPath=1","/RegisterPython=1","/NoRegistry=0"
