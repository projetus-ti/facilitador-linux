#!/bin/sh
# Descricao: Script de Instalação do Facilitador Linux
# Autor: Evandro Begati
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Uso: sudo sh install.sh


# Verifica se o Java está instalado

if ! java --version &>/dev/null; then

    # Exibe mensagem de erro
    
    echo -e "\n O Java não está instalado no sistema.\nPor favor, instale o Java para continuar. \n"
    
    exit 1
fi


# Remove current installation
sudo -u $SUDO_USER env WINEARCH=win32 WINEPREFIX=/home/$SUDO_USER/.wine32 wineserver -k
sudo -u $SUDO_USER env WINEARCH=win64 WINEPREFIX=/home/$SUDO_USER/.wine wineserver -k
rm -rf /home/$SUDO_USER/.wine32
rm -rf /home/$SUDO_USER/.wine

# Add Wine repository
mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

# Install dependencies packages
dpkg --add-architecture i386
apt-get purge -y wine*
apt-get update
apt-get install --install-recommends -y \
 yad \
 git \
 exe-thumbnailer \
 cabextract \
 wine \
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
