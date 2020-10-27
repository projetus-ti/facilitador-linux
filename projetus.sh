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
  user_install $acao

  showMessage "Otimização ativada com sucesso!\nReinicie sua máquina assim que possível."
  
  exec $app_path/facilitador.sh
fi


if [ "$acao" = "Calima Server" ]; then
  download "https://download.projetusti.com.br/calima/linux/calima-server_3.5.3_all.deb" "$cache_path/calima-server.deb"

  user_path=$(xdg-user-dir USER)
  nome=$(echo $USER)

  echo $'#!/bin/bash 
    chown  '$nome' '$user_path'/.calima-server/postgres
    chown '$nome' '$user_path'/.calima-server/postgres/bkp
    dpkg -i '$cache_path'/calima-server.deb'>$cache_path/exec.sh

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
  user_install $acao

  showMessage "O MySuite foi instalado com sucesso!\nO atalho encontra-se em sua Área de Trabalho."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "Discord" ]; then


    download "https://dl.discordapp.net/apps/linux/0.0.10/discord-0.0.10.deb" "$cache_path/discord.deb"

    echo $'#!/bin/bash 
      dpkg -i '$cache_path'/discord.deb 
      apt-get update && apt-get -f install -y'>$cache_path/exec.sh

    chmod +x $cache_path/exec.sh
    executar "pkexec $cache_path/exec.sh"
    user_install "$acao%20v0.0.10"

    showMessage "Discord instalado com êxito!\nO atalho encontra-se no menu do sistema."
    exec $app_path/facilitador.sh

fi  

if [ "$acao" = "TeamViewer" ]; then
  # Versão v13.2.256470
  download "https://download.teamviewer.com/download/linux/version_13x/teamviewer_amd64.deb" "$cache_path/tv.deb"
            
  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/tv.deb 
    apt-get update && apt-get -f install -y
    apt-mark hold teamviewer'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  user_install $acao

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
  user_install $acao
  
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
  user_install $acao
  
  showMessage "DBeaver instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "Calima App" ]; then
  URL_CALIMA_APP=$(curl -L -X GET \
  -H'Content-Type: application/json' \
  'https://cloud-api.controller.projetusti.com.br/versao/sistema/get?identificacao=calima-app' \
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
  download "https://cdn.projetusti.com.br/suporte/isgs-app_1.0.1_amd64.deb" "$cache_path/isgs.deb"
  
  echo $'#!/bin/bash 
    dpkg -i '$cache_path'/isgs.deb 
    apt-get update && apt-get -f install -y'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  user_install "iSGS%20App"
  
  showMessage "iSGS App instalado com êxito!\nO atalho encontra-se no menu do sistema."
  exec $app_path/facilitador.sh
fi

if [ "$acao" = "IRPF" ]; then
  download "http://downloadirpf.receita.fazenda.gov.br/irpf/2020/irpf/arquivos/IRPF2020.jar" "$cache_path/IRPF.jar"
  download "https://cdn.projetusti.com.br/infra/pacotes/jre-8u212-linux-x64.tar.gz" "$cache_path/jre-8u212-linux-x64.tar.gz"

  cd $app_path
  echo $'#!/bin/bash 
    dpkg --configure -a
    apt-get update 
    apt-get apt-get install openjdk-8-jre -y
    tar -xvf '$cache_path'/jre-8u212-linux-x64.tar.gz --directory /usr/lib/jvm/'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"
  executar "java -jar $cache_path/IRPF.jar"
  cp /opt/projetus/facilitador/atalhos/IRPF.desktop "$desktop_path/Validadores"
  user_install "$acao%20202%20v1.0"

  endInstall
fi


if [ "$acao" = "Linphone" ]; then 

  if ! [ -x "$(command -v linphone)" ]; then
    echo $'#!/bin/bash 
      apt-get remove linphone --purge -y 
      apt-get autoremove'>$cache_path/exec.sh
    chmod +x $cache_path/exec.sh
    executar "pkexec $cache_path/exec.sh"
    user_install $acao
  fi

  if ! [ -x "$(command -v flatpak)" ]; then
    echo $'#!/bin/bash 
      apt-get install flatpak -y'>$cache_path/exec.sh
    chmod +x $cache_path/exec.sh
    executar "pkexec $cache_path/exec.sh"
  fi

  executar "flatpak --user install --from https://linphone.org/flatpak/linphone.flatpakref -y"
  
  showMessage "Linphone instalado com êxito!\nO atalho encontra-se no menu do sistema."
  user_install $acao
  exec $app_path/facilitador.sh 
fi
 
#if [ "$acao" = "Otimizações do Sistema" ]; then

#    echo $'#!/bin/bash 
#    dpkg --configure -a
#    apt update
#    apt install acpi-call zram-config -y
#    modprobe acpi-call
#    systemctl restart zram-config
#    sudo tee -a /etc/sysctl.d/99-sysctl.conf <<-EOF
#    vm.swappiness=1
#    vm.vfs_cache_pressure=50
#    vm.dirty_background_bytes=16777216
#    vm.dirty_bytes=50331648
#    EOF' > $cache_path/exec.sh 
    

#  chmod +x $cache_path/exec.sh
  
#  executar "pkexec $cache_path/exec.sh"
  
#  echo "\_SB.PCI0.LPCB.EC0.VPC0.SBMC 3" | sudo tee /proc/acpi/call
  

#  user_install "Otimizações%20do%20Sistema%201.0"  

#  showMessage "Otimização ativada com sucesso!\nReinicie sua máquina assim que possível."

#  exec $app_path/facilitador.sh 
#fi

if [ "$acao" = "Crisp Chat App" ]; then 

  download "https://cdn.projetusti.com.br/suporte/crisp-app.deb" "$cache_path/crisp.deb"

 
  echo $'#!/bin/bash 
  dpkg -i '$cache_path'/crisp.deb'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh

  executar "pkexec bash $cache_path/exec.sh"

  showMessage "Instalação concluída com sucesso!"

  exec $app_path/facilitador.sh 

fi


