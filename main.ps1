<# References
https://bbs.nga.cn/read.php?tid=23375756&rand=331
https://superuser.com/questions/1324007/setting-window-size-and-position-in-powershell-5-and-6
https://stackoverflow.com/questions/6279076/how-to-use-win32-getmonitorinfo-in-net-c
#>

$script:GsPath = $args[0];

Function Set-GenshinRegistry {
    $Key = "HKCU:\Software\miHoYo\原神"
    $Name = "Screenmanager Is Fullscreen mode_h3981298716"
    if ((Test-Path $key) -eq $false) { return }
    Set-ItemProperty $Key $Name 0 -type "Dword"
}

Function Get-GenshinPath {
    if ($script:GsPath) {
        return $script:GsPath
    }
    return (Get-ItemProperty "HKLM:\SOFTWARE\launcher" "InstPath").InstPath
}

Function Set-GenshinFullscreen {
    Begin {
        Try {
            [void][Window]
        }
        Catch {
            Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Window {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool MoveWindow(IntPtr hWnd, int x, int y, int width, int height, bool repaint);

    [DllImport("user32.dll")]
    public static extern int GetWindowLong(IntPtr hWnd, int nIndex);

    [DllImport("user32.dll")]
    public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);

    [DllImport("user32.dll")]
    public static extern int GetDC(IntPtr hwnd);

    [DllImport("gdi32.dll")]
    public static extern int GetDeviceCaps(IntPtr hdc, int nIndex);
}

public struct RECT {
    public int Left;
    public int Top;
    public int Right;
    public int Bottom;
}
"@
        }
    }
    Process {
        $WS_CAPTION = 0x00C00000
        $WS_SIZEBOX = 0x00040000
        $GWL_STYLE = -16
        $Rectangle = New-Object RECT
        $script:LoopCount = 0;
        do {
            Start-Sleep -Milliseconds 100
            $script:ContinueLoop = $true
            $script:LoopCount++
            $Processes = Get-Process -Name "YuanShen" -ErrorAction SilentlyContinue
            if ($Processes) {
                $Processes | ForEach-Object {
                    $HWnd = $_.MainWindowHandle
                    if ( $HWnd -eq [System.IntPtr]::Zero ) { return }
                    [Window]::GetWindowRect($HWnd, [ref]$Rectangle)
                    $Style = [Window]::GetWindowLong($HWnd, $GWL_STYLE)
                    [Window]::SetWindowLong($HWnd, $GWL_STYLE, $Style -band ( -bnot ($WS_CAPTION -bor $WS_SIZEBOX)))
                    $MonDC = [Window]::GetDC($HWnd)
                    $Width = [Window]::GetDeviceCaps($MonDC, 118)
                    $Height = [Window]::GetDeviceCaps($MonDC, 117)
                    [Window]::MoveWindow($HWnd, $Rectangle.Left, $Rectangle.Top, $Width, $Height, $true)
                    $script:ContinueLoop = $false
                }
            }
        } while ($script:ContinueLoop -and ($script:LoopCount -le 300))
    }
}

$GenshinPath = Get-GenshinPath
$GenshinBlkPath = "$GenshinPath\Genshin Impact Game\YuanShen_Data\Persistent\AssetBundles\blocks\00\29342328.blk"
$GenshinExePath = "$GenshinPath\Genshin Impact Game\YuanShen.exe"

if (Test-Path $GenshinExePath) {
    Set-GenshinRegistry
    Remove-Item $GenshinBlkPath -Force -ErrorAction SilentlyContinue
    &$GenshinExePath
    Set-GenshinFullscreen
}
else {
    Write-Error "Path `"$GenshinExePath`" not found."
}
