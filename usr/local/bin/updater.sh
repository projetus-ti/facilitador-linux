#!/usr/bin/env bash

# Autor: Evandro Begati
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Atualizador do facilitador
# Data: 19/10/2025
# Licença:  MIT
# Uso: updater.sh

 
# Verifica se o comando flatpak existe

if ! command -v flatpak &>/dev/null; then

    echo -e "\nflatpak não está disponível neste sistema.\n"

    yad --center --title="Erro" \
        --text="flatpak não está disponível neste sistema." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

 
# Verifica se o comando git existe

if ! command -v git &>/dev/null; then

    echo -e "\ngit não está disponível neste sistema.\n"

    yad --center --title="Erro" \
        --text="git não está disponível neste sistema." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi



# Testa conectividade com a internet

if ! ping -c 1 google.com &>/dev/null; then

    yad --center --title="Erro de Conexão" \
        --text="Sem acesso à internet.\nVerifique sua conexão de rede." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null
        
    exit 1
fi

# Verifica se o Java está instalado

if ! java --version &>/dev/null; then

    # Exibe mensagem de erro com YAD
    yad --center --title="Erro: Java não encontrado" \
        --text="O Java não está instalado no sistema.\nPor favor, instale o Java para continuar." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# Atualizar a base de scripts 


# Verifica se o diretório existe

if [[ ! -d /opt/projetus/facilitador ]]; then

    echo -e "\nDiretório /opt/projetus/facilitador não encontrado. \n"

        yad --center --title="Erro" \
        --text="Diretório /opt/projetus/facilitador não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null
        
    exit 1
fi

cd /opt/projetus/facilitador

git reset --hard HEAD
git pull origin master

source /usr/local/bin/funcoes.sh

# Prover permissao de execucao aos scripts

chmod -R +x /usr/local/bin/DIRF.sh
chmod -R +x /usr/local/bin/IRPF.sh
chmod -R +x /usr/local/bin/contabil.sh
chmod -R +x /usr/local/bin/efd-icms-ipi.sh
chmod -R +x /usr/local/bin/facilitador.sh
chmod -R +x /usr/local/bin/fiscal.sh
chmod -R +x /usr/local/bin/folha.sh
chmod -R +x /usr/local/bin/funcoes.sh
chmod -R +x /usr/local/bin/linphone.sh
chmod -R +x /usr/local/bin/projetus.sh
chmod -R +x /usr/local/bin/sped-ecd.sh
chmod -R +x /usr/local/bin/sped-ecf.sh
chmod -R +x /usr/local/bin/sped-efd-contribuicoes.sh
chmod -R +x /usr/local/bin/updater.sh



chmod -R +x /usr/share/applications/CobrancaCaixa.desktop
chmod -R +x /usr/share/applications/DIRF.desktop
chmod -R +x /usr/share/applications/IRPF.desktop
chmod -R +x /usr/share/applications/calima-app-local.desktop
chmod -R +x /usr/share/applications/efd-contribuicoes.desktop
chmod -R +x /usr/share/applications/efd-icms-ipi.desktop
chmod -R +x /usr/share/applications/facilitador.desktop
chmod -R +x /usr/share/applications/linphone.desktop
chmod -R +x /usr/share/applications/sintegra.desktop
chmod -R +x /usr/share/applications/sped-ecd.desktop
chmod -R +x /usr/share/applications/sped-ecf.desktop
chmod -R +x /usr/share/applications/sva.desktop


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

    echo -e "\nwinetricks não está disponível neste sistema. \n"

    if which apt &>/dev/null; then
       pkexec apt update && apt install -y winetricks
    fi 
 
fi


# Executar a aplicacao

nohup /opt/projetus/facilitador/facilitador.sh >/dev/null 2>&1 &

exit 0

