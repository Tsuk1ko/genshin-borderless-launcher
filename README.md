# genshin-borderless-launcher

原神窗口全屏启动器，仅适用于国服

原理参考 [NGA [心得交流] 无边框窗口全屏小工具](https://bbs.nga.cn/read.php?tid=23375756)

## 使用方法

1. 将游戏设置的图像显示模式改为独占全屏，退出游戏
2. 下载 [genshin-launcher.exe](https://github.com/Tsuk1ko/genshin-borderless-launcher/releases/latest/download/genshin-launcher.exe)，一般情况下放在哪里都行  
   - 如果提示找不到原神可执行文件，请把 `genshin-launcher.exe` 放原神根目录，也可以使用 `-Path` 参数来指定
   - 根目录指的是官方启动器 `launcher.exe` 所在目录，不要放进 `Genshin Impact Game` 里，会导致游戏提示数据错误而无法进入游戏
3. 以后需要启动游戏的时候直接运行该 exe 即可

`genshin-launcher.exe` 由 `main.ps1` 通过 [PS2EXE](https://github.com/MScholtes/TechNet-Gallery/tree/master/PS2EXE-GUI) 封装而来，参数见 `build.ps1`，目的是方便使用管理员权限执行，如果不放心可以自己来

## 参数

你可以简单地创建快捷方式然后在“属性-快捷方式-目标”处添加参数

### `-Path`

可用于指定原神根目录，以下两种目录指定都是可行的，会自动识别：

```powershell
genshin-launcher.exe -Path "D:\Program Files\Genshin Impact"
genshin-launcher.exe -Path "D:\Program Files\Genshin Impact\Genshin Impact Game"
```

原神根目录获取优先级：`-Path` > 当前目录 > 从注册表获取

## 版权

`logo.ico` 是从原神官方启动器 `launcher.exe` 中提取的，版权归 miHoYo 所有
