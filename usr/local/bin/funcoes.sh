#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT
# Setar a versao do script

clear

versao="4.7.2"


# Setar outras variaveis

export WINEDEBUG=-all
desktop_path=$(xdg-user-dir DESKTOP)
user_path=$(xdg-user-dir USER)
app_path="/opt/projetus/facilitador"
cache_path="$app_path/cache"
atalho_path="/opt/projetus/facilitador/atalhos"

titulo="Facilitador Linux"

# Ícone da notificação e do yad (alterar se necessário)

logo="/usr/share/icons/facilitador/icon.png"


# Tempo que a notificação ficará visível (em milissegundos)

tempo_notificacao="20000"  # 20000 ms = 20 segundos - Definir o tempo da notificação


# ----------------------------------------------------------------------------------------

# Uso de cores para destacar

RED='\033[1;31m'
GREEN='\033[1;32m'

# Código ANSI para amarelo em negrito
YELLOW='\033[1;33m'

RESET='\033[0m'


# ----------------------------------------------------------------------------------------

# Verifica se os comandos necessários estão disponíveis

for cmd in find sed  curl git ping wget sudo flatpak pkexec tar unzip notify-send ; do

    if ! command -v "$cmd" > /dev/null 2>&1; then


        message=$(gettext "Erro: %s não está instalado.")

        # Formatar a mensagem com a variável $message substituindo o %s

        message=$(printf "$message" "$cmd")


        echo -e "\n${RED}$message ${RESET}\n"

        yad --center --window-icon="$logo" --title="$titulo" --text="$message" --buttons-layout=center --button=OK:0 2> /dev/null

        exit 1

    fi

done

# ----------------------------------------------------------------------------------------



# Função para detectar a distribuição

detectar_distro() {

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"

    elif [ -f /etc/slackware-version ]; then
        echo "slackware"

    elif command -v xbps-install >/dev/null 2>&1; then
        echo "void"

    else
        echo "desconhecida"
    fi

}


# Detecta a distribuição
DISTRO=$(detectar_distro)

echo "🧩 Distribuição detectada: $DISTRO"



# Verificar se o Java já está instalado

if command -v java >/dev/null 2>&1; then

    echo "✅ Java já está instalado:"

    java -version
    
else

    echo "⚠️ Java não está instalado. Instalando..."

    # Instalar o Java

    # download "http://download.projetusti.com.br/suporte/jre-tomcat-linux/jre-7u79-linux-i586.tar.gz" "$app_path/java.tar.gz"
    # cd $app_path
    # tar -vzxf java.tar.gz
    # mv jre1.7.0_79/ java


# Instala Java com base na distribuição

case "$DISTRO" in
    ubuntu|debian|linuxmint)
        echo "📦 Usando apt para instalar OpenJDK"
        sudo apt update
        sudo apt install -y default-jre
        ;;
    fedora)
        echo "📦 Usando dnf para instalar OpenJDK"
        sudo dnf install -y java-17-openjdk
        ;;
    centos|rhel)
        echo "📦 Usando yum para instalar OpenJDK"
        sudo yum install -y java-17-openjdk
        ;;
    arch|manjaro)
        echo "📦 Usando pacman para instalar OpenJDK"
        sudo pacman -S --noconfirm jre-openjdk
        ;;
    opensuse*|suse)
        echo "📦 Usando zypper para instalar OpenJDK"
        sudo zypper install -y java-17-openjdk
        ;;
    void)
        echo "📦 Usando xbps para instalar OpenJDK (Void Linux)"
        sudo xbps-install -Sy openjdk17-jre
        ;;
    slackware)
        echo "📦 Slackware detectado."
        if command -v slackpkg >/dev/null 2>&1; then
            echo "📦 Instalando via slackpkg"
            sudo slackpkg update gpg
            sudo slackpkg update
            sudo slackpkg install openjdk
        else
            echo "❌ slackpkg não encontrado. Instale manualmente ou configure o sbopkg."
            # exit 1
        fi
        ;;
    *)
        echo "❌ Distribuição não reconhecida ou não suportada automaticamente."
        echo "Por favor, instale o Java manualmente."
        # exit 1
        ;;
esac




# Verifica novamente após instalação

if command -v java >/dev/null 2>&1; then
    echo "✅ Java instalado com sucesso:"
    java -version
else
    echo "❌ Falha na instalação do Java."
    # exit 1
