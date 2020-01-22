#!/bin/bash
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte
# Autor: Fabiano Henrique
# Data: 18/11/2019

source /opt/projetus/facilitador/funcoes.sh

acao=$1

if [ "$acao" = "ZRam" ]; then

  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/tv.deb 
    apt-get update && apt-get install zram-config -y
    apt-mark hold teamviewer'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"

  showMessage "Otimização ativada com sucesso!\nReinicie sua máquina assim que possível."
  exec $app_path/facilitador.sh
fi


if [ "$acao" = "Calima Server" ]; then
  download "https://download.projetusti.com.br/calima/linux/calima-server_2.0.5_all.deb" "$cache_path/calima-server.deb"

  echo $'#!/bin/bash 
    /usr/bin/docker-compose -f /opt/projetus/calima/tomcat.yml -f /opt/projetus/calima/postgres.yml down
    rm -Rf /opt/projetus/calima
    rm -Rf /usr/share/applications/calima.desktop
    dpkg -i '$cache_path'/calima-server.deb 
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"

  showMessage "Calima Server instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "MySuite" ]; then
  configurarWine
  download "https://cdn.projetusti.com.br/suporte/mysuite.msi" "$cache_path/mysuite.msi"
  nohup wine msiexec /i $cache_path/mysuite.msi /quiet > /dev/null 2>&1 &
  rm -Rf "$desktop_path/BraZip Central.lnk"
  showMessage "O MySuite foi instalado com sucesso!\nO atalho encontra-se em sua Área de Trabalho."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "Discord" ]; then


    download "https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.deb" "$cache_path/discord.deb"

    echo $'#!/bin/bash 
      dpkg -i '$cache_path'/discord.deb 
      apt-get update && apt-get -f install -y'>$cache_path/exec.sh

    chmod +x $cache_path/exec.sh
    executar "pkexec $cache_path/exec.sh"
  
    showMessage "Discord instalado com êxito!\nO atalho encontra-se no menu do sistema."
    exec $app_path/facilitador.sh

fi  

if [ "$acao" = "TeamViewer" ]; then
  download "https://download.teamviewer.com/download/linux/version_13x/teamviewer_amd64.deb" "$cache_path/tv.deb"

  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/tv.deb 
    apt-get update && apt-get -f install -y
    apt-mark hold teamviewer'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
    
  showMessage "TeamViewer instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "Skype" ]; then
  download "https://repo.skype.com/latest/skypeforlinux-64.deb" "$cache_path/skype.deb"

  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/skype.deb 
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  
  showMessage "Skype instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "DBeaver" ]; then
  download "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" "$cache_path/dbeaver.deb"
  
  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/dbeaver.deb 
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  
  showMessage "DBeaver instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "Calima App - Acesso Local" ]; then
  download "https://download.projetusti.com.br/calima/linux/calima-app_1.0.5_amd64.deb" "$cache_path/calima.deb"
  
  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/calima.deb 
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  
  showMessage "Calima App Local instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "Calima App - Acesso Web" ]; then
  download "https://download.projetusti.com.br/calima/linux/calima-app-web_1.0.5_amd64.deb" "$cache_path/calima.deb"
  
  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/calima.deb 
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  
  showMessage "Calima App Web instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "iSGS App" ]; then
  download "https://cdn.projetusti.com.br/suporte/isgs-app_1.0.1_amd64.deb" "$cache_path/isgs.deb"
  
  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/isgs.deb 
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  
  showMessage "iSGS App instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi
