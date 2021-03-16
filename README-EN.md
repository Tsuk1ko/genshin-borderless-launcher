# genshin-borderless-launcher

A launcher to run Genshin Impact in a borderless fullscreen window.

## Usage

1. Set Genshin Impact to fullscreen mode in game setting, then exit the game.
2. Download [genshin-launcher.exe](https://github.com/Tsuk1ko/genshin-borderless-launcher/releases/latest/download/genshin-launcher.exe). Generally, it can be put anywhere.  
   - If you are prompted "Genshin Impact executable file not found" in the next step, please put `genshin-launcher.exe` in the root directory of Genshin Impact, or use the `-Path` parameter to specify manually.
   - The root directory refers to the directory where `launcher.exe` is located. DO NOT put `genshin-launcher.exe` into `Genshin Impact Game` directory, otherwise an error (31-4302) will occur when the game starts.
3. Run the `genshin-launcher.exe` whenever you want to launch the game.

## Parameter

### `-Path`

Can be used to specify the root directory of Genshin Impact. Both of the following directories are accepted.

```powershell
genshin-launcher.exe -Path "D:\Program Files\Genshin Impact"
genshin-launcher.exe -Path "D:\Program Files\Genshin Impact\Genshin Impact Game"
```

Directory priority: `-Path` > Current directory > Get from registry
