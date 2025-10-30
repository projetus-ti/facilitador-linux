#!/usr/bin/env bash

# Autor: Fabiano Henrique
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte.



# ----------------------------------------------------------------------------------------

# Verifica se o arqivo existe

if [[ ! -e /etc/facilitador.conf ]]; then

    echo -e "\nO arquivo /etc/facilitador.conf não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="O arquivo /etc/facilitador.conf não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2> /dev/null
        
    exit 1
fi


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# ----------------------------------------------------------------------------------------


# Verifica se o arqivo existe

if [[ ! -e /usr/local/bin/funcoes.sh ]]; then

    echo -e "\nO arquivo /usr/local/bin/funcoes.sh não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="O arquivo /usr/local/bin/funcoes.sh não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2> /dev/null
        
    exit 1
fi

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

    chmod +x "$cache_path"/exec.sh 2>> "$log"

    executar 'pkexec "'$cache_path'"/exec.sh'

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


  clear

  echo -e "\n✅ Instalando o OcoMon... \n"

  # Para Debian e derivados
  
  if which apt &>/dev/null; then
  
   sudo apt install -y apache   | tee -a "$log"
   sudo apt install -y mariadb  | tee -a "$log"
   sudo apt install -y php      | tee -a "$log"
   
  fi
  
  
  # Para Arch Linux e derivados
  
  if which pacman &>/dev/null; then

   sudo pacman -S apache  --noconfirm    | tee -a "$log"
   sudo pacman -S mariadb --noconfirm    | tee -a "$log"
   sudo pacman -S php     --noconfirm    | tee -a "$log"
   
  fi 
  
  # Para Void Linux
  
  if which xbps-install &>/dev/null; then


  # https://ocomon.com.br/site/algumas-telas/

  # https://ocomon.com.br/site/instalacao/


  # Servidor web com Apache (não testado com outros servidores)

  sudo xbps-install -Suvy apache  | tee -a "$log"

  # MySQL (ou MariaDB)

  sudo xbps-install -Suvy mariadb | tee -a "$log"

  # PHP

  sudo xbps-install -Suvy php | tee -a "$log"

 fi  

 
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
Name[en_US]=OcoMon
Name[es]=OcoMon
Name[pt_BR]=OcoMon

Comment=Access Ocomon on localhost:8080.
Comment[en_US]=Access Ocomon on localhost:8080.
Comment[es]=Acceda a Ocomon en localhost:8080.
Comment[pt_BR]=Acesse Ocomon em localhost:8080.

Exec=xdg-open http://localhost:8080
Icon=/var/www/ocomon/favicon.svg
Terminal=false
Categories=Network;

Keywords=ocomon;
Keywords[en_US]=ocomon;
Keywords[es_ES]=ocomon;
Keywords[pt_BR]=ocomon;chamado;


" > /usr/share/applications/ocomon.desktop


# Torne o arquivo .desktop executável

chmod +x /usr/share/applications/ocomon.desktop | tee -a "$log"





  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Discord" ]; then

# https://discord.com/download


    download "https://stable.dl2.discordapp.net/apps/linux/0.0.112/discord-0.0.112.deb" "$cache_path/discord.deb"

  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then
  
    echo '#!/bin/bash 
      sudo dpkg -i "'$cache_path'"/discord.deb
      sudp apt update && sudo apt -f install -y ' > "$cache_path"/exec.sh

    chmod +x "$cache_path"/exec.sh 2>> "$log"

    executar 'pkexec "'$cache_path'"/exec.sh'

  fi
  
    showMessage "Discord instalado com êxito! \nO atalho encontra-se no menu do sistema."

    /usr/local/bin/facilitador.sh

fi  

# ----------------------------------------------------------------------------------------

if [ "$acao" = "TeamViewer" ]; then

# Alternativas (se preferir software livre): RustDesk


# O RustDesk funciona de forma similar ao TeamViewer, oferecendo acesso remoto entre computadores 
# através da internet. Ele pode ser usado para controlar uma máquina remotamente, seja dentro da 
# sua rede local ou pela internet. O grande diferencial do RustDesk é que ele é open-source e 
# não depende de servidores terceiros para a comunicação (embora seja possível configurar 
# servidores próprios, se necessário).

# https://flathub.org/en/apps/com.rustdesk.RustDesk



# https://www.teamviewer.com/pt-br/download/linux/


# ----------------------------------------------------------------------------------------

  # Verificar se está rodando em Debian ou derivados

  if which apt &>/dev/null; then

  # Baixe a versão mais recente do TeamViewer para Debian ou derivados para sistema 64 bit

  download "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" "$cache_path/tv.deb"
  
  echo '#!/bin/bash 
    sudo dpkg -i "'$cache_path'"/tv.deb 
    sudo apt update && sudo apt -f install -y
    # sudo apt-mark hold teamviewer' > "$cache_path"/exec.sh

  chmod +x "$cache_path"/exec.sh 2>> "$log"

  executar "pkexec $cache_path/exec.sh"
  
  fi

