# Rebuild hxcpp static libs with a clean object cache (avoids mixed /MT / /MD / /MDd in libMain*.lib).
# Usage: .\rebuild-hxcpp.ps1 [-Configuration Debug|Release|Both]
param(
    [ValidateSet('Debug', 'Release', 'Both')]
    [string] $Configuration = 'Both'
)
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$hxCppOut = Join-Path (Split-Path $here -Parent) 'HxCppOut'
$obj = Join-Path $hxCppOut 'obj'
if (Test-Path $obj) {
    Remove-Item -Recurse -Force $obj
    Write-Host "Removed $obj"
}
Push-Location $here
try {
    if ($Configuration -eq 'Debug' -or $Configuration -eq 'Both') {
        haxe build-cpp-debug.hxml
    }
    if ($Configuration -eq 'Release' -or $Configuration -eq 'Both') {
        haxe build-cpp.hxml
    }
}
finally {
    Pop-Location
}
