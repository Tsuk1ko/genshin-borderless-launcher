# genshin-borderless-launcher

A launcher to run Genshin Impact in a borderless fullscreen window.

## Usage

1. Set Genshin Impact to fullscreen mode in game setting, then exit the game.
2. Download [genshin-launcher.exe](https://github.com/Tsuk1ko/genshin-borderless-launcher/releases/latest/download/genshin-launcher.exe). Generally, it can be put anywhere.  
   - If you are prompted "Genshin Impact executable file not found" in the next step, please put `genshin-launcher.exe` in the root directory of Genshin Impact, or use the `-Path` parameter to specify manually.
3. Run the `genshin-launcher.exe` whenever you want to launch the game.

## Parameter

### `-Path`

Can be used to specify the root directory of Genshin Impact. E.g:

```powershell
genshin-launcher.exe -Path "D:\Program Files\Genshin Impact"
```
