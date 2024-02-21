#!/bin/sh
# Descricao: Script de Instalação do Facilitador Linux
# Autor: Evandro Begati
# Uso: sudo sh install.sh

# Remove current installation
if sudo -u $SUDO_USER env WINEARCH=win32 WINEPREFIX=/home/$SUDO_USER/.wine32 wineserver -k 2> /dev/null
then
	rm -rf /home/$SUDO_USER/.wine32
fi

if sudo -u $SUDO_USER env WINEARCH=win64 WINEPREFIX=/home/$SUDO_USER/.wine wineserver -k 2> /dev/null
then
	rm -rf /home/$SUDO_USER/.wine
fi

idLine=$(cat /etc/*-release | grep ^ID=)
id=$(echo $idLine | cut -d '=' -f2)

echo "Verifying Linux Distribution and trying to install dependencies..."
if [ $id = "ubuntu" ] 
then 
	codenameLine=$(cat /etc/*-release | grep ^DISTRIB_CODENAME=)
	codename=$(echo $codenameLine | cut -d '=' -f2)

	# Add Wine repository
	mkdir -pm755 /etc/apt/keyrings
	wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
	wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$codename/winehq-$codename.sources
	
	dpkg --add-architecture i386
	apt-get purge -y wine*
	apt-get update
	apt-get install --install-recommends -y \
	 zenity \
	 git \
	 exe-thumbnailer \
	 cabextract \
	 wine32 \
	 wine64 \
	 winetricks \
	 winehq-staging
    
    #define variable to continue dependencies installation
    continue=1
elif [ $id = "manjaro" ] 
then 
  #TODO
  #ainda não está funcionando o facilitador, provavelmente falta alguma dependência
    pacman -Syu --noconfirm \
		zenity \
		git \
		cabextract \
		winetricks \
		wine-staging
	 
 	pamac build --no-confirm icoextract
    
    #define variable to continue dependencies installation
    continue=1
else 
    echo "Linux Distribution not supported"
    
    #define variable to cancell dependencies installation
    continue=0
fi

if [ $continue -eq 1 ]
then

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
fi
