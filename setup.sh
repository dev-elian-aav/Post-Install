#!/bin/sh

hdir="/home/elian"

# Xorg minimal
apt install xserver-xorg-core xserver-xorg-input-evdev xserver-xorg-video-intel xdg-user-dirs x11-xserver-utils x11-xkb-utils x11-utils xinit -y

# Fonts
apt install fonts-linuxlibertine fonts-liberation fonts-liberation2 -y

# Terminal Programs
apt install doas neovim calcurse flatpak pulseaudio pulsemixer xwallpaper unzip zip unrar-free -y

# C Development
apt install make clang libx11-dev libxft-dev libxinerama-dev git -y

# GUI Programs
apt install keepassxc firefox-esr thunderbird vlc zathura zathura-djvu zathura-pdf-poppler zathura-ps blueman -y

# Flatpak Setup
sudo -u "elian" bash << flatconfiguration
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak update
flatpak install io.freetubeapp.FreeTube
flatconfiguration

# Folders and Git
sudo -u "elian" bash << foldergitclones
xdg-user-dirs-update
git clone "https://github.com/dev-elian-aav/Suckless" "$hdir/Public/Suckless"
git clone "https://github.com/dev-elian-aav/Post-Install" "$hdir/Public/Post-Install"
git clone "https://github.com/dev-elian-aav/C---Kernighan-and-Ritchie" "$hdir/Public/C - Kernighan and Ritchie"
wget "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts" -O $HOME/Downloads/hosts
foldergitclones

# Dotfiles
sudo -u "elian" bash << dotfiles
cp $hdir/Public/Post-Install/Dot-files/xinitrc $hdir/.xinitrc
cp $hdir/Public/Post-Install/Dot-files/profile $hdir/.profile
dotfiles

#Return to Root
mv $hdir/Downloads/hosts /etc/
cp $hdir/Public/Post-Install/doas.conf /etc/

# Suckless Install
make clean install -C $hdir/Public/Suckless/dwm-6.5/
make clean install -C $hdir/Public/Suckless/dmenu-5.3/
make clean install -C $hdir/Public/Suckless/st-0.9.2/
