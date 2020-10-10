# genshin-launcher

原神窗口全屏启动器，顺便自动删除 blk 文件以反和谐

窗口全屏的原理参考 NGA [[心得交流] 无边框窗口全屏小工具](https://bbs.nga.cn/read.php?tid=23375756&rand=331)

## 使用方法

1. 将游戏设置的图像显示模式改为独占全屏，退出游戏
2. 下载 [genshin-launcher.exe](https://github.com/Tsuk1ko/genshin-launcher/releases/latest/download/genshin-launcher.exe)
3. 以后需要启动游戏的时候直接运行该 exe 即可

## 其他说明

1. 可执行文件由 `main.ps1` 通过 [PS2EXE](https://github.com/MScholtes/TechNet-Gallery/tree/master/PS2EXE-GUI) 封装而来，目的是方便使用管理员权限执行，如果不放心可以自己来
2. 原神根目录是从注册表中获取的，如果你不是正常安装的原神可能无法直接使用，可将原神根目录路径作为第一个参数来运行该 exe
3. 仅在运行前会删除 blk 文件，如果游戏更新，你需要关闭再启动一次才能应用反和谐
