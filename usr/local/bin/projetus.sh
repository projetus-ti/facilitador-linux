#!/usr/bin/env bash

# Autor: Fabiano Henrique
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte.


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


ano=`date +%Y`
arch=`uname -m`


acao=$1

# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet

# ----------------------------------------------------------------------------------------


# Não tem essa opção "ZRam" no arquivo /usr/local/bin/facilitador.sh na parte "Projetus e Outros"

# Debian

# 💡 O que é zram-config?

# zram-config é um pacote que configura e ativa o ZRAM — uma tecnologia que usa compressão 
# em memória RAM para criar espaço de swap eficiente. Pode melhorar o desempenho em 
# dispositivos com pouca RAM, como Raspberry Pi ou sistemas embarcados.

if [ "$acao" = "ZRam" ]; then

  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then

  echo "#!/bin/bash 
     sudo apt update
     sudo apt install -y zram-config " > "$cache_path"/exec.sh

  chmod +x "$cache_path"/exec.sh 2>> "$log"

  executar "pkexec $cache_path/exec.sh"

  showMessage "Otimização ativada com sucesso! \nReinicie sua máquina assim que possível."

  fi


  # Para Void Linux

  if which xbps-install &>/dev/null; then

# Como configurar ZRAM no Void Linux

xbps-query -l | grep zramen || sudo xbps-install -Suvy zramen


# Habilite o serviço:
# sudo ln -s /etc/sv/zramen /var/service

# Edite a configuração (opcional):
# Arquivo: /etc/zramen.conf

# ZRAM_DEVICES=1
# ZRAM_SIZE=1024  # em MB


# Reinicie o serviço ou o sistema:

# sudo sv restart zramen


# Para remover o ZRAM:

# sudo swapoff /dev/zram0
# sudo echo 0 > /sys/class/zram-control/hot_remove



  fi


  
  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Bitrix" ]; then

# https://www.bitrix24.com.br


# Link funcionando: tamanho 163M


  download "https://dl.bitrix24.com/b24/bitrix24_desktop.deb" "$cache_path/bitrix.deb"

  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then
  
  echo "#!/bin/bash 
      sudo dpkg -i $cache_path/bitrix.deb 
      sudo apt update && sudo apt -f install -y "> "$cache_path"/exec.sh

    chmod +x $cache_path/exec.sh 2>> "$log"

    executar "pkexec $cache_path/exec.sh"

 fi

    showMessage "Bitrix instalado com êxito! \nO atalho encontra-se no menu do sistema."

    /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------


if [ "$acao" = "MySuite" ]; then

# https://play.google.com/store/apps/details?id=air.mySuiteAndroid&hl=pt_BR
# https://www.brazip.com.br/sites/br/mysuite/
# https://campomourao.atende.net/cidadao/pagina/orientacoes-sistema-mysuite-help-desk


        yad --center --window-icon="$logo"  --title="MySuite (HELP DESK)" \
        --text="O sistema MySuite é uma aplicação desenvolvida pela BraZip que tem foco em atendimentos Help Desk. A Gerência de Tecnologia da Informação centraliza os atendimentos de suporte e serviços para organizar as atividades, priorizar os atendimentos conforme a necessidade e organiza a rotina dos profissionais afim de agilizar os atendimentos.


MySuite não tem versão para Linux usa o OcoMon.

https://ocomon.com.br/site/downloads/
" \
        --buttons-layout=center \
        --button="OK" \
        --width="900" --height="100" \
        2>/dev/null


  # configurarWine

