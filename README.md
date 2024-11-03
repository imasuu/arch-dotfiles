# arch dotfiles and configurations

kernels:\
cachyos sched ext lto\

file system:\
btrfs\

configuration:\
WM: hyprland\
terminal: wezterm\
browser: zen\
bar/widgets: ags - hyprpanel\
shell: oh my posh + zinit\
launcher: kando / rofi\
editor: neovim + nvchad / zed\
file manager: thunar / yazi\
bootloader: grub\
session ui: sddm\
lockscreen: hyprlock\
fetch: fastfetch\
wallpaper: swww + mpvpaper\
packages: pacman + aur, nix, flatpak\

pacman repositories: cachyos, chaotic aur, blackarch, oglo

GTK theme: rose pine\
font: JetBrainsMono Nerd Font Regular 11\

grub theme: seegson\

sddm theme: sugar candy\

programs:\
lutris\
heroic\
steam\
ryujinx\
prism\
lunar\
FFXIV\
bottles\
wine\
orca\
ipfs\
spotify\
kicad\
qemu/virt manager\
github desktop\
kde connect\
libre office\
obsidian\
wireguard\
sunshine\
unity\
tor\
vesktop\
anki\
ufw\

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com:immysoun/arch-dotfiles.git
$ cd arch-dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