# ----------------------------------------------------------------------------------------

  
  # Para Arch Linux e derivados.
  
  

  if which pacman &>/dev/null; then
  
  
  
# Obs: O BigLinux tem um script apt mesmo usando a base Arch Linux.

# which apt 
# /usr/local/bin/apt

# ❯ file /usr/local/bin/apt
# /usr/local/bin/apt: Bourne-Again shell script, ASCII text executable

# ❯ cat /usr/local/bin/apt
#!/bin/bash

#Translation
# export TEXTDOMAINDIR="/usr/share/locale"
# export TEXTDOMAIN=biglinux-improve-compatibility


# echo $"This system uses pamac to manage packages."
# echo $"Redirecting your command to the pamac command"
# echo ""
# echo ""

# pamac $*


# Verifica se o arqivo existe

if [[ -e /usr/local/bin/apt ]]; then

sudo chmod -x /usr/local/bin/apt

fi


  # Remove se tiver instalado
  
  pacman -Q teamviewer && sudo pacman -Rs --noconfirm teamviewer  | tee -a "$log"

  
  # sudo pacman -Syu | tee -a "$log"

  sudo pacman -S --needed base-devel git --noconfirm

  # Instalar AUR

  git clone https://aur.archlinux.org/yay.git

  cd yay

  makepkg -si


  # Instalar TeamViewer via AUR

  if which yay &>/dev/null; then

  yay -S teamviewer

  fi



  fi

# https://www.teamviewer.com/pt-br/global/support/knowledge-base/teamviewer-classic/installation/linux/install-teamviewer-classic-on-other-linux-distributions/


# ----------------------------------------------------------------------------------------

  # Para Void Linux


  # Instalando o TeamViewer a partir do pacote .deb

  # https://www.teamviewer.com/pt-br/download/free-download-with-license-options/


  if which xbps-install &>/dev/null; then

# xbps-query -Rs teamviewer




# Função para instalar o TeamViewer no Void Linux.

