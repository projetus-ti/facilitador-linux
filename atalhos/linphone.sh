#!/bin/sh
source /opt/projetus/facilitador/funcoes.sh
chmod +x $atalho_path/linphone.AppImage
chmod +x $atalho_path/linphone.desktop
cp "$atalho_path/linphone.desktop" /home/$USER/.local/share/applications/linphone.desktop
cp "$atalho_path/linphone.desktop" "$desktop_path/linphone.desktop"
sudo apt-get purge linphone -y