#!/bin/bash
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte
# Autor: Fabiano Henrique
# Data: 18/11/2019

source /opt/projetus/facilitador/funcoes.sh

acao=$1

if [ "$acao" = "ZRam" ]; then

  echo $'#!/bin/bash 
     apt-get update
     apt-get install zram-config -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"

  showMessage "Otimização ativada com sucesso!\nReinicie sua máquina assim que possível."
  
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "Bitrix" ]; then
  download "https://dl.bitrix24.com/b24/bitrix24_desktop.deb" "$cache_path/bitrix.deb"

  echo $'#!/bin/bash 
      dpkg -i '$cache_path'/bitrix.deb 
      apt-get update && apt-get -f install -y'>$cache_path/exec.sh

    chmod +x $cache_path/exec.sh
    executar "pkexec $cache_path/exec.sh"

    showMessage "Bitrix instalado com êxito!\nO atalho encontra-se no menu do sistema."
    exec $app_path/facilitador.sh
fi



if [ "$acao" = "MySuite" ]; then
  #configurarWine
  download "https://objectstorage.sa-saopaulo-1.oraclecloud.com/n/id3qvymhlwic/b/downloads/o/facilitador-linux%2Fmysuite.msi" "$cache_path/mysuite.msi"
  nohup wine msiexec /i $cache_path/mysuite.msi /quiet > /dev/null 2>&1 &
  rm -Rf "$desktop_path/BraZip Central.lnk"

  showMessage "O MySuite foi instalado com sucesso!\nO atalho encontra-se em sua Área de Trabalho."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "Discord" ]; then


    download "https://dl.discordapp.net/apps/linux/0.0.17/discord-0.0.16.deb" "$cache_path/discord.deb"

    echo $'#!/bin/bash 
      dpkg -i '$cache_path'/discord.deb 
      apt-get update && apt-get -f install -y'>$cache_path/exec.sh

    chmod +x $cache_path/exec.sh
    executar "pkexec $cache_path/exec.sh"

    showMessage "Discord instalado com êxito!\nO atalho encontra-se no menu do sistema."
    exec $app_path/facilitador.sh

fi  

if [ "$acao" = "TeamViewer" ]; then
  # Versão v13.2.258818
  download "https://download.teamviewer.com/download/linux/version_13x/teamviewer_amd64.deb" "$cache_path/tv.deb"
            
  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/tv.deb 
    apt-get update && apt-get -f install -y
    apt-mark hold teamviewer
    rm -Rf /etc/apt/sources.list.d/teamviewer.list'>$cache_path/exec.sh

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

if [ "$acao" = "Calima App" ]; then
  URL_CALIMA_APP=$(curl -L -X GET \
  -H'Content-Type: application/json' \
  'https://cloud-api-controller.projetusti.com.br/versao/sistema/get?identificacao=calima-app' \
 | python3 -c "import sys, json; print(json.load(sys.stdin)['informacaoComplementar'].split(';')[0])")

  download "$URL_CALIMA_APP" "$cache_path/calima.deb"

  rm -Rf ~/.config/calima-app
  rm -Rf ~/.config/calima-app-web
  
  echo $'#!/bin/bash 
    apt-get purge calima-app -y
    apt-get purge calima-app-web -y
    dpkg -i '$cache_path'/calima.deb
    cp /opt/projetus/facilitador/atalhos/calima-app-local.desktop /usr/share/applications
    chmod 777 /usr/share/applications/calima-app-local.desktop
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  
  showMessage "Calima App Local instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "iSGS App" ]; then
  download "https://objectstorage.sa-saopaulo-1.oraclecloud.com/n/id3qvymhlwic/b/downloads/o/facilitador-linux%2Fisgs-app_1.0.1_amd64.deb" "$cache_path/isgs.deb"
  
  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/isgs.deb 
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  
  showMessage "iSGS App instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "IRPF" ]; then
  download "https://downloadirpf.receita.fazenda.gov.br/irpf/2025/irpf/arquivos/IRPF2025Linux-x86_64v1.0.sh.bin" "$cache_path/irpf.bin"
  
  chmod +x $cache_path/irpf.bin
  executar "$cache_path/irpf.bin"

  #cd $app_path
  #echo $'#!/bin/bash 
  #  dpkg --configure -a
  #  apt-get update 
   # apt-get apt-get install openjdk-8-jre -y
  #  tar -xvf '$cache_path'/jre-8u212-linux-x64.tar.gz --directory /usr/lib/jvm/'>$cache_path/exec.sh

 # chmod +x $cache_path/exec.sh
  #executar "pkexec $cache_path/exec.sh"
  #executar "java -jar $cache_path/IRPF.jar"
  cp /opt/projetus/facilitador/atalhos/IRPF.desktop "$desktop_path/Validadores"

  endInstall
fi


if [ "$acao" = "Linphone" ]; then 

  download "https://www.linphone.org/releases/linux/app/Linphone-4.4.1.AppImage" "$atalho_path/linphone.AppImage"

  bash "$atalho_path/linphone.sh"

  showMessage "Linphone instalado com êxito!\nO atalho encontra-se no menu do sistema."

  exec $app_path/facilitador.sh 
fi
 
if [ "$acao" = "Crisp Chat App" ]; then 

  download "https://objectstorage.sa-saopaulo-1.oraclecloud.com/n/id3qvymhlwic/b/downloads/o/facilitador-linux%2Fcrisp-app.deb" "$cache_path/crisp.deb"

 
  echo $'#!/bin/bash 
  dpkg -i '$cache_path'/crisp.deb'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh

  executar "pkexec bash $cache_path/exec.sh"

  showMessage "Instalação concluída com sucesso!"

  exec $app_path/facilitador.sh 

fi

if [ "$acao" = "Zoom" ]; then

    download "https://zoom.us/client/latest/zoom_amd64.deb" "$cache_path/zoom.deb"

    echo $'#!/bin/bash 
      dpkg -i '$cache_path'/zoom.deb 
      apt-get update && apt-get -f install -y'>$cache_path/exec.sh

    chmod +x $cache_path/exec.sh
    executar "pkexec $cache_path/exec.sh"

    showMessage "Zoom instalado com êxito!\nO atalho encontra-se no menu do sistema."
    exec $app_path/facilitador.sh

fi  