instalar_teamviewer() {



# <b>Iniciar o serviço:</b> sudo sv start teamviewerd

# <b>Parar o serviço:</b> sudo sv stop teamviewerd

# <b>Reiniciar o serviço:</b> sudo sv restart teamviewerd

# Ver logs em tempo real: sudo tail -f /var/log/teamviewerd/current ou sudo tail -f /var/log/teamviewer*/TeamViewer*_Logfile.log

# <b>Obs:</b> Caso o serviço não inicia com: <b>sudo sv start teamviewerd</b> 
# pode usar o comando <b>/opt/teamviewer/tv_bin/teamviewerd</b> direto.

# Para ver se há algum erro ou mensagem que ajude a entender o problema.



# Exibir uma caixa de aviso com yad

yad \
--center \
--window-icon="$logo" \
--title="Aviso de Instalação Manual" \
--text="Este é um processo de instalação manual para o TeamViewer no Void Linux.
    
<b>Aviso importante:</b>

- Este processo envolve a extração manual do pacote .deb e a criação de um serviço para o TeamViewer.
- A remoção do TeamViewer deve ser feita manualmente, removendo os arquivos e diretórios criados durante a instalação.


Iniciando o TeamViewer: 

$ sudo /opt/teamviewer/tv_bin/teamviewerd -d


O arquivo $cache_path/conteudo_teamviewer.txt, que será gerado, contém uma lista completa dos 
arquivos do pacote .deb. Assim, esses arquivos podem ser removidos manualmente utilizando o 
comando 'sudo rm arquivo'.

Deseja prosseguir com a instalação mesmo assim?" \
--buttons-layout=center \
--button="Não:1" --button="Sim:0" \
--width="700" --height="400" \
2>/dev/null


# Captura a resposta do usuário

response=$?


if [ "$response" -eq 0 ]; then




which ar 2> /dev/null || {  yad --center --window-icon="$logo" --title="$titulo" --text="Erro: ar não está instalado." --buttons-layout=center --button=OK:0 2> /dev/null && exit ; }


    # Se o usuário escolheu "Sim", proceder com a instalação

    echo -e "\nIniciando o processo de instalação... \n"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

    echo -e "\n✅ Sistema 64 bits detectado: $ARCH \n"


    download="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"

    wget -P "$cache_path" -c "$download" | tee -a "$log"

    sleep 1

    cd "$cache_path"

    # Extraia o conteúdo do pacote .deb para /opt

    ar x teamviewer_amd64.deb | tee -a "$log"


    # Isso vai gerar 3 arquivos: control.tar.xz, data.tar.xz, e debian-binary.

    # Extraia o arquivo data.tar.xz:

    sudo rm -Rf /opt/teamviewer | tee -a "$log"

    sudo mkdir -p /opt/teamviewer | tee -a "$log"

    sudo tar -xvJf data.tar.xz -C / | tee -a "$log"


    # Para pegar a versão do TeamViewer
    
    sudo tar -xvJf control.tar.xz | tee -a "$log"



# Para salvar o conteúdo do arquivo compactado data.tar.xz (geralmente encontrado dentro 
# de pacotes .deb) em um arquivo .txt.

    tar -tf data.tar.xz  > "$cache_path"/conteudo_teamviewer.txt


# Substituir somente as ocorrências de ./ no início de cada linha por /

sed -i 's|^\./|/|' "$cache_path"/conteudo_teamviewer.txt


# 🧩 Regra geral (conteudo_teamviewer.txt):

# Diretórios → terminam com /

# Arquivos → não terminam com /

grep -v '/$' "$cache_path/conteudo_teamviewer.txt" > "$cache_path/arquivos_teamviewer.txt"

sudo chmod 755 "$cache_path/conteudo_teamviewer.txt" | tee -a "$log"

sudo chmod 755 "$cache_path/arquivos_teamviewer.txt" | tee -a "$log"


sleep 1

# mv "$cache_path/arquivos_teamviewer.txt" "$cache_path/conteudo_teamviewer.txt"


teamviewer_versao=$(cat "$cache_path"/control | grep Version | cut -d: -f2 | sed s'/ //'g)


# Remove os arquivos extraidos do arquivo control.tar.xz

sudo rm -Rf "$cache_path"/conffiles       | tee -a "$log"
sudo rm -Rf "$cache_path"/control         | tee -a "$log"
sudo rm -Rf "$cache_path"/control.tar.xz  | tee -a "$log"
sudo rm -Rf "$cache_path"/debian-binary   | tee -a "$log"
sudo rm -Rf "$cache_path"/postinst        | tee -a "$log"
sudo rm -Rf "$cache_path"/postrm          | tee -a "$log"
sudo rm -Rf "$cache_path"/preinst         | tee -a "$log"
sudo rm -Rf "$cache_path"/prerm           | tee -a "$log"


    # cp /opt/teamviewer/tv_bin/desktop/teamviewer8.desktop  /usr/share/applications/


    # Crie um link simbólico para facilitar o acesso:

    sudo ln -sf /opt/teamviewer/opt/teamviewer/tv_bin/TeamViewer  /usr/local/bin/teamviewer     | tee -a "$log"

    sudo ln -sf /opt/teamviewer/tv_bin/desktop/teamviewer_48.png  /usr/share/pixmaps/TeamViewer | tee -a "$log"



# Para atualizar o banco de dados de todos os arquivos .desktop

sudo update-desktop-database /usr/share/applications/ | tee -a "$log"

sudo update-desktop-database | tee -a "$log"

sudo gtk-update-icon-cache  | tee -a "$log"  && sudo gtk-update-icon-cache /usr/share/icons/hicolor | tee -a "$log"


    # Para remover os arquivos extraídos do pacote .deb

    sudo rm -Rf "$cache_path"/control.tar.xz | tee -a "$log" # Contém os metadados de controle do pacote .deb (informações sobre dependências, scripts de instalação, etc.).
    sudo rm -Rf "$cache_path"/data.tar.xz    | tee -a "$log" # Contém os arquivos de dados do pacote (as bibliotecas, binários, etc. que são extraídos e instalados).
    sudo rm -Rf "$cache_path"/debian-binary  | tee -a "$log" # Contém a versão do formato .deb do pacote (geralmente apenas uma string, tipo 2.0).

    echo -e "\nArquivos do pacote .deb removidos com sucesso... \n"

   # Agora você pode abrir o TeamViewer apenas digitando:

   # teamviewer &



# erro libminizip.so.1: cannot open shared object file, indica que o TeamViewer não conseguiu encontrar a biblioteca compartilhada libminizip.so.1, que é uma dependência necessária para o funcionamento do programa.


# teamviewer 

# Init...
# CheckCPU: SSE2 support: yes
# Checking setup...
# Launching TeamViewer ...
# Starting network process (no daemon)
# /opt/teamviewer/tv_bin/teamviewerd: error while loading shared libraries: libminizip.so.1: cannot open shared object file: No such file or directory
# Network process already started (or error)
# Launching TeamViewer GUI ...


# Isso deve instalar a versão correta da libminizip.so e corrigir o problema.

sudo xbps-install -Suvy minizip | tee -a "$log"


fi


# Para adaptar o TeamViewer para o Void Linux


#  Forma de iniciar um serviço no Void Linux (Padrão)

echo -e "\nCriando um Serviço com runit para o TeamViewer... \n"

# Estrutura de diretórios do serviço

sudo rm -Rf /etc/sv/teamviewerd | tee -a "$log"

sudo mkdir -p /etc/sv/teamviewerd/log | tee -a "$log"



# Arquivo principal: /etc/sv/teamviewerd/run

# Crie o arquivo run dentro do diretório /etc/sv/teamviewerd/


# Quando executa o comando manualmente ./run start, o script funciona, mas quando tenta usar o sudo sv start teamviewerd, o serviço falha com o erro timeout: down: teamviewerd: 1s, normally up, want up.


echo '#!/bin/sh

# Autor: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Colaboração: 
# Data: 27/10/2025
# Licença:  MIT
# Descricao: Serviço runit para o daemon do TeamViewer.


# Arquivo: /etc/sv/teamviewerd/run


# Esse script foi gerado usando o projeto:

# https://github.com/tuxslack/facilitador-linux

# Você não deve usar sudo dentro de um serviço runit, porque o serviço já é iniciado pelo 
# root (via runsvdir).


# Envia stderr para stdout (opcional, facilita logs)
exec 2>&1


# Caminho para o daemon do TeamViewer

# TEAMVIEWER_DAEMON="/opt/teamviewer/tv_bin/teamviewerd"



# Função para iniciar o serviço

start_service() {
	

    if pgrep -x "teamviewerd" > /dev/null
        then

            echo "TeamViewer já está rodando."

        else

            echo "Iniciando o TeamViewer..."


            # Executa o daemon em primeiro plano (sem sudo)

            # exec /opt/teamviewer/tv_bin/teamviewerd -d


            # Roda o daemon em foreground (mantém o processo atrelado ao terminal sem -d).

            exec /opt/teamviewer/tv_bin/teamviewerd

# O exec substitui o shell pelo processo do TeamViewer em foreground,
# e o runit supervisiona esse processo — se ele cair, será reiniciado.


# O binário (teamviewerd) é o daemon (serviço principal) do TeamViewer.

# Ele precisa estar rodando em segundo plano para que o cliente gráfico (teamviewer) 
# funcione — é quem gera o ID, mantém a conexão com os servidores da TeamViewer, etc.

# O -d executa em background como daemon (inicia o serviço).

# Runit prefere processos em foreground.

# Portanto, no runit, você normalmente NÃO usa -d, mesmo que o comando aceite.



    fi

}


# Função para parar o serviço

stop_service() {
	
    echo "Parando o TeamViewer..."
    
    # Envia um sinal para parar o processo teamviewerd
    
    exec pkill -f teamviewerd
}


# Função para reiniciar o serviço

restart_service() {
	
    echo "Reiniciando o TeamViewer... "
    
    stop_service
    
    sleep 1
    
    start_service
    
}


# Checa o primeiro argumento (start, stop, restart)

case "$1" in
    start)
        start_service
        ;;
        
    stop)
        stop_service
        ;;
        
    restart)
        restart_service
        ;;
    *)
        echo "Uso: $0 {start|stop|restart}"
        
        exit 1
        
        ;;
