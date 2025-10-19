#!/usr/bin/env bash
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025

ls /opt/projetus/ || exit

source /opt/projetus/facilitador/funcoes.sh

chmod +x $atalho_path/linphone.AppImage
chmod +x $atalho_path/linphone.desktop
cp "$atalho_path/linphone.desktop" /home/$USER/.local/share/applications/linphone.desktop
cp "$atalho_path/linphone.desktop" "$desktop_path/linphone.desktop"


# Para Debian e derivados

if which apt &>/dev/null; then

sudo apt purge linphone -y
sudo apt autoremove -y

fi

exit 0