fi



fi



# Verificar se o wine já está instalado

if command -v wine >/dev/null 2>&1; then

    echo "✅ Wine já está instalado:"

    # Mostra a versão instalada do Wine no seu sistema.

    wine --version

    
else

# Instala o Wine com base na distribuição

case "$DISTRO" in
    ubuntu|debian|linuxmint)
        echo "📦 Usando apt para instalar o Wine"
        sudo apt update
        sudo apt install -y wine
        ;;
    fedora)
        echo "📦 Usando dnf para instalar o Wine"
        sudo dnf install -y wine
        ;;
    centos|rhel)
        echo "📦 Usando yum para instalar o Wine"
        sudo yum install -y wine
        ;;
    arch|manjaro)
        echo "📦 Usando pacman para instalar o Wine"
        sudo pacman -S --noconfirm wine
        ;;
    opensuse*|suse)
        echo "📦 Usando zypper para instalar o Wine"
        sudo zypper install -y wine
        ;;
    void)
        echo "📦 Usando xbps para instalar o Wine (Void Linux)"
        sudo xbps-install -Sy wine
        ;;
    slackware)
        echo "📦 Slackware detectado."
        if command -v slackpkg >/dev/null 2>&1; then
            echo "📦 Instalando via slackpkg"
            sudo slackpkg update gpg
            sudo slackpkg update
            sudo slackpkg install wine
        else
            echo "❌ slackpkg não encontrado. Instale manualmente ou configure o sbopkg."
            # exit 1
        fi
        ;;
    *)
        echo "❌ Distribuição não reconhecida ou não suportada automaticamente."
        echo "Por favor, instale o Wine manualmente."
        # exit 1
        ;;
esac


fi


# Mostra aviso sobre backup do sistema

yad --center \
    --title="Aviso Importante" \
    --text="⚠️ <b>Recomendação:</b>\n\nAntes de executar este script, é altamente recomendável criar uma <b>imagem de backup do sistema</b>.\n\nDeseja continuar mesmo assim?" \
    --buttons-layout=center \
    --button=Não:1 --button=Sim:0 \
    --width="400" --height="150" \
    2> /dev/null

 
# Verifica a resposta do usuário

if [[ $? -ne 0 ]]; then

    yad --center --title="Cancelado" --text="Execução cancelada pelo usuário." --buttons-layout=center --button="OK"  --width="300" 2> /dev/null

    exit 1
fi


# Verifica se o diretório existe

if [[ ! -d /opt/projetus/ ]]; then

    echo -e "\nDiretório /opt/projetus/ não encontrado. \n"

        yad \
        --center \
        --title="Erro" \
        --text="Diretório /opt/projetus/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2> /dev/null
        
    exit 1
fi

# Testa conectividade com a internet

if ! ping -c 1 google.com &>/dev/null; then

    yad --center \
        --title="Erro de Conexão" \
        --text="Sem acesso à internet.\nVerifique sua conexão de rede." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2> /dev/null
        
    exit 1
fi


# Verifica se o Java está instalado

if ! java --version &>/dev/null; then

    # Exibe mensagem de erro com YAD

    yad \
        --center \
        --title="Erro: Java não encontrado" \
        --text="O Java não está instalado no sistema.\nPor favor, instale o Java para continuar." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2> /dev/null

    exit 1
fi


setWinePrefix() {
  wine=env WINEARCH="$1" WINEPREFIX=$HOME/."$2"
}
 

executar() {
  response=$($1) | yad --center --window-icon="$logo"  --title="$titulo" --progress --text="Executando, aguarde..." --pulsate --class=InfinalitySettings  --width="280" --no-cancel  --buttons-layout=center --button="OK"  --auto-close 

  echo $response

}

executarFlatpak() {
  response=$($1) | yad --center --window-icon="$logo" --title="$titulo" --progress --text="Executando a instação e configuração do Flatpak, aguarde..." --pulsate --class=InfinalitySettings   --width="480" --no-cancel --buttons-layout=center --button="OK"  --auto-close 

  echo $response

}

