#!/bin/bash
# Setar a versao do script
versao="4.5.7"

# Setar outras variaveis
export WINEDEBUG=-all
#wine_32=env WINEARCH=win32 WINEPREFIX=$HOME/.wine32
desktop_path=$(xdg-user-dir DESKTOP)
user_path=$(xdg-user-dir USER)
app_path="/opt/projetus/facilitador"
cache_path="$app_path/cache"
atalho_path="/opt/projetus/facilitador/atalhos"

setWinePrefix() {
  wine=env WINEARCH="$1" WINEPREFIX=$HOME/."$2"
}
 

executar() {
  response=$($1) | zenity --progress --text="Executando, aguarde..." --pulsate --class=InfinalitySettings --window-icon=/opt/projetus/facilitador/icon.png  --width="280" --no-cancel --auto-close --title="Facilitador Linux"
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
 
  zenity --class=InfinalitySettings --progress --auto-close --auto-kill --text="Efetuando o download do arquivo: $1\n\n" --width="500" --window-icon=/opt/projetus/facilitador/icon.png --title="Facilitador Linux - $versao"< $pipe
  if [ "`ps -A |grep "$wget_pid"`" ];then
    kill $wget_pid
  fi
  rm -f $pipe
  rm -Rf $app_path/wget-log*
}

endInstall() {
    zenity --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon=/opt/projetus/facilitador/icon.png --title "Instalação Finalizada!" \
         --text 'Execute o programa pela pasta "Validadores" em sua "Área de Trabalho".' \
         --height="50" --width="450"

  chmod -R +x "$desktop_path/Validadores/"
  rm -Rf $cache_path/*
  
  if [ $DESKTOP_SESSION = "plasma" ]; then
    find "$desktop_path/Validadores/" -type f -name '*.desktop' | while read f; do mv "$f" "${f%.desktop}"; done
  fi
  
  zenity --notification --text="Facilitador Linux - Instalação finalizada com sucecsso!"
  exec $app_path/facilitador.sh
}

showMessage() {
  zenity --notification --text="Facilitador Linux - $1"
}

# Funcao de ajuste no wine
configurarWine() {
  clear
  echo 'Configurando o Wine...'
  if [ ! -f ~/.wine/user.reg ]; then
    nohup wineboot >/dev/null 2>&1
    while [[ ! -f ~/.wine/user..wine/user.reg ]]; do
      sleep 1
    done
  fi

  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine/user.reg
  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" ~/.wine/drive_c/windows/win.ini
  clear
}

