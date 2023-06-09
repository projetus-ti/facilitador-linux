#!/bin/sh
# Descricao: Atualizador do facilitador
# Autor: Evandro Begati
# Data: 30/12/2019
# Uso: ./updater.sh

# atualizar a base de scripts 
cd /opt/projetus/facilitador
git reset --hard HEAD
git pull origin master

# prover permissao de execucao aos scripts
chmod -R +x /opt/projetus/facilitador/*.sh
chmod -R +x /opt/projetus/facilitador/*.desktop
chmod -R +x /opt/projetus/facilitador/atalhos/*.sh
chmod -R +x /opt/projetus/facilitador/atalhos/*.desktop

# Verificar se o FlatpakWine está instalado.
if ! (flatpak list | grep WineZGUI); then
    executar "flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
    executar "flatpak --user -y install flathub org.winehq.Wine/x86_64/stable-22.08"
    executar "flatpak -y remove io.github.fastrizwaan.WineZGUI"
    executar "wget -c https://github.com/fastrizwaan/flatpak-wine/releases/download/0.97.12/flatpak-winezgui_0.97.12_20230522.flatpak"
    executar "flatpak --user install -y flatpak-winezgui_0.97.12_20230522.flatpak"
fi

# Verifica se  o Winestricks esta instalado 
if [ ! -e  "/usr/bin/winetricks" ]; then
    pkexec apt-get install winetricks
fi    

# Executar a aplicacao
nohup /opt/projetus/facilitador/facilitador.sh >/dev/null 2>&1 &

