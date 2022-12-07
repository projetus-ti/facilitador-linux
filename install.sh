#!/bin/sh
# Descricao: Script de Instalação do Facilitador Linux
# Autor: Evandro Begati
# Uso: sudo sh install.sh

# Unattended MS Fonts install
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

# Install dependencies packages
dpkg --add-architecture i386
apt-get update
apt-get install -y \
 zenity \
 git \
 ttf-mscorefonts-installer \
 exe-thumbnailer \
 wine-installer \
 wine32 \
 wine64 \
 winetricks

# Create workspace dir
sudo rm -Rf /opt/projetus/facilitador 
mkdir -p /opt/projetus/facilitador
chown $SUDO_USER -R /opt/projetus/facilitador

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

# sair
exit 0