esac

' | sudo tee /etc/sv/teamviewerd/run > /dev/null





# Verifique as permissões do diretório /etc/sv/teamviewerd/ para garantir que o runit tenha acesso ao script.

sudo chmod -R 755 /etc/sv/teamviewerd


# Torne o script executável:

# sudo chmod +x /etc/sv/teamviewerd/run | tee -a "$log"


# O Void Linux utiliza o runit como sistema de init, e o comando sv é responsável por gerenciar serviços.


# Habilite o serviço para iniciar no boot:

# Crie um link simbólico para o serviço:

# sudo rm -Rf /var/service/teamviewerd          | tee -a "$log"

# Ativar o serviço

# sudo ln -sf /etc/sv/teamviewerd /var/service/ | tee -a "$log"



# ----------------------------------------------------------------------------------------

# Log (recomendado): /etc/sv/teamviewerd/log/run


# sudo echo "#!/bin/sh
# /etc/sv/teamviewerd/log/run

# Log supervisionado pelo runit
# exec svlogd -tt /var/log/teamviewerd
# " > /etc/sv/teamviewerd/log/run


# sudo chmod +x /etc/sv/teamviewerd/log/run
# sudo mkdir -p /var/log/teamviewerd
# sudo chown -R root:root /var/log/teamviewerd



# sudo tail -f /var/log/teamviewer*/TeamViewer*_Logfile.log

# ----------------------------------------------------------------------------------------


# Inicie o serviço:

# Para iniciar o serviço imediatamente:

# sudo sv start teamviewerd | tee -a "$log"


# Verificar o status do serviço:

# Para verificar se o serviço foi iniciado corretamente.

# sudo sv status teamviewerd | tee -a "$log"


# ----------------------------------------------------------------------------------------

# Outra forma de iniciar o teamviewerd no Void Linux


# Verifica se a linha contendo /opt/teamviewer/tv_bin/teamviewerd já existe no arquivo /etc/rc.local e, caso não exista, adicione a linha no final do arquivo.


# Caminho do arquivo rc.local

RC_LOCAL="/etc/rc.local"


# Linha a ser verificada e adicionada

# Para inicializar o TeamViewer em segundo plano no Void Linux.

LINE="cd /opt/teamviewer/tv_bin/ && sudo ./teamviewerd &"


# Verifica se o arquivo rc.local existe

if [ ! -f "$RC_LOCAL" ]; then

    echo -e "\nErro: O arquivo $RC_LOCAL não existe. \n"