download() {
  cd $app_path
  rm -Rf $2
  rand="$RANDOM `date`"
  pipe="/tmp/pipe.`echo '$rand' | md5sum | tr -d ' -'`"
  mkfifo $pipe
  wget -c $1 --no-check-certificate -O $2 2>&1 | while read data;do
    if [ "`echo $data | grep '^Tamanho:'`" ]; then
      total_size=`echo $data | grep "^Tamanho:" | sed 's/.*\((.*)\).*/\1/' |  tr -d '()'`
    fi
    if  [ "`echo $data | grep '^Length:'`" ]; then
      total_size=`echo $data | grep "^Length:" | sed 's/.*\((.*)\).*/\1/' |  tr -d '()'`
    fi

    if [ "`echo $data | grep '[0-9]*%' `" ];then
      percent=`echo $data | grep -o "[0-9]*%" | tr -d '%'`
      current=`echo $data | grep "[0-9]*%" | sed 's/\([0-9BKMG.]\+\).*/\1/' `
      speed=`echo $data | grep "[0-9]*%" | sed 's/.*\(% [0-9BKMG.]\+\).*/\1/' | tr -d ' %'`
      remain=`echo $data | grep -o "[0-9A-Za-z]*$" `
      echo $percent
      echo "#Baixando: $1\n\n$current de $total_size ($percent%)\n\nTempo estimado: $remain"
    fi
  done > $pipe &
 
  wget_info=`ps ax |grep "wget.*$1" |awk '{print $1"|"$2}'`
  wget_pid=`echo $wget_info|cut -d'|' -f1 `
 
  yad --center --class=InfinalitySettings --progress --auto-close --auto-kill --text="Efetuando o download do arquivo: $1\n\n" --width="500" --window-icon="$logo" --title="$titulo - $versao"< $pipe

  if [ "`ps -A |grep "$wget_pid"`" ];then
    kill $wget_pid
  fi

  rm -f $pipe
  rm -Rf $app_path/wget-log*
}

endInstall() {
    yad --center --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon="$logo" --title "Instalação Finalizada!" \
         --text 'Execute o programa pela pasta "Validadores" em sua "Área de Trabalho".' \
         --buttons-layout=center \
         --button="OK" \
         --height="50" --width="500" 2> /dev/null

  chmod -R +x "$desktop_path/Validadores/"
  rm -Rf $cache_path/*
  
  if [ $DESKTOP_SESSION = "plasma" ]; then
    find "$desktop_path/Validadores/" -type f -name '*.desktop' | while read f; do mv "$f" "${f%.desktop}"; done
  fi
  
  # yad --center --notification --text="$titulo - Instalação finalizada com sucecsso!" 2> /dev/null

  notify-send -i "$logo" -t $tempo_notificacao "$titulo" "Instalação finalizada com sucecsso!"

  exec $app_path/facilitador.sh

}

showMessage() {

  # yad --center --notification --text="$titulo - $1" 2> /dev/null

  notify-send -i "$logo" -t $tempo_notificacao "$titulo" "$1"

}


# Funcao de ajuste no wine

configurarWine() {
  clear
  echo 'Configurando o Wine...'
  if [ ! -f ~/.wine/user.reg ]; then
    nohup wineboot >/dev/null 2>&1
    while [[ ! -f ~/.wine/user.reg ]]; do
      sleep 1
    done
  fi

  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine/user.reg
  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine/drive_c/windows/win.ini

  clear
}

# Funcao de ajuste no wine32

configurarWine32() {
  clear
  echo 'Configurando o Wine...'
  if [ ! -f ~/.wine32/user.reg ]; then
    nohup env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wineboot >/dev/null 2>&1
    while [[ ! -f ~/.wine32/user.reg ]]; do
      sleep 1
    done
  fi

  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine32/user.reg
  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine32/drive_c/windows/win.ini

  clear
}

# Funcao de descontinuação de programa.

descontinuado() {

  yad \
  --center --class=InfinalitySettings \
  --info \
  --icon-name='dialog-warning' \
  --window-icon="$logo" \
  --title "Programa Descontinuado!" \
  --text 'Esse validador foi descontinuado.' \
  --buttons-layout=center \
  --button="OK" \
  --width="350" --height="100" \
  2>/dev/null

}

# Validador não Configurado.

naoCompativel() {

  yad \
  --center \
  --class=InfinalitySettings \
  --info \
  --icon-name='dialog-warning' \
  --window-icon="$logo" \
  --title "Programa não executavel!" \
  --text 'Este validador não é possível usar no linux. Use a maquina virtual.' \
  --buttons-layout=center \
  --button="OK" \
  --width="550" --height="100" \
  2>/dev/null

}


exit 0

