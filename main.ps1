<# References
https://bbs.nga.cn/read.php?tid=23375756&rand=331
https://superuser.com/questions/1324007/setting-window-size-and-position-in-powershell-5-and-6
https://stackoverflow.com/questions/6279076/how-to-use-win32-getmonitorinfo-in-net-c
#>

Param(
    [string] $Path,
    [switch] $AntiBlk
)

Function Set-GenshinRegistry {
    $Key = "HKCU:\Software\miHoYo\原神"
    $Name = "Screenmanager Is Fullscreen mode_h3981298716"
    if ((Test-Path $Key) -eq $false) { return }
    Set-ItemProperty $Key $Name 0 -type "Dword"
}

Function Get-GenshinPath {
    if ($Path) { return $Path }
    $CurrentDir = (Resolve-Path '.').Path;
    if (Test-Path "$CurrentDir\Genshin Impact Game\YuanShen.exe") {
        return $CurrentDir
    }
    Try {
        return (Get-ItemProperty "HKLM:\SOFTWARE\launcher" "InstPath" -ErrorAction Stop).InstPath
    }
    Catch {
        Write-Error "Genshin Impact executable file not found."
        Exit
    }
}

Function Set-ProcessWindowFullscreen {
    Param(
        [System.Diagnostics.Process] $Process
    )
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
    public static extern bool MoveWindow(IntPtr hWnd, int x, int y, int width, int height, bool repaint);

    [DllImport("user32.dll")]
    public static extern int GetWindowLong(IntPtr hWnd, int nIndex);

    [DllImport("user32.dll")]
    public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);

    [DllImport("user32.dll")]
    public static extern int MonitorFromWindow(IntPtr hWnd, int dwFlags);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool GetMonitorInfo(IntPtr hMon, ref MONITORINFO lpmi);
}

public struct RECT {
    public int Left;
    public int Top;
    public int Right;
    public int Bottom;
}

public struct MONITORINFO {
    public int  cbSize;
    public RECT rcMonitor;
    public RECT rcWork;
    public int  dwFlags;
}
"@
        }
    }
    Process {
        # Init
        $MONITOR_DEFAULTTONEAREST = 0x00000002;
        $WS_CAPTION = 0x00C00000
        $WS_SIZEBOX = 0x00040000
        $GWL_STYLE = -16
        $MonitorInfo = New-Object MONITORINFO
        $MonitorInfo.cbSize = 40;
        # Wait for main window launched
        $WaitCount = 0;
        Do {
            if (++$WaitCount -gt 600) {
                Write-Error "Genshin Impact launch timeout!"
                Exit
            }
            Start-Sleep -Milliseconds 50
            $HWnd = $Process.MainWindowHandle
        } While ($HWnd -eq 0)
        # Set window style and position
        $Style = [Window]::GetWindowLong($HWnd, $GWL_STYLE)
        [Window]::SetWindowLong($HWnd, $GWL_STYLE, $Style -band ( -bnot ($WS_CAPTION -bor $WS_SIZEBOX)))
        $HMon = [Window]::MonitorFromWindow($HWnd, $MONITOR_DEFAULTTONEAREST)
        [Window]::GetMonitorInfo($HMon, [ref]$MonitorInfo)
        $RcMon = $MonitorInfo.rcMonitor
        [Window]::MoveWindow($HWnd, $RcMon.Left, $RcMon.Top, $RcMon.Right - $RcMon.Left, $RcMon.Bottom - $RcMon.Top, $true)
    }
}

$GenshinPath = Get-GenshinPath
$GenshinBlkPath = "$GenshinPath\Genshin Impact Game\YuanShen_Data\Persistent\AssetBundles\blocks\00\29342328.blk"
$GenshinWorkDir = "$GenshinPath\Genshin Impact Game"
$GenshinExePath = "$GenshinWorkDir\YuanShen.exe"

if (Test-Path $GenshinExePath) {
    Set-GenshinRegistry
    if ($AntiBlk) { Remove-Item $GenshinBlkPath -Force -ErrorAction SilentlyContinue }
    $Process = Start-Process -FilePath $GenshinExePath -WorkingDirectory $GenshinWorkDir -PassThru
    Set-ProcessWindowFullscreen $Process
}
else {
    Write-Error "Genshin Impact executable file `"$GenshinExePath`" not found."
}
