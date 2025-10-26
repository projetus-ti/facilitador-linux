#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 21/10/2025
# Licença:  MIT


clear


# ----------------------------------------------------------------------------------------

# Verifica se o arqivo existe

if [[ ! -e /etc/facilitador.conf ]]; then

    echo -e "\nO arquivo /etc/facilitador.conf não encontrado. \n"
       
    exit 1
fi


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# ----------------------------------------------------------------------------------------

# Verifica se o usuário atual tem privilégios de sudo no sistema:


# Obtém o nome do usuário atual

USUARIO=$(whoami)


echo "Verificando privilégios de sudo para o usuário: $USUARIO"

# Testa se o usuário pode executar sudo sem precisar de senha

if sudo -l &>/dev/null; then

    echo -e "\n✅ O usuário '$USUARIO' tem privilégios de sudo. \n"

else

    echo -e "\n❌ O usuário '$USUARIO' NÃO tem privilégios de sudo. \n"

    yad --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="❌ O usuário '$USUARIO' NÃO tem privilégios de sudo. " \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2> /dev/null
        
    exit 1

fi

# ----------------------------------------------------------------------------------------

# Função para detectar a distribuição



# Função para detectar a distribuição automaticamente

get_distro() {

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif command -v lsb_release >/dev/null 2>&1; then
        lsb_release -si
    else
        echo -e "\nDesconhecida. \n"
    fi
}

# Atribui a variável DISTRO

DISTRO=$(get_distro)



# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet() {

if ! ping -c 1 google.com &>/dev/null; then

    yad --center \
        --window-icon="$logo" \
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


# Podemos usar a opção de mostrar a saída do comando no terminal, mas ainda exibir o progresso 
# no yad. A ideia é capturar a saída do comando e exibir no terminal em tempo real, enquanto o 
# yad continua mostrando a interface de progresso.

executar() {

  # Exibe a saída do comando no terminal enquanto está sendo executado
  # Usando o comando em segundo plano para que a saída seja exibida no terminal

  $1 | tee /dev/tty | yad --center --window-icon="$logo" --title="$titulo" --progress --text="Executando, aguarde..." --pulsate --class=InfinalitySettings --width="500" --no-cancel --buttons-layout=center --button="OK" --auto-close
  
  # Verifica se houve erro no comando

  if [ ${PIPESTATUS[0]} -ne 0 ]; then

    yad --center --window-icon="$logo" --title="$titulo" --text="Erro ao executar o comando!" --button="OK:0" --width="300" --height="100"

    return 1

  fi

}



# ----------------------------------------------------------------------------------------

executarFlatpak() {

  response=$($1) | yad --center --window-icon="$logo" --title="$titulo" --progress --text="Executando a instalação e configuração do Flatpak, aguarde..." --pulsate --class=InfinalitySettings   --width="480" --no-cancel --buttons-layout=center --button="OK"  --auto-close 

  echo $response

}

# ----------------------------------------------------------------------------------------

# Falta verifica o funcionamento

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
 
  yad --center  --window-icon="$logo" --class=InfinalitySettings --title="$titulo - $versao" --progress --auto-close --auto-kill --text="Efetuando o download do arquivo: $1\n\n" --width="500" --buttons-layout=center --button="OK" < $pipe

  if [ "`ps -A |grep "$wget_pid"`" ];then
    kill $wget_pid
  fi

  rm -f $pipe
  rm -Rf $app_path/wget-log*

}

# ----------------------------------------------------------------------------------------


