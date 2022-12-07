#!/bin/sh
# Descricao: Script de Instalação do Facilitador Linux
# Autor: Evandro Begati
# Uso: sudo sh install.sh

# Install dependencies packages
dpkg --add-architecture i386
apt-get update
apt-get install -y \
 zenity \
 git \
 exe-thumbnailer \
 cabextract \
 wine-installer \
 wine32 \
 wine64 \
 winetricks

# Install Microsoft Fonts
mkdir -p /usr/share/fonts/truetype/msttcorefonts
mkdir -p /tmp/ttf

wget "https://mirrors.kernel.org/gentoo/distfiles/andale32.exe" -O /tmp/ttf/andale32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/arial32.exe" -O /tmp/ttf/arial32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/arialb32.exe" -O /tmp/ttf/arialb32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/comic32.exe" -O /tmp/ttf/comic32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/courie32.exe" -O /tmp/ttf/courie32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/georgi32.exe" -O /tmp/ttf/georgi32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/impact32.exe" -O /tmp/ttf/impact32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/times32.exe" -O /tmp/ttf/times32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/trebuc32.exe" -O /tmp/ttf/trebuc32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/verdan32.exe" -O /tmp/ttf/verdan32.exe
wget "https://mirrors.kernel.org/gentoo/distfiles/webdin32.exe" -O /tmp/ttf/webdin32.exe
wget "https://raw.githubusercontent.com/PrincetonUniversity/COS333_Comet/master/android/app/src/main/assets/fonts/Microsoft%20Sans%20Serif.ttf" -O /usr/share/fonts/truetype/msttcorefonts/ms-sans-serif.ttf 

cabextract /tmp/ttf/*.exe -d /tmp/ttf
cp /tmp/ttf/*.TTF /usr/share/fonts/truetype/msttcorefonts
rm -rf /tmp/ttf
fc-cache -fv

# Create workspace dir
sudo rm -Rf /opt/projetus/facilitador 
mkdir -p /opt/projetus/facilitador
chown $SUDO_USER -R /opt/projetus

# Clone scripts from git
sudo -u $SUDO_USER git clone https://github.com/projetus-ti/facilitador-linux.git /opt/projetus/facilitador
sudo -u $SUDO_USER git config --global --add safe.directory /opt/projetus/facilitador

# Give permission to script execution
sudo -u $SUDO_USER chmod -R +x /opt/projetus/facilitador/*.sh
sudo -u $SUDO_USER chmod -R +x /opt/projetus/facilitador/*.desktop

# Create desktop shortcut
cp /opt/projetus/facilitador/facilitador.desktop /usr/share/applications/facilitador.desktop

# Update desktop database
sudo update-desktop-database

# End script
cd /home/$SUDO_USER
sudo -u $SUDO_USER wineboot -e
clear
echo "Instalação concluída!"
echo "O Facilitador Linux encontra-se no menu de aplicativos do sistema."
exit 0