# $ wget -c https://cdn.projetusti.com.br/suporte/mysuite.msi
# --2025-10-23 18:10:30--  https://cdn.projetusti.com.br/suporte/mysuite.msi
# Resolvendo cdn.projetusti.com.br (cdn.projetusti.com.br)... falha: Nome ou serviço desconhecido.
# wget: não foi possível resolver endereço de máquina "cdn.projetusti.com.br"


  # download "https://cdn.projetusti.com.br/suporte/mysuite.msi" "$cache_path/mysuite.msi"

  # wine msiexec /i "$cache_path"/mysuite.msi /quiet > /dev/null 2>&1 &

  # rm -Rf "$desktop_path/BraZip Central.lnk" 2>> "$log"

  # showMessage "O MySuite foi instalado com sucesso! \nO atalho encontra-se em sua Área de Trabalho."



  if which xbps-install &>/dev/null; then


  # https://ocomon.com.br/site/algumas-telas/

  # https://ocomon.com.br/site/instalacao/


  # Servidor web com Apache (não testado com outros servidores)

  sudo xbps-install -Suvy apache  | tee -a "$log"

  # MySQL (ou MariaDB)

  sudo xbps-install -Suvy mariadb | tee -a "$log"

  # PHP

  sudo xbps-install -Suvy php | tee -a "$log"


  echo -e "\nBaixando o OcoMon...\n"

  download="https://sourceforge.net/projects/ocomonphp/files/latest/download" 

  wget -c "$download" -O "$cache_path/ocomon.zip" | tee -a "$log"


  # Extrair o arquivo para /var/www

  sudo mkdir -p /var/www  2>> "$log"

  sudo unzip "$cache_path/ocomon.zip" -d /var/www | tee -a "$log"

  sudo mv /var/www/ocomon*  /var/www/ocomon 2>> "$log"


  # Importe o arquivo de atualização do banco de dados "00-DB-UPDATE_FROM_6.0.1.sql"


# Caso queira que a base e/ou usuario tenham outro nome (ao invés de "ocomon_6"), edite diretamente no arquivo (identifique as entradas relacionadas ao nome do banco, usuário e senha no início do arquivo):

# 01-DB_OCOMON_6.x-FRESH_INSTALL_STRUCTURE_AND_BASIC_DATA.sql

# antes de realizar a importação do mesmo. Utilize essas mesmas informações no arquivo de configurações do sistema

 # sudo mysql -u root -p < /var/www/ocomon/install/6.x/01-DB_OCOMON_6.x-FRESH_INSTALL_STRUCTURE_AND_BASIC_DATA.sql

  # É importante alterar essa senha do usuário "ocomon_6" no MySQL logo após a instalação do sistema.

# Após a importação, é recomendável a exclusão da pasta "install".




# Para abrir o OcoMon (criando o arquivo .desktop)


sudo echo "[Desktop Entry]
Version=1.0
Type=Application
Name=OcoMon
Name[pt_BR]=OcoMon
Comment=Access Ocomon on localhost:8080
Comment[pt_BR]=Acesse Ocomon em localhost:8080
Exec=xdg-open http://localhost:8080
Icon=/var/www/ocomon/favicon.svg
Terminal=false
Categories=Network;

Keywords=ocomon;
Keywords[pt_BR]=ocomon;chamado;

" > /usr/share/applications/ocomon.desktop


# Torne o arquivo .desktop executável

chmod +x /usr/share/applications/ocomon.desktop


  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Discord" ]; then

# https://discord.com/download


    download "https://stable.dl2.discordapp.net/apps/linux/0.0.112/discord-0.0.112.deb" "$cache_path/discord.deb"

  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then
  
    echo "#!/bin/bash 
      sudo dpkg -i $cache_path/discord.deb 
      sudp apt update && sudo apt -f install -y " > "$cache_path"/exec.sh

    chmod +x $cache_path/exec.sh 2>> "$log"

    executar "pkexec $cache_path/exec.sh"

  fi
  
    showMessage "Discord instalado com êxito! \nO atalho encontra-se no menu do sistema."

    /usr/local/bin/facilitador.sh

fi  

# ----------------------------------------------------------------------------------------

if [ "$acao" = "TeamViewer" ]; then

# https://www.teamviewer.com/pt-br/download/linux/


  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then

  # Baixe a versão mais recente do TeamViewer para Debian ou derivados para sistema 64 bit

  download "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" "$cache_path/tv.deb"
  
  echo "#!/bin/bash 
    sudo dpkg -i $cache_path/tv.deb 
    sudo apt update && sudo apt -f install -y
    sudo apt-mark hold teamviewer" > "$cache_path"/exec.sh

  chmod +x $cache_path/exec.sh 2>> "$log"

  executar "pkexec $cache_path/exec.sh"
  
 fi

  showMessage "TeamViewer instalado com êxito! \nO atalho encontra-se no menu do sistema."

  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "AnyDesk" ]; then