else

    echo -e "\nO arquivo $RC_LOCAL existe. \n"


    # Remove as linhas que contêm 'teamviewerd'

    sudo sed -i '/teamviewerd/d' "$RC_LOCAL"


    # Verifica se a linha já existe no arquivo rc.local

    if ! grep -Fxq "$LINE" "$RC_LOCAL"; then

        # Se não existe, adiciona a linha no final do arquivo

        # echo "$LINE" >> "$RC_LOCAL"

        echo -e "\nteamviewerd adicionado ao $RC_LOCAL. \n"

    else

        echo -e "\nteamviewerd já existe em $RC_LOCAL. \n"

    fi
fi




# Verifica se o arquivo teamviewerd existe

if [  -f "$LINE" ]; then

sleep 2

echo "
Inicializando o TeamViewer em segundo plano no Void Linux...
" | tee -a "$log"

sudo pkill -f teamviewerd

# Executa o comando armazenado na variável LINE

# eval "$LINE"

# Uso do eval:

# eval "$LINE" faz com que o Bash interprete e execute o conteúdo da variável LINE como 
# um comando. Isso é necessário quando você deseja que o comando armazenado em uma 
# variável seja executado como se fosse digitado diretamente no terminal.

# Execução em Segundo Plano:

# O & no final do comando executa o teamviewerd em segundo plano, permitindo que o 
# script continue sua execução sem esperar que o teamviewerd termine.



# sudo source /etc/rc.local 

sleep 1



echo "
" | tee -a "$log"



# ----------------------------------------------------------------------------------------

# Outra forma de iniciar o teamviewerd no Void Linux

# Para o Void Linux (e outras distribuições baseadas em Linux que usam o sistema de autostart 
# do ambiente gráfico), o processo para adicionar um programa à inicialização gráfica envolve 
# a criação de um arquivo .desktop dentro do diretório /etc/xdg/autostart/.

# Caminho do arquivo teamviewer.desktop

AUTOSTART_DIR="/etc/xdg/autostart"
DESKTOP_FILE="$AUTOSTART_DIR/teamviewer.desktop"

# Verifica se o diretório existe, se não, cria

if [ ! -d "$AUTOSTART_DIR" ]; then

    echo -e "\nDiretório $AUTOSTART_DIR não encontrado. Criando o diretório. \n"

    sudo mkdir -p "$AUTOSTART_DIR"

fi



# ----------------------------------------------------------------------------------------


# Este método foi eficaz para inicializar o teamviewerd no Xfce 4.20.

# Criação do arquivo teamviewer.desktop

sudo rm -Rf /etc/xdg/autostart/teamviewer.desktop | tee -a "$log"

echo "[Desktop Entry]
Type=Application

Name=TeamViewer
Name[be]=TeamViewer
Name[da]=TeamViewer
Name[de]=TeamViewer
Name[el]=TeamViewer
Name[en_GB]=TeamViewer
Name[es]=TeamViewer
Name[et]=TeamViewer
Name[eu]=TeamViewer
Name[fi]=TeamViewer
Name[fr]=TeamViewer
Name[ga]=TeamViewer
Name[he]=TeamViewer
Name[hr]=TeamViewer
Name[hu]=TeamViewer
Name[is]=TeamViewer
Name[it]=TeamViewer
Name[ja]=TeamViewer
Name[ko]=TeamViewer
Name[mr]=TeamViewer
Name[ms]=TeamViewer
Name[nb]=TeamViewer
Name[nl]=TeamViewer
Name[pl]=TeamViewer
Name[pt_BR]=TeamViewer
Name[pt]=TeamViewer
Name[ro]=TeamViewer
Name[ru]=TeamViewer
Name[sk]=TeamViewer
Name[sl]=TeamViewer
Name[sv]=TeamViewer
Name[ta]=TeamViewer
Name[tr]=TeamViewer
Name[uk]=TeamViewer
Name[zh_CN]=TeamViewer
Name[zh_TW]=TeamViewer
Name[oc]=TeamViewer

Comment=Remote control solution.
Comment[ast]=
Comment[be]=
Comment[ca]=
Comment[da]=
Comment[de]=
Comment[el]=
Comment[en_GB]=Remote control solution.
Comment[es]=Solución de control remoto.
Comment[et]=
Comment[eu]=
Comment[fi]=
Comment[fr]=
Comment[ga]=
Comment[he]=
Comment[hr]=
Comment[hu]=
Comment[is]=
Comment[it]=
Comment[ja]=
Comment[ko]=
Comment[lt]=
Comment[nb]=
Comment[nl]=
Comment[pl]=
Comment[pt_BR]=Solução de controle remoto.
Comment[pt]=
Comment[ro]=
Comment[ru]=
Comment[sk]=
Comment[sl]=
Comment[sv]=
Comment[ta]=
Comment[tr]=
Comment[uk]=
Comment[zh_CN]=
Comment[zh_TW]=
Comment[oc]=

Icon=TeamViewer


# Exec=cd /opt/teamviewer/tv_bin/ && sudo ./teamviewerd

Exec=sudo /opt/teamviewer/tv_bin/teamviewerd


Categories=Network;
Terminal=false
X-GNOME-Autostart-enabled=true

"  | sudo tee /etc/xdg/autostart/teamviewer.desktop > /dev/null



