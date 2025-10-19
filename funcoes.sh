#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Setar a versao do script

versao="4.7.1"

# Setar outras variaveis
export WINEDEBUG=-all
desktop_path=$(xdg-user-dir DESKTOP)
user_path=$(xdg-user-dir USER)
app_path="/opt/projetus/facilitador"
cache_path="$app_path/cache"
atalho_path="/opt/projetus/facilitador/atalhos"


# Mostra aviso sobre backup do sistema

yad --center --title="Aviso Importante" \
    --width=400 --height=150 \
    --text="⚠️ <b>Recomendação:</b>\n\nAntes de executar este script, é altamente recomendável criar uma <b>imagem de backup do sistema</b>.\n\nDeseja continuar mesmo assim?" \
    --button=Não:1 --button=Sim:0
    
# Verifica a resposta do usuário
if [[ $? -ne 0 ]]; then
    yad --center --title="Cancelado" --text="Execução cancelada pelo usuário." --button=OK  --width=300
    exit 1
fi


# Verifica se o diretório existe
if [[ ! -d /opt/projetus/ ]]; then

    echo -e "\nDiretório /opt/projetus/ não encontrado. \n"

        yad --center --title="Erro" \
        --text="Diretório /opt/projetus/ não encontrado." \
        --button=OK \
        --width=300 --height=100
        
    exit 1
fi

# Testa conectividade com a internet

if ! ping -c 1 google.com &>/dev/null; then

    yad --center --title="Erro de Conexão" \
        --text="Sem acesso à internet.\nVerifique sua conexão de rede." \
        --button=OK \
        --width=300 --height=100
        
    exit 1
fi


# Verifica se o Java está instalado

if ! java --version &>/dev/null; then
    # Exibe mensagem de erro com YAD
    yad --center --title="Erro: Java não encontrado" \
        --text="O Java não está instalado no sistema.\nPor favor, instale o Java para continuar." \
        --button=OK \
        --width=300 --height=100
    exit 1
fi


setWinePrefix() {
  wine=env WINEARCH="$1" WINEPREFIX=$HOME/."$2"
}
 

executar() {
  response=$($1) | yad --center --progress --text="Executando, aguarde..." --pulsate --class=InfinalitySettings --window-icon=/opt/projetus/facilitador/icon.png  --width="280" --no-cancel --auto-close --title="Facilitador Linux"
  echo $response
}

executarFlatpak() {
  response=$($1) | yad --center --progress --text="Executando a instação e configuração do Flatpak, aguarde..." --pulsate --class=InfinalitySettings --window-icon=/opt/projetus/facilitador/icon.png  --width="380" --no-cancel --auto-close --title="Facilitador Linux"
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
 
  yad --center --class=InfinalitySettings --progress --auto-close --auto-kill --text="Efetuando o download do arquivo: $1\n\n" --width="500" --window-icon=/opt/projetus/facilitador/icon.png --title="Facilitador Linux - $versao"< $pipe
  if [ "`ps -A |grep "$wget_pid"`" ];then
    kill $wget_pid
  fi
  rm -f $pipe
  rm -Rf $app_path/wget-log*
}

endInstall() {
    yad --center --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon=/opt/projetus/facilitador/icon.png --title "Instalação Finalizada!" \
         --text 'Execute o programa pela pasta "Validadores" em sua "Área de Trabalho".' \
         --height="50" --width="450"

  chmod -R +x "$desktop_path/Validadores/"
  rm -Rf $cache_path/*
  
  if [ $DESKTOP_SESSION = "plasma" ]; then
    find "$desktop_path/Validadores/" -type f -name '*.desktop' | while read f; do mv "$f" "${f%.desktop}"; done
  fi
  
  yad --center --notification --text="Facilitador Linux - Instalação finalizada com sucecsso!"
  exec $app_path/facilitador.sh
}

showMessage() {
  yad --center --notification --text="Facilitador Linux - $1"
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
  yad --center --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon=/opt/projetus/facilitador/icon.png --title "Programa Descontinuado!" \
         --text 'Esse validador foi descontinuado.' \
         --height="50" --width="250"
}

# Validador não Configurado.
naoCompativel() {
  yad --center --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon=/opt/projetus/facilitador/icon.png --title "Programa não executavel!" \
         --text 'Este validador não é possível usar no linux. Use a maquina virtual.' \
         --height="50" --width="450"
}