# https://anydesk.com/pt/downloads/linux



ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

    echo -e "\n✅ Sistema 64 bits detectado: $ARCH \n"


sudo rm -Rf /opt/anydesk-* 2>> "$log"

  download="https://download.anydesk.com/linux/anydesk-7.1.0-amd64.tar.gz" 

  wget -c "$download" -O "$cache_path/anydesk-amd64.tar.gz" | tee -a "$log"

# Para extrair o arquivo anydesk-amd64.tar.gz que está localizado em $cache_path/anydesk-amd64.tar.gz para o diretório /opt/


tar -xzvf "$cache_path/anydesk-amd64.tar.gz" -C /opt/ 2>> "$log"  && sudo mv /opt/anydesk-* /opt/anydesk 2>> "$log"

sudo ln -s /opt/anydesk/anydesk  /usr/bin/anydesk 2>> "$log"

sudo cp -r /opt/anydesk/anydesk.desktop /usr/share/applications/ 2>> "$log"


  # Verificar se está rodando no Void Linux
  
  if which xbps-install  &>/dev/null; then

    sudo xbps-install -Sy gtk+3 2>> "$log"

  fi

# sudo cp -r /opt/anydesk/icons/        /usr/share/  2>> "$log"

sudo cp /opt/anydesk/icons/hicolor/48x48/apps/anydesk.png /usr/share/pixmaps/ 2>> "$log"


# Para atualizar o banco de dados de todos os arquivos .desktop

sudo update-desktop-database /usr/share/applications/


  cp /usr/share/applications/anydesk.desktop "$desktop_path/Validadores" 2>> "$log"

  endInstall


  /usr/local/bin/facilitador.sh


else

    echo "🧯 Sistema 32 bits detectado: $ARCH

Não existe versão do AnyDesk para arquitetura 32-bit atualmente para o Linux.
"

        yad --center --window-icon="$logo"  --title="🧯 Sistema 32 bits detectado" \
        --text="Não existe versão do AnyDesk para arquitetura 32-bit atualmente para o Linux." \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

fi





fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Skype" ]; then

# https://web.skype.com


        yad --center --window-icon="$logo"  --title="🧯 Skype" \
        --text="O Skype não está mais sendo atualizado e foi descontinuado no dia 5 de maio de 2025. 

A Microsoft orienta os usuários a migrarem para o Microsoft Teams (versão gratuita).

https://www.microsoft.com/pt-br/microsoft-teams/log-in
" \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

  # Verificar se está rodando em Debian ou derivados
  
#  if which apt &>/dev/null; then
  
#  download "https://repo.skype.com/latest/skypeforlinux-64.deb" "$cache_path/skype.deb"

#  echo "#!/bin/bash 
#    sudo dpkg -i $cache_path/skype.deb 
#    sudo apt update && sudo apt -f install -y " > "$cache_path"/exec.sh

#  chmod +x "$cache_path"/exec.sh 2>> "$log"

#  executar "pkexec $cache_path/exec.sh"
  
#  fi
  
#  showMessage "Skype instalado com êxito! \nO atalho encontra-se no menu do sistema."

  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DBeaver" ]; then

# https://dbeaver.io/download/


  echo -e "\nBaixando o DBeaver Community...\n"




  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then
  
ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

    echo "✅ Sistema 64 bits detectado: $ARCH"


  download "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" "$cache_path/dbeaver.deb"
  
  echo "#!/bin/bash 
    sudo dpkg -i $cache_path/dbeaver.deb 
    sudo apt update && sudo apt -f install -y " > "$cache_path"/exec.sh

  chmod +x $cache_path/exec.sh 2>> "$log"

  executar "pkexec $cache_path/exec.sh"

fi
    

  fi



  if which xbps-install &>/dev/null; then


sudo xbps-install -Sy glib gtk+3 mesa | tee -a "$log"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

    echo -e "\n✅ Sistema 64 bits detectado: $ARCH \n"


    download="https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64-nojdk.tar.gz"

    wget -P "$cache_path" -c "$download" | tee -a "$log"

    sleep 1

    cd "$cache_path"

    # Extraia o arquivo diretamente para /opt

    sudo tar -xvzf dbeaver-ce-latest-linux.gtk.x86_64-nojdk.tar.gz -C /opt | tee -a "$log"


    # Crie um link simbólico para facilitar o acesso:

    sudo ln -s /opt/dbeaver/dbeaver /usr/local/bin/dbeaver


   # Agora você pode abrir o DBeaver apenas digitando:

   # dbeaver &