# sudo chmod +x /etc/xdg/autostart/teamviewer.desktop


# Confirmação

echo -e "\nArquivo teamviewer.desktop criado em $AUTOSTART_DIR. \n"

sleep 1


# ----------------------------------------------------------------------------------------





fi

# ----------------------------------------------------------------------------------------

# Verifique se o teamviewerd está em execução:

# O teamviewerd é o daemon do TeamViewer, e ele é responsável pela execução do cliente de área de trabalho e pela integração com a área de notificação.

# Para verificar se o daemon está rodando, use o comando:

ps aux | grep teamviewerd | tee -a "$log"


# Se não houver um processo chamado teamviewerd, você pode tentar iniciar o daemon manualmente com:

# teamviewer daemon start



# Com isso, o TeamViewer deve estar configurado corretamente para iniciar automaticamente no boot usando o runit no Void Linux.





# O fato de o ícone do TeamViewer não aparecer na área de notificação do painel do XFCE pode ocorrer por várias razões, 
# incluindo problemas de configuração do próprio TeamViewer, ou do ambiente de área de trabalho XFCE.


#  ps aux | grep teamviewer | grep -v grep
# root     16452  0.1  0.0   2392  1464 ?        Ss   22:17   0:03 runsv teamviewerd
# root     16456  0.3  0.2 1511832 20560 ?       Sl   22:17   0:07 /opt/teamviewer/tv_bin/teamviewerd
# anon     18623  0.3  2.6 2529420 197640 pts/1  Sl+  22:19   0:07 /opt/teamviewer/tv_bin/TeamViewer





# Verifica se o xfce4-panel está em execução

if pgrep -x "xfce4-panel" > /dev/null
then

    echo -e "\nO painel do XFCE está em execução...\n"





sudo xbps-install -Suvy xfce4-notifyd | tee -a "$log"


yad \
--center \
--window-icon="$logo" \
--title="Configuração manual do painel do xfce" \
--text="
Quando o ícone do TeamViewer não fica visível na área de notificação do painel no XFCE, mas o TeamViewer está em execução, 
isso geralmente pode ser causado por problemas de integração do sistema de ícones ou configurações do painel.


Verifique se o <b>plug-in da bandeja de status</b> esta adiciona no painel.

<b>No painel do xfce</b>

Na aba Exbição

Tamanho da linha (pixels): 32

Na aba Aparência

Tamanho de ícone fixo (em pixeis): 16
" \
--buttons-layout=center \
--button="OK:0"  \
--width="900" --height="100" \
2>/dev/null



else

    echo -e "\nO painel do XFCE não está em execução...\n"

fi


    # sudo rm -Rf /etc/apt/sources.list.d/teamviewer.list | tee -a "$log"


    echo -e "\nInstalação do TeamViewer $teamviewer_versao concluída! \n"


else

    # Se o usuário escolher "Não", exibir mensagem e sair

    echo -e "\nInstalação cancelada.\n"

    # exit 1

    /usr/local/bin/facilitador.sh

fi




  # Para verificar se o TeamViewer está instalado.
  
  if which teamviewer &>/dev/null; then

    showMessage "O TeamViewer versão $teamviewer_versao foi instalado com sucesso! \nO atalho está disponível no menu do sistema. \n\nAgora, reinicie a sessão do usuário ou o sistema para concluir a configuração."

  fi


}


# Função para remover o TeamViewer

