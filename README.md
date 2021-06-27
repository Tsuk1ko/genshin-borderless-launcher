# genshin-borderless-launcher

这个启动器已经没有存在的必要了，你只需要使用两个参数就可以让原神窗口全屏启动

## 教程

0. 将原神调整至独占全屏，退出游戏
1. 打开 `YuanShen.exe` 所在目录，例如 `C:\Program Files\Genshin Impact\Genshin Impact Game`
2. 右击 `YuanShen.exe`，发送到 > 桌面快捷方式
3. 右击桌面上刚创建的快捷方式，属性
4. 在“目标”的最末尾加上 `-popupwindow -screen-fullscreen 0`（前面要加个空格），使其变为例如 `"C:\Program Files\Genshin Impact\Genshin Impact Game\YuanShen.exe" -popupwindow -screen-fullscreen 0`，确定保存
5. 使用这个快捷方式启动游戏

## 如何恢复独占全屏

两种方法任选其一

1. 进入游戏，设置成窗口模式，再设置成独占全屏
2. 将 `-screen-fullscreen 0` 改为 `-screen-fullscreen 1`，使用快捷方式启动游戏一次

## 原理

<https://docs.unity3d.com/cn/current/Manual/CommandLineArguments.html>

见“Unity 独立平台播放器命令行参数”的 `-popupwindow` 和 `-screen-fullscreen`

## 版权

`logo.ico` 是从原神官方启动器 `launcher.exe` 中提取的，版权归 miHoYo 所有