fi



DESKTOP_FILE="/opt/dbeaver/dbeaver-ce.desktop"

if [ -f "$DESKTOP_FILE" ]; then

    echo "✅ O arquivo $DESKTOP_FILE existe."

    sudo cp /opt/dbeaver/dbeaver-ce.desktop /usr/share/applications/  2>> "$log"

else

    echo "❌ O arquivo $DESKTOP_FILE não existe."
    

   # Criar um atalho no menu

    echo "Criando arquivo .desktop padrão..."

   sudo echo "[Desktop Entry]
Name=DBeaver Community
Comment=Universal Database Manager
Exec=/opt/dbeaver/dbeaver
Icon=/opt/dbeaver/dbeaver.png
Terminal=false
Type=Application
Categories=Development;Database;
" > /usr/share/applications/dbeaver.desktop

    echo "✔️ Arquivo $DESKTOP_FILE criado..."
fi








# Esse erro ocorre porque o DBeaver foi compilado com uma versão mais recente do Java (Java 17, versão 61.0), enquanto o Java Runtime instalado no seu sistema é uma versão mais antiga (provavelmente Java 11, versão 55.0 ou anterior).

# 🚀 Solução

# A solução aqui é instalar uma versão mais recente do Java, compatível com o DBeaver, como o Java 17 ou superior.


# $ env NO_AT_BRIDGE=1 dbeaver
# Erro: ocorreu LinkageError ao carregar a classe principal org.eclipse.equinox.launcher.Main
#	java.lang.UnsupportedClassVersionError: org/eclipse/equinox/launcher/Main has been compiled by a more recent version of the Java Runtime (class file version 61.0), this version of the Java Runtime only recognizes class file versions up to 55.0


# Verifica a versão do Java

JAVA_VERSION=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
MAJOR_VERSION=$(echo $JAVA_VERSION | awk -F. '{print $1}')


# Verifica se a versão é menor que 21

if [ "$MAJOR_VERSION" -lt 21 ]; then

    echo -e "\n❌ A versão do Java é inferior a 21 (versão detectada: $JAVA_VERSION). Instalando o OpenJDK 21...\n"

    sudo xbps-install -Sy openjdk21 | tee -a "$log"


    sudo ln -sf /lib/jvm/openjdk21/bin/java  /usr/local/bin/

    java --version

    sleep 10

else

    echo -e "\n✅ A versão do Java já é $JAVA_VERSION ou superior. Nenhuma atualização necessária.\n"

fi




  fi



# Flatpak 

# flatpak install flathub io.dbeaver.DBeaverCommunity



  showMessage "DBeaver instalado com êxito! \nO atalho encontra-se no menu do sistema."

  /usr/local/bin/facilitador.sh


fi


# ----------------------------------------------------------------------------------------

if [ "$acao" = "Calima App" ]; then

  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then
  
  URL_CALIMA_APP=$(curl -L -X GET \
  -H'Content-Type: application/json' \
  'https://cloud-api-controller.projetusti.com.br/versao/sistema/get?identificacao=calima-app' \
 | python3 -c "import sys, json; print(json.load(sys.stdin)['informacaoComplementar'].split(';')[0])")

  download "$URL_CALIMA_APP" "$cache_path/calima.deb"

  rm -Rf $HOME/.config/calima-app      2>> "$log"
  rm -Rf $HOME/.config/calima-app-web  2>> "$log"
  
  echo "#!/bin/bash 
    sudo apt purge -y calima-app
    sudo apt purge -y calima-app-web
    sudo dpkg -i $cache_path/calima.deb
    # cp /usr/share/applications/calima-app-local.desktop /usr/share/applications/
    sudo chmod 755 /usr/share/applications/calima-app-local.desktop
    sudo apt update && sudo apt -f install -y " > "$cache_path"/exec.sh

  chmod +x $cache_path/exec.sh 2>> "$log"

  executar "pkexec $cache_path/exec.sh"
  
  fi
  
  showMessage "Calima App Local instalado com êxito! \nO atalho encontra-se no menu do sistema."

  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "iSGS App" ]; then


  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then
  
