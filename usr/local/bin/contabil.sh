#!/bin/bash
#
# Autor: Fabiano Henrique
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT
# Descricao: Script de instalação de aplicativos do contabil


# https://www.projetusti.com.br/


source /usr/local/bin/funcoes.sh

acao=$1

if [ "$acao" = "SPED ECD" ]; then            

# http://sped.rfb.gov.br/pasta/show/1273
# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/ecd

  echo -e "\nBaixando o Sped ECD...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/Sped/SpedContabil/SpedContabil_linux_x86_64-10.3.3.sh"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then
    echo "✅ Sistema 64 bits detectado: $ARCH"

    wget -P "$cache_path" -c "$download"

    sleep 2

    cd "$cache_path"

    chmod +x SpedContabil_linux_x86_64-10.3.3.sh

    sudo ./SpedContabil_linux_x86_64-10.3.3.sh


else

    echo "🧯 Sistema 32 bits detectado: $ARCH

Não existe versão do Sped ECD para arquitetura 32-bit atualmente para o Linux.
"

        yad --center --title="🧯 Sistema 32 bits detectado" \
        --text="Não existe versão do Sped ECD para arquitetura 32-bit atualmente para o Linux." \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

fi

endInstall

fi


if [ "$acao" = "SPED ECF" ]; then

  # http://sped.rfb.gov.br/pasta/show/1287

  echo -e "\nBaixando o Sped ECF...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/Sped/ECF/SpedECF_linux_x86_64-11.3.4.sh"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then
    echo "✅ Sistema 64 bits detectado: $ARCH"

    wget -P "$cache_path" -c "$download"

    sleep 2

    cd "$cache_path"

    chmod +x SpedECF_linux_x86_64-11.3.4.sh

    sudo ./SpedECF_linux_x86_64-11.3.4.sh


else

    echo "🧯 Sistema 32 bits detectado: $ARCH

Não existe versão do Sped ECF para arquitetura 32-bit atualmente para o Linux.
"

        yad --center --title="🧯 Sistema 32 bits detectado" \
        --text="Não existe versão do Sped ECF para arquitetura 32-bit atualmente para o Linux." \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

fi

endInstall

fi


if [ "$acao" = "Receita Net BX" ]; then

   # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanetbx/download-do-programa-receitanetbx-windows

  echo -e "\nBaixando o ReceitanetBX...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/ReceitanetBX/ReceitanetBX-1.9.24.exe"

  wget -P "$cache_path" -c "$download"

  FILE="$cache_path/ReceitanetBX-1.9.24.exe"

  if [ ! -f "$FILE" ]; then

    # Para Debian e derivados

    # if which apt &>/dev/null; then

    # executar "pkexec apt install -y libgtk2.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 libglu1-mesa:i386 libxtst6:i386 libncurses5:i386"

    # fi



    # yad --center --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon=/opt/projetus/facilitador/icon.png --title "Atenção!" \
    #     --text 'Na próxima tela, informe a pasta /opt/projetus/facilitador/java/' \
    #     --height="50" --width="450"


  cd "$cache_path"

  wine ReceitanetBX-1.9.24.exe

 fi

endInstall

fi


if [ "$acao" = "Arquivo Remessa CX" ]; then

clear

descontinuado

  echo "Descontinuado

https://www.caixa.gov.br/site/Paginas/Pesquisa.aspx?k=Arquivo%20Remessa

"

sleep 10


  # echo "Arquivo Remessa CX"
  # configurarWine
  # Instalando complementos.
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks dotnet45"
  # flatpak run --env="WINEPREFIX=$HOME" --env="WINEARCH=win32" org.winehq.Wine /app/bin/winetricks dotnet45


  # Baixando e executando programa principal
  # download "https://www.caixa.gov.br/Downloads/cobranca-caixa/Validador_de_Arquivos_Remessa.zip"   "$cache_path/remessa.zip"
  # cd "$cache_path"

  # Extraindo o arquivo executavel
  # unzip remessa.zip  

  # echo $'#!/bin/bash 
  #       set echo off
  #       flatpak run --env="WINEPREFIX=$HOME" --env="WINEARCH=win32" wine --command=wine '$user_path' io.github.fastrizwaan.WineZGUI /.facilitador-linux/executaveis/ValidadorCnab_v2.2.2.exe' >$atalho_path/CobrancaCaixa.sh

  # cd $atalho_path
  # chmod +x CobrancaCaixa.sh
  # Criando pastas onde guardará o executável
  # mkdir -p $user_path/.facilitador-linux/executaveis

  # Copiando executável para a pasta de excetaveis
  # cp $cache_path/ValidadorCnab_v2.2.2.exe $user_path/.facilitador-linux/executaveis

  # Copiando o atalho para a pasta de atalhos no desktop do usuário.
  # cp "$atalho_path/CobrancaCaixa.desktop" "$desktop_path/Validadores"

  # Após a execução, removendo os arquivos.
  # cd "$cache_path"
  # rm -rf ValidadorCnab_v2.2.2.exe remessa.zip

  # endInstall

fi


exit 0