endInstall() {


    chmod -R +x "$desktop_path/Validadores/" 2>> "$log"


    yad --center  --window-icon="$logo" --class=InfinalitySettings --info --icon-name='dialog-warning' --title "Instalação Finalizada!" \
         --text 'Execute o programa pela pasta "Validadores" em sua "Área de Trabalho".' \
         --buttons-layout=center \
         --button="OK" \
         --height="50" --width="500" 2> /dev/null



# ========================================================================================

# Caminho do cache

echo -e "\n$cache_path \n"


ls -lh "$cache_path"


# Pergunta ao usuário se deseja limpar o cache

yad --center \
    --window-icon="$logo" \
    --title="Limpar Downloads" \
    --text="Deseja realmente apagar todos os programas baixados da internet?\n\nIsso irá remover todo o conteúdo de:\n$cache_path" \
    --buttons-layout=center \
    --button=Sim:0 --button=Não:1 \
    --width="400" \
    --height="150" \
    2> /dev/null

# Captura o código de saída do yad

resposta=$?


# Se o usuário clicou em "Sim" (código de saída 0)

if [ "$resposta" -eq 0 ]; then

    rm -Rf "$cache_path"/*

    yad --center \
        --window-icon="$logo" \
        --title="Limpeza concluída" \
        --text="Os programas foram apagados com sucesso." \
        --buttons-layout=center \
        --button=OK:0 \
        --width="300" \
        --height="100" \
        2> /dev/null

else

    yad --center \
        --window-icon="$logo" \
        --title="Cancelado" \
        --text="A limpeza foi cancelada." \
        --buttons-layout=center \
        --button=OK:0 \
        --width="300" \
        --height="100" \
        2> /dev/null
fi

# ========================================================================================


  
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

  if [ ! -f $HOME/.wine/user.reg ]; then
    wineboot >/dev/null 2>&1
    while [[ ! -f $HOME/.wine/user.reg ]]; do
      sleep 1
    done
  fi

  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" $HOME/.wine/user.reg
  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" $HOME/.wine/drive_c/windows/win.ini

  clear
}

# ----------------------------------------------------------------------------------------

# Funcao de ajuste no wine32

configurarWine32() {

  clear

  echo -e "\nConfigurando o Wine... \n"

  if [ ! -f $HOME/.wine32/user.reg ]; then
    env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wineboot >/dev/null 2>&1
    while [[ ! -f $HOME/.wine32/user.reg ]]; do
      sleep 1
    done
  fi

  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" $HOME/.wine32/user.reg
  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" $HOME/.wine32/drive_c/windows/win.ini

  clear
}

# ----------------------------------------------------------------------------------------

# Funcao de descontinuação de programa.

descontinuado() {

  yad \
  --center \
  --class=InfinalitySettings \
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

# Para reiniciar o painel com base no ambiente de desktop

reiniciar_painel() {



# Verifica qual o ambiente de desktop ativo

DESKTOP_ENV=$(echo $XDG_SESSION_DESKTOP)

case $DESKTOP_ENV in
  xfce)
    echo -e "\nReiniciando o painel do XFCE... \n"

    # killall -9 xfce4-panel ; xfce4-panel &

    xfce4-panel --restart
    ;;
  gnome)
    echo -e "\nReiniciando o painel do GNOME... \n"
    gnome-shell --replace &
    ;;
  kde)
    echo -e "\nReiniciando o painel do KDE... \n"
    killall plasmashell && kstart5 plasmashell
    ;;
  cinnamon)
    echo -e "\nReiniciando o painel do Cinnamon... \n"
    cinnamon --replace &
    ;;
  mate)
    echo -e "\nReiniciando o painel do MATE... \n"
    mate-panel --replace &
    ;;
  openbox)
    echo -e "\nOpenbox não tem painel, mas você pode reiniciar a barra de tarefas. \n"
    killall tint2 && tint2 &
    ;;
  fluxbox)
    echo -e "\nFluxbox não tem painel, mas você pode reiniciar o painel com o comando fbpanel. \n"
    killall fbpanel && fbpanel &
    ;;
  i3)
    echo -e "\nReiniciando o painel do i3 (i3bar)... \n"
    killall i3bar && i3bar &
    ;;
  bspwm)
    echo -e "\nReiniciando o painel do BSPWM (com i3bar ou outro utilitário de barra). \n"
    killall i3bar && i3bar &
    ;;
  *)
    echo -e "\nAmbiente de desktop ou gerenciador de janelas desconhecido ou não suportado. \n"
    ;;
esac



}

# ----------------------------------------------------------------------------------------