# $ wget https://cdn.projetusti.com.br/suporte/isgs-app_1.0.1_amd64.deb
# --2025-10-23 16:50:44--  https://cdn.projetusti.com.br/suporte/isgs-app_1.0.1_amd64.deb
# Resolvendo cdn.projetusti.com.br (cdn.projetusti.com.br)... falha: Nome ou serviço desconhecido.
# wget: não foi possível resolver endereço de máquina “cdn.projetusti.com.br”


  download "https://cdn.projetusti.com.br/suporte/isgs-app_1.0.1_amd64.deb" "$cache_path/isgs.deb"
  
  echo "#!/bin/bash 
    sudo dpkg -i $cache_path/isgs.deb 
    sudo apt update && sudo apt -f install -y " > "$cache_path"/exec.sh

  chmod +x $cache_path/exec.sh 2>> "$log"

  executar "pkexec $cache_path/exec.sh"
  
  fi
    
  showMessage "iSGS App instalado com êxito! \nO atalho encontra-se no menu do sistema."

  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "IRPF" ]; then

  # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dirpf


  download="https://downloadirpf.receita.fazenda.gov.br/irpf/${ano}/irpf/arquivos/IRPF${ano}Linux-${arch}v1.7.sh.bin" 

  wget -c "$download" -O "$cache_path/irpf.bin" | tee -a "$log"
  
  chmod +x $cache_path/irpf.bin 2>> "$log"

  cd "$cache_path"

  sudo ./irpf.bin 2>> "$log"

  # cd $app_path
  # echo $'#!/bin/bash 
  # dpkg --configure -a
  # apt update 
  # apt install -y openjdk-8-jre 2>> "$log"
  # tar -xvf '$cache_path'/jre-8u212-linux-x64.tar.gz --directory /usr/lib/jvm/'>$cache_path/exec.sh

  # chmod +x $cache_path/exec.sh 2>> "$log"
  # executar "pkexec $cache_path/exec.sh"
  # executar "java -jar $cache_path/IRPF.jar"
  
  cp /usr/share/applications/IRPF.desktop "$desktop_path/Validadores" 2>> "$log"

  endInstall

fi

# ----------------------------------------------------------------------------------------


if [ "$acao" = "Linphone" ]; then 

# https://download.linphone.org/releases/linux/app/


# Pega a versão

# URL de onde o arquivo .AppImage está listado
url="https://download.linphone.org/releases/linux/app/"

# Baixando o conteúdo da página de download
html_content=$(curl -s "$url")

# Extraindo os links para os arquivos .AppImage, excluindo os .sha512
appimage_links=$(echo "$html_content" | grep -oP 'href="\K.*?Linphone-\d+\.\d+\.\d+\.AppImage' | grep -v '\.sha512' | sort -V | uniq)

# Pegando a versão mais recente
first_version=$(echo "$appimage_links" | tail -n 2)

# Exibindo a versão
# echo "A versão mais recente do Linphone é:"
# Extraindo a versão do nome do arquivo
version=$(echo "$first_version" | sed -n 's/.*Linphone-\([0-9]\+\.[0-9]\+\.[0-9]\+\)\.AppImage/\1/p' | head -n 1)
echo "$version"



  download "https://download.linphone.org/releases/linux/app/Linphone-$version.AppImage" "$atalho_path/linphone.AppImage"

  bash "$atalho_path/linphone.sh"

  showMessage "Linphone instalado com êxito! \nO atalho encontra-se no menu do sistema."

  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------
 
if [ "$acao" = "Crisp Chat App" ]; then 


  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then
  
  download "https://cdn.projetusti.com.br/suporte/crisp-app.deb" "$cache_path/crisp.deb"

 
  echo "#!/bin/bash 
  sudo dpkg -i $cache_path/crisp.deb " > "$cache_path"/exec.sh

  chmod +x $cache_path/exec.sh

  executar "pkexec bash $cache_path/exec.sh"

  showMessage "Instalação concluída com sucesso!"

  /usr/local/bin/facilitador.sh 

  fi


fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Zoom" ]; then

# https://www.zoom.com/pt/

