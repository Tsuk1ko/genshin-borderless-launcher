# genshin-borderless-launcher

原神窗口全屏启动器，仅适用于国服

## 它做了什么

0. 操作前，原神的显示模式是独占全屏
1. 将注册表中 `HKCU:\Software\miHoYo\原神\Screenmanager Is Fullscreen mode_h3981298716` 的值设置为 `0`，作用是将原神设置为窗口模式，因为原神设置中满分辨率只有独占全屏而没有窗口
2. 使用 `-popupwindow` 参数启动原神进程，作用是隐藏标题栏和窗口边框，[这是 Unity Standalone Player 通用的一个命令行参数](https://docs.unity3d.com/cn/current/Manual/CommandLineArguments.html)

> 你可以直接按照上面的步骤手动操作来达到同样的效果，第二步你只要给原神进程创建一个快捷方式并加上参数即可，本启动器仅相当于一个懒人脚本而已
>
> `genshin-launcher.exe` 由 `main.ps1` 通过 [PS2EXE](https://github.com/MScholtes/TechNet-Gallery/tree/master/PS2EXE-GUI) 封装而来，参数见 `build.ps1`，目的是方便使用管理员权限执行，如果不放心可以自己来

## 使用方法

1. 将原神设置的图像显示模式改为独占全屏，退出原神
2. 下载 [genshin-launcher.exe](https://github.com/Tsuk1ko/genshin-borderless-launcher/releases/latest/download/genshin-launcher.exe)，一般情况下放在哪里都行  
   - 如果提示找不到原神可执行文件，请把 `genshin-launcher.exe` 放原神根目录，也可以使用 `-Path` 参数来指定
   - 根目录指的是官方启动器 `launcher.exe` 所在目录，不要放进 `Genshin Impact Game` 里，会导致原神提示数据错误而无法进入游戏
3. 以后需要启动原神的时候直接运行该 exe 即可

## 参数

你可以简单地创建快捷方式然后在“属性-快捷方式-目标”处添加参数

### `-Path`

可用于指定原神根目录，以下示例的两种目录指定都是可行的，会自动识别：

```powershell
genshin-launcher.exe -Path "X:\Program Files\Genshin Impact"
genshin-launcher.exe -Path "X:\Program Files\Genshin Impact\Genshin Impact Game"
```

原神根目录获取优先级：`-Path` > 当前目录 > 从注册表获取

## 版权

`logo.ico` 是从原神官方启动器 `launcher.exe` 中提取的，版权归 miHoYo 所有
