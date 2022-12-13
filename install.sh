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

# Create workspace dir
sudo rm -Rf /opt/projetus/facilitador 
mkdir -p /opt/projetus/facilitador

# Clone scripts from git
sudo -u $SUDO_USER git clone https://github.com/projetus-ti/facilitador-linux.git /opt/projetus/facilitador
sudo -u $SUDO_USER git config --global --add safe.directory /opt/projetus/facilitador

# Give permission to script execution
sudo -u $SUDO_USER chmod -R +x /opt/projetus/facilitador/*.sh
sudo -u $SUDO_USER chmod -R +x /opt/projetus/facilitador/*.desktop

# Give permission for current user
chown $SUDO_USER -R /opt/projetus

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
