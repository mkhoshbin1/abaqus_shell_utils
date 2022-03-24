# This script requires administrative privileges.
# The following code was taken from https://serverfault.com/a/1058407.
if (!
    #current role
    (New-Object Security.Principal.WindowsPrincipal(
        [Security.Principal.WindowsIdentity]::GetCurrent()
    #is admin?
    )).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
) {
    #elevate script and exit current non-elevated runtime
    Start-Process `
        -FilePath 'powershell' `
        -ArgumentList (
            #flatten to single array
            '-File', $MyInvocation.MyCommand.Source, $args `
            | %{ $_ }
        ) `
        -Verb RunAs
    exit
}

$current_env_path = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$current_env_path >> path_backup.txt
[Environment]::SetEnvironmentVariable('Path', "$current_env_path$PSScriptRoot", 'Machine')
Write-Host "Added $PSScriptRoot to the machine's Path Environment variable."
pause