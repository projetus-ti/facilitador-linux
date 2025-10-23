#!/usr/bin/env bash
#
# Autor: Fabiano Henrique
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT
# Descricao: Script de instalação de aplicativos do contabil


# https://www.projetusti.com.br/


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


mkdir -p $HOME/.local/share/applications/


acao=$1

# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SPED ECD" ]; then            

# http://sped.rfb.gov.br/pasta/show/1273
# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/ecd

  echo -e "\nBaixando o Sped ECD...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/Sped/SpedContabil/SpedContabil_linux_x86_64-10.3.3.sh"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then
    echo "✅ Sistema 64 bits detectado: $ARCH"

    wget -P "$cache_path" -c "$download" 2>> "$log"

    sleep 2

    cd "$cache_path"

    chmod +x SpedContabil_linux_x86_64-10.3.3.sh

    sudo ./SpedContabil_linux_x86_64-10.3.3.sh 2>> "$log"


else

    echo "🧯 Sistema 32 bits detectado: $ARCH

Não existe versão do Sped ECD para arquitetura 32-bit atualmente para o Linux.
"

        yad --center --window-icon="$logo" --title="🧯 Sistema 32 bits detectado" \
        --text="Não existe versão do Sped ECD para arquitetura 32-bit atualmente para o Linux." \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

fi

endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SPED ECF" ]; then

  # http://sped.rfb.gov.br/pasta/show/1287

  echo -e "\nBaixando o Sped ECF...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/Sped/ECF/SpedECF_linux_x86_64-11.3.4.sh"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then
    echo "✅ Sistema 64 bits detectado: $ARCH"

    wget -P "$cache_path" -c "$download" 2>> "$log"

    sleep 2

    cd "$cache_path"

    chmod +x SpedECF_linux_x86_64-11.3.4.sh

    sudo ./SpedECF_linux_x86_64-11.3.4.sh  2>> "$log"


else

    echo "🧯 Sistema 32 bits detectado: $ARCH

Não existe versão do Sped ECF para arquitetura 32-bit atualmente para o Linux.
"

        yad --center --window-icon="$logo"  --title="🧯 Sistema 32 bits detectado" \
        --text="Não existe versão do Sped ECF para arquitetura 32-bit atualmente para o Linux." \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

fi

endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Receitanet" ]; then

# Receitanet

# O programa Receitanet é utilizado para validar e enviar pela internet os arquivos de 
# declarações e escriturações à Receita Federal.

# A máquina virtual java (JVM), versão 1.8 ou superior, deve estar instalada, pois 
# programa desenvolvido em Java não pode ser executado sem a JVM.

# Para instalar o Receitanet, é necessário adicionar permissão de execução, por meio do 
# comando "chmod +x Receitanet-1.32.jar" ou conforme o Gerenciador de Janelas utilizado. 
# Em seguida, execute "java -jar Receitanet-1.32.jar" na linha de comando. 


# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanet

  echo -e "\nBaixando o Receitanet...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/receitanet/Receitanet-1.32.jar"

  wget -P "$cache_path" -c "$download" 2>> "$log"

  FILE="$cache_path/Receitanet-1.32.jar"

  if [ ! -f "$FILE" ]; then

    # Adicionar permissão de execução, por meio do comando "chmod +x Receitanet-1.32.jar" 

    chmod +x "$FILE" 2>> "$log"

    sudo mv "$FILE" /opt/  2>> "$log"


    if command -v java >/dev/null 2>&1; then

    # Executa

    
    echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Receitanet
Name[pt_BR]=Receitanet
Comment=O programa Receitanet é utilizado para validar e enviar pela internet os arquivos de declarações e escriturações à Receita Federal.
Exec=java -jar /opt/Receitanet-1.32.jar
# Icon=
Terminal=false
# Categories=;
StartupNotify=true" > $HOME/.local/share/applications/receitanet.desktop


chmod +x $HOME/.local/share/applications/receitanet.desktop


    fi


  fi

endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Receita Net BX" ]; then

   # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanetbx/receitanetbx

   # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanetbx/download-do-programa-receitanetbx-windows

   # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanetbx/download-do-programa-receitanetbx-linux


# Multiplataforma (JAR)

  echo -e "\nBaixando o ReceitanetBX...\n"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

  # https://servicos.receita.fazenda.gov.br/publico/programas/ReceitanetBX/ReceitanetBX-1.9.24.exe

  download="https://servicos.receita.fazenda.gov.br/publico/programas/ReceitanetBX/ReceitanetBX-1.9.24-Linux-x86_64-Install.bin"

  wget -P "$cache_path" -c "$download" 2>> "$log"

  FILE="$cache_path/ReceitanetBX-1.9.24-Linux-x86_64-Install.bin"

  if [ ! -f "$FILE" ]; then

     chmod +x "$FILE" 2>> "$log"

     cd "$cache_path"

     ./ReceitanetBX-1.9.24-Linux-x86_64-Install.bin 2>> "$log"


  fi


    # yad --center --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon="$logo" --title "Atenção!" \
    #     --text 'Na próxima tela, informe a pasta /opt/projetus/facilitador/java/' \
    #     --height="50" --width="450" 2>/dev/null





else

    echo "🧯 Sistema 32 bits detectado: $ARCH"


  download="https://servicos.receita.fazenda.gov.br/publico/programas/ReceitanetBX/ReceitanetBX-1.9.24-Linux-x86-Install.bin"

  wget -P "$cache_path" -c "$download" 2>> "$log"

  FILE="$cache_path/ReceitanetBX-1.9.24-Linux-x86-Install.bin"

  if [ ! -f "$FILE" ]; then

     chmod +x "$FILE" 2>> "$log"

     cd "$cache_path"

     ./ReceitanetBX-1.9.24-Linux-x86-Install.bin 2>> "$log"


  fi



fi



endInstall

fi


# ----------------------------------------------------------------------------------------

if [ "$acao" = "Arquivo Remessa CX" ]; then

clear

descontinuado


        yad --center --window-icon="$logo"  --title="🧯 $titulo" \
        --text="Descontinuado

https://www.caixa.gov.br/site/Paginas/Pesquisa.aspx?k=Arquivo%20Remessa" \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null




  # echo "Arquivo Remessa CX"
  # configurarWine
  # Instalando complementos.
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks dotnet45"
  # flatpak run --env="WINEPREFIX=$HOME" --env="WINEARCH=win32" org.winehq.Wine /app/bin/winetricks dotnet45 2>> "$log"


  # Baixando e executando programa principal
  # download "https://www.caixa.gov.br/Downloads/cobranca-caixa/Validador_de_Arquivos_Remessa.zip"   "$cache_path/remessa.zip"
  # cd "$cache_path"

  # Extraindo o arquivo executavel
  # unzip remessa.zip  2>> "$log"

  # echo $'#!/bin/bash 
  #       set echo off
  #       flatpak run --env="WINEPREFIX=$HOME" --env="WINEARCH=win32" wine --command=wine '$user_path' io.github.fastrizwaan.WineZGUI /.facilitador-linux/executaveis/ValidadorCnab_v2.2.2.exe' >$atalho_path/CobrancaCaixa.sh

  # cd $atalho_path
  # chmod +x CobrancaCaixa.sh
  # Criando pastas onde guardará o executável
  # mkdir -p $user_path/.facilitador-linux/executaveis

  # Copiando executável para a pasta de excetaveis
  # cp $cache_path/ValidadorCnab_v2.2.2.exe $user_path/.facilitador-linux/executaveis 2>> "$log"

  # Copiando o atalho para a pasta de atalhos no desktop do usuário.
  # cp "$atalho_path/CobrancaCaixa.desktop" "$desktop_path/Validadores" 2>> "$log"

  # Após a execução, removendo os arquivos.
  # cd "$cache_path"
  # rm -rf ValidadorCnab_v2.2.2.exe remessa.zip 2>> "$log"

  # endInstall

fi

# ----------------------------------------------------------------------------------------

exit 0

