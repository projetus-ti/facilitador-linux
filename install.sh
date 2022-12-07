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
mkdir -p /home/$SUDO_USER/.fonts/msttcorefonts
mkdir -p /tmp/ttf

wget "https://downloads.sourceforge.net/corefonts/andale32.exe" -O /tmp/ttf/andale32.exe
wget "https://downloads.sourceforge.net/corefonts/arial32.exe" -O /tmp/ttf/arial32.exe
wget "https://downloads.sourceforge.net/corefonts/arialb32.exe" -O /tmp/ttf/arialb32.exe
wget "https://downloads.sourceforge.net/corefonts/comic32.exe" -O /tmp/ttf/comic32.exe
wget "https://downloads.sourceforge.net/corefonts/courie32.exe" -O /tmp/ttf/courie32.exe
wget "https://downloads.sourceforge.net/corefonts/georgi32.exe" -O /tmp/ttf/georgi32.exe
wget "https://downloads.sourceforge.net/corefonts/impact32.exe" -O /tmp/ttf/impact32.exe
wget "https://downloads.sourceforge.net/corefonts/times32.exe" -O /tmp/ttf/times32.exe
wget "https://downloads.sourceforge.net/corefonts/trebuc32.exe" -O /tmp/ttf/trebuc32.exe
wget "https://downloads.sourceforge.net/corefonts/verdan32.exe" -O /tmp/ttf/verdan32.exe
wget "https://downloads.sourceforge.net/corefonts/webdin32.exe" -O /tmp/ttf/webdin32.exe

cabextract /tmp/ttf/*.exe
sudo -u $SUDO_USER cp /tmp/ttf/*.TTF /home/$SUDO_USER/.fonts/msttcorefonts
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
echo "Instalação concluída! O Facilitador Linux encontra-se no menu de aplicativos do sistema."
exit 0