remover_teamviewer() {

clear

echo -e "\nRemovendo TeamViewer...\n"

sleep 2

sudo xbps-remove -y teamviewer | tee -a "$log"
sudo xbps-remove -Ooy          | tee -a "$log"

# Busca recursiva por "teamviewer"

# sudo grep -rsi "teamviewer" /

# Busca por arquivos de log:

# sudo grep -r "teamviewer" /var/log


# sudo é usado para garantir que o comando tenha permissão para ler arquivos em diretórios restritos.
# -r ativa a busca recursiva, que percorre todos os subdiretórios.
# -i ignora a distinção entre maiúsculas e minúsculas.
# -s suprime mensagens de erro para arquivos que não podem ser lidos devido a permissões. 

# sudo find / -iname "*teamviewer*"


cd $HOME

sudo rm -Rf \
/etc/apt/sources.list.d/ \
/etc/apt/sources.list.d/teamviewer.list \
/etc/teamviewer/ \
/opt/teamviewer/ \
/usr/share/dbus-1/system.d/com.teamviewer.TeamViewer.Daemon.conf \
/var/log/teamviewer* \
/usr/bin/teamviewer \
/usr/share/applications/com.teamviewer.TeamViewer.desktop \
/usr/share/applications/teamviewer*.desktop \
/usr/share/applications/teamviewerapi.desktop \
/usr/share/applications/tvoneweblogin.desktop \
/usr/share/dbus-1/services/com.teamviewer.TeamViewer.Desktop.service \
/usr/share/dbus-1/services/com.teamviewer.TeamViewer.service \
/usr/share/icons/hicolor/16x16/apps/TeamViewer.png \
/usr/share/icons/hicolor/20x20/apps/TeamViewer.png \
/usr/share/icons/hicolor/24x24/apps/TeamViewer.png \
/usr/share/icons/hicolor/256x256/apps/TeamViewer.png \
/usr/share/icons/hicolor/32x32/apps/TeamViewer.png \
/usr/share/icons/hicolor/48x48/apps/TeamViewer.png \
/usr/share/polkit-1/actions/com.teamviewer.TeamViewer.policy \
/etc/sv/teamviewerd  \
/var/log/teamviewerd  \
/usr/share/pixmaps/TeamViewer  \
/var/service/teamviewerd \
/etc/xdg/autostart/teamviewer*.desktop \
.config/teamviewer/ \
.cache/TeamViewer \
.cache/yay/teamviewer/ \
.local/share/teamviewer* \
/root/.local/share/teamviewer* \
| tee -a "$log"


# ----------------------------------------------------------------------------------------


# Remover as linhas que contêm teamviewerd de /etc/rc.local usando o comando sed.


# Caminho do arquivo rc.local

RC_LOCAL="/etc/rc.local"

# Verifica se o arquivo rc.local existe

if [ ! -f "$RC_LOCAL" ]; then

    echo -e "\nErro: O arquivo $RC_LOCAL não existe. \n"

else

    echo -e "\nO arquivo $RC_LOCAL existe. \n"


    # Remove as linhas que contêm 'teamviewerd'

    sudo sed -i '/teamviewerd/d' "$RC_LOCAL"

    # Confirmação

    echo -e "\nLinhas com teamviewerd removidas de $RC_LOCAL.\n" | tee -a "$log"

fi

# ----------------------------------------------------------------------------------------


sudo update-desktop-database | tee -a "$log"


# Verifica se o TeamViewer está instalado

if ! command -v teamviewer &>/dev/null; then

    echo -e "\nO TeamViewer não está instalado. \n"

    yad --center --window-icon="$logo" --title="Sucesso" --text="TeamViewer removido com sucesso!" --buttons-layout=center --button=OK:0 --width="300" 2> /dev/null

fi




}


# Perguntar ao usuário se ele quer instalar ou remover o TeamViewer no Void Linux.


# Caixa de diálogo principal

acao=$(yad \
--center \
--window-icon="$logo" \
--title="TeamViewer no Void Linux" \
--text="O que você deseja fazer com o TeamViewer?" \
--buttons-layout=center \
--button="Instalar:0" --button="Remover:1" \
--width="400" --height="150" \
2> /dev/null)

# Verifica a escolha do usuário

case $? in

    0)
        instalar_teamviewer

        ;;

    1)
        remover_teamviewer

        ;;

    252)
        yad \
        --center \
        --window-icon="$logo" \
        --title="Cancelar" \
        --text="Ação cancelada." \
        --buttons-layout=center \
        --button=OK:0 \
        --width="200"  \
        2> /dev/null

        ;;
esac





fi


# ----------------------------------------------------------------------------------------




  
# ----------------------------------------------------------------------------------------


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


  cp -r /usr/share/applications/anydesk.desktop "$desktop_path/Validadores/" 2>> "$log"

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
  
  echo '#!/bin/bash 
    sudo dpkg -i "'$cache_path'"/dbeaver.deb 
    sudo apt update && sudo apt -f install -y ' > "$cache_path"/exec.sh

  chmod +x "$cache_path"/exec.sh 2>> "$log"

  executar 'pkexec "'$cache_path'"/exec.sh'

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
Type=Application

Name=DBeaver Community
Name[en_US]=DBeaver Community
Name[es]=Comunidad DBeaver
Name[pt_BR]=Comunidade DBeaver

Comment=Universal Database Manager.
Comment[en_US]=Universal Database Manager.
Comment[es]=Administrador de bases de datos universal.
Comment[pt_BR]=Gerenciador de banco de dados universal.

Exec=/opt/dbeaver/dbeaver
Icon=/opt/dbeaver/dbeaver.png
Terminal=false

Categories=Development;

Keywords=dbeaver;
Keywords[en_US]=dbeaver;
Keywords[es_ES]=dbeaver;
Keywords[pt_BR]=dbeaver;banco;dados;

" > /usr/share/applications/dbeaver.desktop


sudo chmod +x /usr/share/applications/dbeaver.desktop


    echo -e "\n✔️ Arquivo $DESKTOP_FILE criado...\n"

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


    sudo ln -sf /lib/jvm/openjdk21/bin/java  /usr/local/bin/ | tee -a "$log"

    java --version | tee -a "$log"

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

# if [ "$acao" = "Calima App" ]; then

  # Verificar se está rodando em Debian ou derivados
  
#   if which apt &>/dev/null; then
  
#   URL_CALIMA_APP=$(curl -L -X GET \
#   -H'Content-Type: application/json' \
#   'https://cloud-api-controller.projetusti.com.br/versao/sistema/get?identificacao=calima-app' \
#  | python3 -c "import sys, json; print(json.load(sys.stdin)['informacaoComplementar'].split(';')[0])")

