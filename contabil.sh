#!/bin/bash
# Descricao: Script de instalação de aplicativos do contabil
# Autor: Fabiano Henrique
# Data: 18/11/2019

source /opt/projetus/facilitador/funcoes.sh

acao=$1

if [ "$acao" = "SPED ECD" ]; then            
            
  download "https://servicos.receita.fazenda.gov.br/publico/programas/Sped/SpedContabil/SpedContabil_linux_x86_64-10.2.3.sh" "$cache_path/SPEDContabil.sh"
  
  bash $cache_path/SPEDContabil.sh
  #executar "java -jar $cache_path/SPEDContabil.jar"
  #sleep 2
  #cd "$desktop_path"
  rm -Rf Sped*
  rm -Rf Desinstalar*
  rm -Rf ~/.local/share/applications/Sped*
  rm -Rf ~/.local/share/applications/Desinstalar*
  cp $app_path/atalhos/sped-ecd.desktop "$desktop_path/Validadores"

  endInstall
fi

if [ "$acao" = "SPED ECF" ]; then 
            
  # download "https://servicos.receita.fazenda.gov.br/publico/programas/Sped/ECF/SpedEcf_linux_x64-10.0.10.jar" "$cache_path/SpedEcf.jar"  
  # executar "java -jar $cache_path/SpedEcf.jar"

  download "https://servicos.receita.fazenda.gov.br/publico/programas/Sped/ECF/SpedECF_linux_x86_64-11.0.2.sh" "$cache_path/SpedEcf.sh"
  chmod +X "$cache_path/SpedEcf.sh"
  executar "sh $cache_path/SpedEcf.sh"

  sleep 2
  cd "$desktop_path"
  mv "$desktop_path/SpedECF.desktop" "$desktop_path/Validadores/SpedECF.desktop" 
  chmod +X "$desktop_path/Validadores/SpedECF.desktop"
  # rm -Rf Sped*
  rm -Rf Desinstalar*
  rm -Rf ~/.local/share/applications/Sped*
  rm -Rf ~/.local/share/applications/Desinstalar*
  # Se for jar ai usa o atalho
  # cp $app_path/atalhos/sped-ecf.desktop "$desktop_path/Validadores"
  # Se não for usa o atalho criado.
  
  
  endInstall
fi

if [ "$acao" = "Receita Net BX" ]; then

  FILE=/opt/projetus/facilitador/cache/bx.bin

  if [ ! -f "$FILE" ]; then
    executar "pkexec apt install libgtk2.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 libglu1-mesa:i386 libxtst6:i386 libncurses5:i386 -y"
  
    download "http://download.projetusti.com.br/suporte/jre-tomcat-linux/jre-7u79-linux-i586.tar.gz" "$app_path/java.tar.gz"
    cd $app_path
    tar -vzxf java.tar.gz
    mv jre1.7.0_79/ java

    download "http://www.receita.fazenda.gov.br/publico/programas/ReceitanetBX/ReceitanetBX-1.7.9-Linux-x86-Install.bin" "$cache_path/bx.bin"
    chmod +x $cache_path/bx.bin

    zenity --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon=/opt/projetus/facilitador/icon.png --title "Atenção!" \
         --text 'Na próxima tela, informe a pasta /opt/projetus/facilitador/java/' \
         --height="50" --width="450"
  fi

  cd $cache_path
  sudo ./bx.bin

  endInstall
fi

if [ "$acao" = "Arquivo Remessa CX" ]; then
  descontinuado
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
   #cd "$cache_path"
  # rm -rf ValidadorCnab_v2.2.2.exe remessa.zip

   #endInstall

fi



