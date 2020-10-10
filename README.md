# genshin-launcher

原神窗口全屏启动器，原理参考 NGA [[心得交流] 无边框窗口全屏小工具](https://bbs.nga.cn/read.php?tid=23375756)

## 使用方法

1. 将游戏设置的图像显示模式改为独占全屏，退出游戏
2. 下载 [genshin-launcher.exe](https://github.com/Tsuk1ko/genshin-launcher/releases/latest/download/genshin-launcher.exe)
3. 以后需要启动游戏的时候直接运行该 exe 即可

Release 由 `main.ps1` 通过 [PS2EXE](https://github.com/MScholtes/TechNet-Gallery/tree/master/PS2EXE-GUI) 封装而来，目的是方便使用管理员权限执行，如果不放心可以自己来

## 参数

你可以简单地创建快捷方式然后在“属性-快捷方式-目标”处添加参数

### `-Path`

原神根目录是从注册表中获取的，如果你不是正常安装的原神可能需要使用该参数来指定，例：

```powershell
genshin-launcher.exe -Path "D:\Program Files\Genshin Impact"
```

### `-AntiBlk`

加上该参数会在启动原神前自动删除 `29342328.blk` 以反和谐

> [[破事氵] 悲报，mhy真的将修bug和河蟹的热更新封装在一起了](https://bbs.nga.cn/read.php?tid=23672923)
>
> 请自行决定是否要反和谐，v0.1.0 之前为自动反和谐，如不愿自动反和谐请重新下载新版
