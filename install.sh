#!/bin/sh
# Descricao: Script de Instalação do Facilitador Linux
# Autor: Evandro Begati
# Uso: sudo sh install.sh

# Remove current installation
sudo -u $SUDO_USER env WINEARCH=win32 WINEPREFIX=/home/$SUDO_USER/.wine32 wineserver -k
sudo -u $SUDO_USER env WINEARCH=win64 WINEPREFIX=/home/$SUDO_USER/.wine wineserver -k
rm -rf /home/$SUDO_USER/.wine32
rm -rf /home/$SUDO_USER/.wine

# Add Wine repository
mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

# Add flatpak package wine8.0
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user -y install flathub org.winehq.Wine/x86_64/stable-22.08
flatpak -y remove io.github.fastrizwaan.WineZGUI
wget -c https://github.com/fastrizwaan/flatpak-wine/releases/download/0.97.12/flatpak-winezgui_0.97.12_20230522.flatpak
flatpak --user install flatpak-winezgui_0.97.12_20230522.flatpak

# Install dependencies packages
dpkg --add-architecture i386
apt-get purge -y wine*
apt-get update
apt-get install --install-recommends -y \
 zenity \
 git \
 exe-thumbnailer \
 cabextract \
 winetricks \
 winehq-staging

# Create workspace dir
sudo rm -Rf /opt/projetus/facilitador 
mkdir -p /opt/projetus/facilitador

# Give permission for current user
chown $SUDO_USER:$SUDO_USER -R /opt/projetus

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
clear
echo "Instalação concluída!"
echo "O Facilitador Linux encontra-se no menu de aplicativos do sistema."
exit 0
