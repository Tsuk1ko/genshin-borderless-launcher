Param(
    [string] $Path,
    [switch] $DryRun
)

Function Set-GenshinRegistry {
    $Key = "HKCU:\Software\miHoYo\原神"
    $Name = "Screenmanager Is Fullscreen mode_h3981298716"
    try {
        if (((Test-Path $Key) -eq $true) -and ((Get-ItemPropertyValue $Key $Name -ErrorAction Stop) -ne 0)) {
            Set-ItemProperty $Key $Name 0 -type "Dword"
        }
    }
    catch {
        Write-Error "Genshin Impact registry not found."
        Exit
    }
}

Function Get-GenshinWorkDir {
    $CurDir = (Resolve-Path '.').Path;
    if ($Path) { $CurDir = $Path }
    Write-Host "Current directory:`t$CurDir"
    if (Test-Path "$CurDir\YuanShen.exe") {
        Write-Host "Test-Path 1 ok"
        return $CurDir
    }
    if (Test-Path "$CurDir\Genshin Impact Game\YuanShen.exe") {
        Write-Host "Test-Path 2 ok"
        return "$CurDir\Genshin Impact Game"
    }
    try {
        $RootDir = Get-ItemPropertyValue "HKLM:\SOFTWARE\launcher" "InstPath" -ErrorAction Stop
        Write-Host "From registry:`t`t$RootDir"
        return "$RootDir\Genshin Impact Game"
    }
    catch {
        Write-Error "Genshin Impact executable file not found."
        Exit
    }
}

$GenshinWorkDir = Get-GenshinWorkDir
$GenshinExePath = "$GenshinWorkDir\YuanShen.exe"

if (Test-Path $GenshinExePath) {
    if ($DryRun) { Exit }
    Set-GenshinRegistry
    Start-Process -FilePath $GenshinExePath -ArgumentList "-popupwindow" -WorkingDirectory $GenshinWorkDir
}
else {
    Write-Error "Genshin Impact executable file `"$GenshinExePath`" not found."
}
