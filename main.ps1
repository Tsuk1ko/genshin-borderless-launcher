Param(
    [string] $Path
)

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
    Start-Process -FilePath $GenshinExePath -ArgumentList "-popupwindow","-screen-fullscreen 0" -WorkingDirectory $GenshinWorkDir
}
else {
    Write-Error "Genshin Impact executable file `"$GenshinExePath`" not found."
}
