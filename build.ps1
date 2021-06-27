$version = (git rev-list --tags --max-count=1 | git describe --tags) -replace 'v', '' -replace '-.*', ''
Remove-Item genshin-launcher.exe -Force -ErrorAction SilentlyContinue
ps2exe main.ps1 genshin-launcher.exe -noConsole -iconFile logo.ico -title "Genshin Impact Launcher" -product "Genshin Impact Launcher" -copyright "Tsuk1ko/genshin-launcher" -noOutput -version $version
