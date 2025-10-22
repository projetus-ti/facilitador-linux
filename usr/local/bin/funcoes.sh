#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 21/10/2025
# Licença:  MIT


clear

# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# ----------------------------------------------------------------------------------------

# Função para detectar a distribuição

detectar_distro() {

    if [ -f /etc/os-release ]; then
        . /etc/os-release

        echo -e "\n$ID \n"

    elif [ -f /etc/slackware-version ]; then

        echo -e "\nslackware \n"

    elif command -v xbps-install >/dev/null 2>&1; then

        echo -e "\nvoid \n"

    else

        echo -e "\nDesconhecida. \n"

    fi

}


# Detecta a distribuição
DISTRO=$(detectar_distro)

echo -e "\n🧩 Distribuição detectada: $DISTRO \n"


# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet() {

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

}

# ----------------------------------------------------------------------------------------


setWinePrefix() {

  wine=env WINEARCH="$1" WINEPREFIX=$HOME/."$2"

}

# ----------------------------------------------------------------------------------------

executar() {

  response=$($1) | yad --center --window-icon="$logo"  --title="$titulo" --progress --text="Executando, aguarde..." --pulsate --class=InfinalitySettings  --width="280" --no-cancel  --buttons-layout=center --button="OK"  --auto-close 

  echo $response

}

# ----------------------------------------------------------------------------------------

executarFlatpak() {

  response=$($1) | yad --center --window-icon="$logo" --title="$titulo" --progress --text="Executando a instação e configuração do Flatpak, aguarde..." --pulsate --class=InfinalitySettings   --width="480" --no-cancel --buttons-layout=center --button="OK"  --auto-close 

  echo $response

}

# ----------------------------------------------------------------------------------------

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

      echo -e "\n#Baixando: $1\n\n$current de $total_size ($percent%)\n\nTempo estimado: $remain \n"

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

# ----------------------------------------------------------------------------------------


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

  /usr/local/bin/facilitador.sh

}

# ----------------------------------------------------------------------------------------

showMessage() {

  notify-send -i "$logo" -t $tempo_notificacao "$titulo" "$1"

}

# ----------------------------------------------------------------------------------------

# Funcao de ajuste no wine

configurarWine() {

  clear

  echo -e "\nConfigurando o Wine... \n"

  if [ ! -f ~/.wine/user.reg ]; then
    wineboot >/dev/null 2>&1
    while [[ ! -f ~/.wine/user.reg ]]; do
      sleep 1
    done
  fi

  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine/user.reg
  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine/drive_c/windows/win.ini

  clear
}

# ----------------------------------------------------------------------------------------

# Funcao de ajuste no wine32

configurarWine32() {

  clear

  echo -e "\nConfigurando o Wine... \n"

  if [ ! -f ~/.wine32/user.reg ]; then
    env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wineboot >/dev/null 2>&1
    while [[ ! -f ~/.wine32/user.reg ]]; do
      sleep 1
    done
  fi

  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine32/user.reg
  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine32/drive_c/windows/win.ini

  clear
}

# ----------------------------------------------------------------------------------------

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

# ----------------------------------------------------------------------------------------

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

# ----------------------------------------------------------------------------------------

exit 0

