#!/usr/bin/env bash
#
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf

log="/tmp/linphone.log"

# ----------------------------------------------------------------------------------------

# Caminho onde o AppImage deveria estar

# Você pode mudar o caminho da variavel "$atalho_path" conforme necessário no arquivo /etc/facilitador.conf.

arquivo="$atalho_path/linphone.AppImage"


# Verifica se o arquivo existe

if [[ ! -f "$arquivo" ]]; then

    yad --center \
        --title="Arquivo não encontrado" \
        --text="O arquivo linphone.AppImage não foi encontrado em:\n$atalho_path" \
        --button="OK" \
        --width="350" \
        --height="100"

   exit

fi


# ----------------------------------------------------------------------------------------

# Caminho do atalho

atalho_path="$HOME/.local/share/applications"
arquivo="$atalho_path/linphone.desktop"


# Verifica se o arquivo existe

if [[ ! -f "$arquivo" ]]; then

    yad --center \
        --title="Arquivo não encontrado" \
        --text="O arquivo linphone.desktop não foi encontrado em:\n$atalho_path" \
        --button=OK \
        --width="300" \
        --height="100"

   exit

fi

# ----------------------------------------------------------------------------------------

chmod +x $atalho_path/linphone.desktop 2>> "$log"

cp "$atalho_path/linphone.desktop" /home/$USER/.local/share/applications/linphone.desktop 2>> "$log"

cp "$atalho_path/linphone.desktop" "$desktop_path/linphone.desktop" 2>> "$log"

# ----------------------------------------------------------------------------------------

# Para Debian e derivados

if which apt &>/dev/null; then

sudo apt purge -y linphone 2>> "$log"

sudo apt -y autoremove     2>> "$log"

fi

# ----------------------------------------------------------------------------------------

# Para Void Linux

if which xbps-remove &>/dev/null; then

sudo xbps-remove -y linphone  2>> "$log"

sudo xbps-remove -Ooy         2>> "$log"

fi

# ----------------------------------------------------------------------------------------

exit 0


