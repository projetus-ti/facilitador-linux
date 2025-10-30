#!/usr/bin/env bash

# Autor: Evandro Begati
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Script de Instalação do Facilitador Linux
# Uso: sudo sh install.sh


# Usar o .conf no script
# Para carregar as variáveis do .conf

source etc/facilitador.conf



clear


# ----------------------------------------------------------------------------------------


# Verificar se os programas estão instalados

which yad          1> /dev/null 2> /dev/null || { echo -e "\nPrograma Yad não esta instalado. \n"      ; exit ; }


# ----------------------------------------------------------------------------------------


# Mostra aviso sobre backup do sistema

yad --center --window-icon="$logo" --title="Aviso Importante" \
    --text="⚠️ <b>Recomendação:</b>\n\nAntes de executar este script, é altamente recomendável criar uma <b>imagem de backup do sistema</b>.\n\nDeseja continuar mesmo assim?" \
    --buttons-layout=center \
    --button=Não:1 --button=Sim:0 \
    --width="400" --height="150" \
    2> /dev/null


# Verifica a resposta do usuário

if [[ $? -ne 0 ]]; then

    yad --center --window-icon="$logo" --title="Cancelado" --text="Execução cancelada pelo usuário." --buttons-layout=center --button="OK"  --width="300" 2> /dev/null

    exit 1
fi


# Testa conectividade com a internet

if ! ping -c 1 google.com &>/dev/null; then

    yad --center --window-icon="$logo" --title="Erro de Conexão" \
        --text="Sem acesso à internet.\nVerifique sua conexão de rede." \
        --buttons-layout=center \
        --button=OK \
        --width="300" --height="100" \
        2> /dev/null
        
    exit 1
fi


# Verifica se o Java está instalado

if ! java --version &>/dev/null; then

    # Exibe mensagem de erro
    
    echo -e "\nO Java não está instalado no sistema.\nPor favor, instale o Java para continuar. \n\nhttps://www.java.com/pt-br/download/manual.jsp\n"

        yad --center --window-icon="$logo" --title="Erro" \
        --text="O Java não está instalado no sistema.\nPor favor, instale o Java para continuar. \n\nhttps://www.java.com/pt-br/download/manual.jsp\n" \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2> /dev/null
    
    exit 1
fi


# Remove current installation

sudo -u $SUDO_USER env WINEARCH=win32 WINEPREFIX=/home/$SUDO_USER/.wine32 wineserver -k
sudo -u $SUDO_USER env WINEARCH=win64 WINEPREFIX=/home/$SUDO_USER/.wine wineserver -k
rm -rf /home/$SUDO_USER/.wine32
rm -rf /home/$SUDO_USER/.wine


# Verificar se está rodando em Debian ou derivados

if which apt &>/dev/null; then


# Add Wine repository

mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources


# Install dependencies packages

dpkg --add-architecture i386

apt purge -y wine*

apt update

apt install --install-recommends -y \
 yad \
 git \
 exe-thumbnailer \
 cabextract \
 wine \
 winetricks \
 winehq-staging

fi


# Create workspace dir

sudo rm -Rf /opt/projetus/facilitador 
sudo mkdir -p /opt/projetus/facilitador

# Give permission for current user

chown $SUDO_USER:$SUDO_USER -R /opt/projetus

# Clone scripts from git

sudo -u $SUDO_USER git clone "$repositorio_remoto" /opt/projetus/facilitador
sudo -u $SUDO_USER git config --global --add safe.directory /opt/projetus/facilitador

# Give permission to script execution

# sudo -u $SUDO_USER chmod -R +x /opt/projetus/facilitador/*.sh
# sudo -u $SUDO_USER chmod -R +x /opt/projetus/facilitador/*.desktop

# Create desktop shortcut

# cp /opt/projetus/facilitador/facilitador.desktop /usr/share/applications/facilitador.desktop

# Update desktop database

sudo update-desktop-database

sleep 10

# End script

clear

echo "Instalação concluída!"
echo "O Facilitador Linux encontra-se no menu de aplicativos do sistema."

        yad --center --window-icon="$logo" --title="Instalação concluída!" \
        --text="O Facilitador Linux encontra-se no menu de aplicativos do sistema." \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

exit 0

