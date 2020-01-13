Import-Module "$PSScriptRoot/InstallAppFromRepository.psm1"

Install-AppFromRepository -RepositoryName "vcpkg" `
    -GitURL "https://github.com/microsoft/vcpkg.git" `
    -BootstrapCmd "bootstrap-vcpkg.bat"

Start-Process -WorkingDirectory $Path -FilePath "vcpkg.exe" -Verb RunAs -Wait -ArgumentList "integrate","install"
