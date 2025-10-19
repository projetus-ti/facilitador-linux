#!/usr/bin/env bash

# Autor: Evandro Begati
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Atualizador do facilitador
# Data: 19/10/2025
# Uso: ./updater.sh

 
# Verifica se o comando flatpak existe

if ! command -v flatpak &>/dev/null; then
    echo "flatpak não está disponível neste sistema."
    exit 1
fi

 
# Verifica se o comando git existe

if ! command -v git &>/dev/null; then
    echo "git não está disponível neste sistema."
    exit 1
fi



# Testa conectividade com a internet

if ! ping -c 1 google.com &>/dev/null; then

    yad --center --title="Erro de Conexão" \
        --text="Sem acesso à internet.\nVerifique sua conexão de rede." \
        --button=OK \
        --width=300 --height=100
        
    exit 1
fi

# Verifica se o Java está instalado

if ! java --version &>/dev/null; then

    # Exibe mensagem de erro com YAD
    yad --center --title="Erro: Java não encontrado" \
        --text="O Java não está instalado no sistema.\nPor favor, instale o Java para continuar." \
        --button=OK \
        --width=300 --height=100
    exit 1
fi

# Atualizar a base de scripts 


# Verifica se o diretório existe

if [[ ! -d /opt/projetus/facilitador ]]; then

    echo -e "\nDiretório /opt/projetus/facilitador não encontrado. \n"

        yad --center --title="Erro" \
        --text="Diretório /opt/projetus/facilitador não encontrado." \
        --button=OK \
        --width=300 --height=100
        
    exit 1
fi

cd /opt/projetus/facilitador

git reset --hard HEAD
git pull origin master

source /opt/projetus/facilitador/funcoes.sh

# prover permissao de execucao aos scripts
chmod -R +x /opt/projetus/facilitador/*.sh
chmod -R +x /opt/projetus/facilitador/*.desktop
chmod -R +x /opt/projetus/facilitador/atalhos/*.sh
chmod -R +x /opt/projetus/facilitador/atalhos/*.desktop


# Verificar se o FlatpakWine está instalado.

if ! (flatpak list | grep WineZGUI); then
    echo $'#!/bin/bash 
    flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak --user -y install flathub org.winehq.Wine/x86_64/stable-22.08
    flatpak -y remove io.github.fastrizwaan.WineZGUI
    wget -c https://github.com/fastrizwaan/flatpak-wine/releases/download/0.97.12/flatpak-winezgui_0.97.12_20230522.flatpak
    flatpak --user install -y flatpak-winezgui_0.97.12_20230522.flatpak'>$cache_path/flatpak.sh

    chmod +x $cache_path/flatpak.sh
    executarFlatpak "pkexec $cache_path/flatpak.sh"

fi


# Verifica se o comando winetricks existe

if ! command -v winetricks &>/dev/null; then
    echo "winetricks não está disponível neste sistema."

    if which apt &>/dev/null; then
       pkexec apt update && apt install -y winetricks
    fi 
 
fi


# Executar a aplicacao
nohup /opt/projetus/facilitador/facilitador.sh >/dev/null 2>&1 &

exit 0