#   download "$URL_CALIMA_APP" "$cache_path/calima.deb"

#   rm -Rf $HOME/.config/calima-app      2>> "$log"
#   rm -Rf $HOME/.config/calima-app-web  2>> "$log"
  
#   echo '#!/bin/bash 
#     sudo apt purge -y calima-app
#     sudo apt purge -y calima-app-web
#     sudo dpkg -i "'$cache_path'"/calima.deb
#     sudo chmod 755 /usr/share/applications/calima-app-local.desktop
#     sudo apt update && sudo apt -f install -y ' > "$cache_path"/exec.sh

#   chmod +x "$cache_path"/exec.sh 2>> "$log"

#   executar 'pkexec "'$cache_path'"/exec.sh'
  
#   fi
  
#   showMessage "Calima App Local instalado com êxito! \nO atalho encontra-se no menu do sistema."

#   /usr/local/bin/facilitador.sh

# fi

# ----------------------------------------------------------------------------------------

# if [ "$acao" = "" ]; then


  # Verificar se está rodando em Debian ou derivados
  
#   if which apt &>/dev/null; then
  

#   download "" "$cache_path/"
  
#   executar ''
  
#   fi
    
#   showMessage ""

#   /usr/local/bin/facilitador.sh

# fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "IRPF" ]; then

  # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dirpf


  download="https://downloadirpf.receita.fazenda.gov.br/irpf/${ano}/irpf/arquivos/IRPF${ano}Linux-${arch}v1.7.sh.bin" 

  wget -c "$download" -O "$cache_path/irpf.bin" | tee -a "$log"
  
  chmod +x "$cache_path"/irpf.bin 2>> "$log"

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
  
  cp -r /usr/share/applications/IRPF.desktop "$desktop_path/Validadores/" 2>> "$log"

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


# Criando o arquivo .desktop para o Linphone

echo "[Desktop Entry]
Type=Application

Name=Linphone
Name[en_US]=Linphone
Name[es]=Linphone
Name[pt_BR]=Linphone

Comment=
Comment[en_US]=
Comment[es]=
Comment[pt_BR]=

Exec=$atalho_path/linphone.AppImage
Icon=/usr/share/icons/facilitador/linphone.png
Terminal=false

Keywords=linphone;
Keywords[en_US]=linphone;
Keywords[es_ES]=linphone;
Keywords[pt_BR]=linphone;
" > "$atalho_path/linphone.desktop"



  bash "$atalho_path/linphone.sh"

  showMessage "Linphone instalado com êxito! \nO atalho encontra-se no menu do sistema."

  /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------
 
# if [ "$acao" = "" ]; then 


  # Verificar se está rodando em Debian ou derivados
  
#   if which apt &>/dev/null; then
  
#   download "" "$cache_path/"

 
#   executar ''

#   showMessage "Instalação concluída com sucesso!"

#   /usr/local/bin/facilitador.sh 

#   fi


# fi

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

  echo -e "\nNão foi possível obter localização/redirecionamento. \n"

  exit 1

fi

# Extrair a parte que representa a versão (ex: 6.6.0.4410)
# Usamos uma expressão regular para pegar números separados por ponto

zoom_versao=$(echo "$location" | grep -oP '(?<=/prod/)[0-9]+(\.[0-9]+)+' | head -n1)

if [[ -z "$zoom_versao" ]]; then

  echo -e "\nNão foi possível extrair a versão de '$location'. \n"

  zoom_versao="6.6.0.4410"

  # exit 1

fi

# Construir URL final usando versão + arquitetura

zoom_url="https://cdn.zoom.us/prod/${zoom_versao}/zoom_${arch}.tar.xz"

# Mostrar resultados

echo -e "\nVersão do Zoom: $zoom_versao"
echo -e "\nURL de download: $zoom_url \n"


# Versão do Zoom: 6.6.0.4410
# URL de download: https://cdn.zoom.us/prod/6.6.0.4410/zoom_x86_64.tar.xz

# ========================================================================================



  # Verificar se está rodando em Debian ou derivados
  
  if which apt &>/dev/null; then

    # https://zoom.us/client/latest/zoom_amd64.deb

    # deb (for Debian 10.0+)

    download "https://cdn.zoom.us/prod/${zoom_versao}/zoom_amd64.deb" "$cache_path/zoom.deb"

    echo '#!/bin/bash 
      sudo dpkg -i "'$cache_path'"/zoom.deb 
      sudo apt update && sudo apt -f install -y' > "$cache_path"/exec.sh

    chmod +x "$cache_path"/exec.sh 2>> "$log"

    executar 'pkexec "'$cache_path'"/exec.sh'

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


  # Para verificar se o Zoom está instalado via Flatpak.
  
  if flatpak list | grep -q zoom; then

    showMessage "Zoom instalado com êxito! \nO atalho encontra-se no menu do sistema."

  fi

    /usr/local/bin/facilitador.sh

fi

# ----------------------------------------------------------------------------------------


exit 0