# https://www.zoom.us/pt/download


notify-send -i "/run/media/anon/daf5b603-ed05-46f5-b5ec-5535135cc56a/usr/local/bin/facilitador-linux/usr/share/icons/facilitador/us.zoom.Zoom.desktop.png" -t $tempo_notificacao "$titulo" "\nIniciando a instalação do Zoom...\n"


# ========================================================================================

# Tenta descobrir a versão mais recente do Zoom para Linux
# salvando em $zoom_versao

# Arquitetura da máquina (por exemplo, x86_64)

arch=$(uname -m)

# URL "latest" que redireciona para a versão concreta
# Pode variar dependendo do site da Zoom — ajustar se necessário

latest_url="https://zoom.us/client/latest/zoom_${arch}.tar.xz"


# Fazer requisição HEAD (ou seguir redirecionamentos) para descobrir a URL final

location=$(curl -sIL "$latest_url" | grep -i "^location:" | tail -n1 | tr -d '\r')

# Ex: location pode ser algo como:
#   Location: https://cdn.zoom.us/prod/6.6.0.4410/zoom_x86_64.tar.xz

if [[ -z "$location" ]]; then
  echo "Não foi possível obter localização/redirecionamento."
  exit 1
fi

# Extrair a parte que representa a versão (ex: 6.6.0.4410)
# Usamos uma expressão regular para pegar números separados por ponto

zoom_versao=$(echo "$location" | grep -oP '(?<=/prod/)[0-9]+(\.[0-9]+)+' | head -n1)

if [[ -z "$zoom_versao" ]]; then
  echo "Não foi possível extrair a versão de '$location'."

  zoom_versao="6.6.0.4410"

  # exit 1

fi

# Construir URL final usando versão + arquitetura

zoom_url="https://cdn.zoom.us/prod/${zoom_versao}/zoom_${arch}.tar.xz"

# Mostrar resultados

echo "Versão do Zoom: $zoom_versao"
echo "URL de download: $zoom_url"


# Versão do Zoom: 6.6.0.4410
# URL de download: https://cdn.zoom.us/prod/6.6.0.4410/zoom_x86_64.tar.xz

# ========================================================================================



  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then

    # https://zoom.us/client/latest/zoom_amd64.deb

    # deb (for Debian 10.0+)

    download "https://cdn.zoom.us/prod/${zoom_versao}/zoom_amd64.deb" "$cache_path/zoom.deb"

    echo "#!/bin/bash 
      sudo dpkg -i $cache_path/zoom.deb 
      sudo apt update && sudo apt -f install -y" > "$cache_path"/exec.sh

    chmod +x $cache_path/exec.sh 2>> "$log"

    executar "pkexec $cache_path/exec.sh"

  fi


  # Para Void Linux

  if which xbps-install &>/dev/null; then

   # Versão 6.6.0 (4410)

   # download="https://cdn.zoom.us/prod/${zoom_versao}/zoom_${arch}.tar.xz" 

   # wget -c "$download" -O "$cache_path/zoom_${arch}.tar.xz" | tee -a "$log"
  
   # Para extrair o Zoom em /opt

   # sudo tar -xf zoom_${arch}.tar.xz -C /opt

   # sleep 2

   # ls -l /opt/zoom/zoom


   # $ ./zoom 
   # ./zoom: symbol lookup error: ./zoom: undefined symbol: _ZSt24__throw_out_of_range_fmtPKcz, version Qt_5




# Última alternativa — usar o Zoom via Flatpak

# https://flathub.org/pt-BR/apps/us.zoom.Zoom

# https://www.edivaldobrito.com.br/zoom-no-linux-veja-como-instalar-esse-app-de-videoconferencia/


# Isso elimina todas as incompatibilidades, pois roda tudo isolado:

sudo xbps-install -Sy flatpak         2>> "$log"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

    echo "✅ Sistema 64 bits detectado: $ARCH"

# Instalação manual

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  2>> "$log"

sudo flatpak install -y flathub us.zoom.Zoom | tee -a "$log"

# Para executar

# flatpak run us.zoom.Zoom

fi


  fi

    showMessage "Zoom instalado com êxito! \nO atalho encontra-se no menu do sistema."

    /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------


exit 0

