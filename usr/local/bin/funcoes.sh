#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 21/10/2025
# Licença:  MIT


# Falta verificar as funções:

# São scripts para preparar e ajustar o ambiente Wine no Linux

# configurarWine32
# configurarWine
# setWinePrefix



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

# Função setWinePrefix()


# 🔍 Explicando:

# Essa função define uma variável de ambiente (wine) com a configuração correta do prefixo 
# e arquitetura.

# Por exemplo:

# setWinePrefix win32 wine32

# Vai criar a variável:

# wine="env WINEARCH=win32 WINEPREFIX=$HOME/.wine32"

# Ou seja, depois você pode usar o Wine apontando para esse prefixo específico com:

# $wine winecfg


# ✅ Em resumo:

# Essa função configura qual ambiente Wine será usado (32 bits ou 64 bits), apontando para 
# o prefixo correto.


# 🧠 Em conjunto, o que tudo isso faz?

# Essas três funções (configurarWine32(), configurarWine(), e setWinePrefix()) são usadas 
# em scripts que precisam configurar ou executar programas via Wine.

# Elas garantem que:

# O prefixo Wine (32 ou 64 bits) existe antes de rodar qualquer app;

# O formato de data do “Windows virtual” está correto (Brasil: dd/MM/yyyy);

# Você pode alternar entre Wine 32 e 64 bits facilmente.


# 💡 Exemplo prático de uso


# Configura Wine 32 bits, se necessário
# configurarWine32

# Define o prefixo 32 bits como ativo
# setWinePrefix win32 wine32

# Roda o programa dentro desse prefixo
# $wine wine "C:\\Program Files\\MeuPrograma\\meuapp.exe"


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

# Funcionamento anterior

# O "arquivo não baixa com o tamanho correto" normalmente acontece porque o 
# wget está sendo executado dentro de um pipe, e isso interfere na forma como ele escreve 
# os dados — o while read data dentro do | faz com que o wget rode em um subshell, e o 
# processo pode ser morto prematuramente quando o loop termina.

# -rw-r--r-- 1 master master 262K out 29 03:32 /home/master/validacd-1.exe
# -rw-r--r-- 1 master master 535K out 29 03:30 /home/master/validacd-1-original.exe


# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sva/validacd-1.exe/view


# Depois da alteração:

# -rw-r--r-- 1 master master 535K out 29 03:36 /home/master/validacd-1.exe
# -rw-r--r-- 1 master master 535K out 29 03:30 /home/master/validacd-1-original.exe


# Testar em outros arquivos com download grande.


# ✅ Essa versão:

# não mata o wget antes da hora;

# usa wait para garantir que o download termine;

# mantém a compatibilidade com o yad.


download_funcional() {

  cd "$app_path" || exit 1

  rm -f "$2"
  pipe="/tmp/pipe.$$"
  mkfifo "$pipe"

  # Inicia o wget em background e captura PID

  wget -c "$1" --no-check-certificate -O "$2" >"$pipe" 2>&1 &

  wget_pid=$!

  # Exibe progresso com YAD
  (
    total=""
    while read -r line; do
      if [[ "$line" =~ ([0-9]+)% ]]; then
        percent="${BASH_REMATCH[1]}"
        echo "$percent"
      fi
    done < "$pipe"
  ) | yad --center  --window-icon="$logo" --progress --auto-close --auto-kill --width=500 --title="Baixando $2" --text="Efetuando o download..." --percentage=0

  wait "$wget_pid"
  rm -f "$pipe"

}



# Manter o yad para exibir o progresso e o status (tamanho, porcentagem, velocidade etc.), mas sem truncar o download.

# Mantendo aparência original

# -rw-r--r-- 1 master master 535K out 29 03:52 /home/master/validacd-1.exe
# -rw-r--r-- 1 master master 535K out 29 03:30 /home/master/validacd-1-original.exe


download_OK() {

  cd "$app_path" || exit 1

  rm -f "$2"

  rand="$RANDOM $(date)"
  pipe="/tmp/pipe.$(echo "$rand" | md5sum | tr -d ' -')"
  mkfifo "$pipe"

  log="/tmp/wget-log.$$.txt"
  rm -f "$log"

  # Inicia o wget em background, redirecionando o log

  wget -c "$1" --no-check-certificate -O "$2" >"$log" 2>&1 &

  wget_pid=$!

  # Lê o log em tempo real e envia ao YAD (sem interferir no wget)
  tail -f "$log" | while read -r data; do
    if echo "$data" | grep -q '^Tamanho:'; then
      total_size=$(echo "$data" | grep "^Tamanho:" | sed 's/.*(\(.*\)).*/\1/' | tr -d '()')
    fi
    if echo "$data" | grep -q '^Length:'; then
      total_size=$(echo "$data" | grep "^Length:" | sed 's/.*(\(.*\)).*/\1/' | tr -d '()')
    fi

    if echo "$data" | grep -q '[0-9]*%'; then
      percent=$(echo "$data" | grep -o "[0-9]*%" | tr -d '%')
      current=$(echo "$data" | grep "[0-9]*%" | sed 's/\([0-9BKMG.]\+\).*/\1/')
      speed=$(echo "$data" | grep "[0-9]*%" | sed 's/.*\(% [0-9BKMG.]\+\).*/\1/' | tr -d ' %')
      remain=$(echo "$data" | grep -o "[0-9A-Za-z]*$")
      echo "$percent"
      echo -e "\n#Baixando: $1\n\n$current de $total_size ($percent%)\n\nTempo estimado: $remain\n"
    fi
  done > "$pipe" &
  tail_pid=$!

  # Exibe barra de progresso com YAD

  yad --center \
      --window-icon="$logo" \
      --class=InfinalitySettings \
      --title="$titulo - $versao" \
      --progress \
      --auto-close \
      --auto-kill \
      --width="500" \
      --buttons-layout=center \
      --button="OK" \
      --text="Efetuando o download do arquivo: $1\n\n" \
      < "$pipe"

  # Aguarda wget terminar completamente
  wait "$wget_pid"

  # Limpeza
  kill "$tail_pid" 2>/dev/null
  rm -f "$pipe" "$log" "$app_path"/wget-log*

}



# 🔍 O que faz esta versão

# ✅ Mantém o mesmo estilo e progresso do seu script original.
# ✅ Corrige o problema do arquivo incompleto (agora baixa 100%).
# ✅ Exibe um alerta de "Download concluído" com o tamanho final do arquivo.
# ✅ Se algo der errado, exibe uma mensagem de erro no YAD.
# ✅ Limpa tudo (pipe, log, wget-log*) ao final.


download() {

  cd "$app_path" || exit 1

  rm -f "$2"

  rand="$RANDOM $(date)"
  pipe="/tmp/pipe.$(echo "$rand" | md5sum | tr -d ' -')"
  mkfifo "$pipe"

  log="/tmp/wget-log.$$.txt"
  rm -f "$log"

  # Inicia o wget em background, salvando o log em arquivo

  wget -c "$1" --no-check-certificate -O "$2" >"$log" 2>&1 &

  wget_pid=$!

  # Lê o progresso do log e envia para o YAD

  tail -f "$log" | while read -r data; do
    if echo "$data" | grep -q '^Tamanho:'; then
      total_size=$(echo "$data" | grep "^Tamanho:" | sed 's/.*(\(.*\)).*/\1/' | tr -d '()')
    fi
    if echo "$data" | grep -q '^Length:'; then
      total_size=$(echo "$data" | grep "^Length:" | sed 's/.*(\(.*\)).*/\1/' | tr -d '()')
    fi

    if echo "$data" | grep -q '[0-9]*%'; then
      percent=$(echo "$data" | grep -o "[0-9]*%" | tr -d '%')
      current=$(echo "$data" | grep "[0-9]*%" | sed 's/\([0-9BKMG.]\+\).*/\1/')
      speed=$(echo "$data" | grep "[0-9]*%" | sed 's/.*\(% [0-9BKMG.]\+\).*/\1/' | tr -d ' %')
      remain=$(echo "$data" | grep -o "[0-9A-Za-z]*$")
      echo "$percent"

      echo -e "\n#Baixando: $1\n\n$current de $total_size ($percent%)\n\nTempo estimado: $remain\n"
    fi
  done > "$pipe" &

  tail_pid=$!

  # Mostra a janela de progresso

  yad --center \
      --window-icon="$logo" \
      --class=InfinalitySettings \
      --title="$titulo - $versao" \
      --progress \
      --auto-close \
      --auto-kill \
      --buttons-layout=center \
      --button="OK" \
      --text="Efetuando o download do arquivo: $1\n\n" \
      --width="500" \
      < "$pipe"

  # Aguarda o wget terminar

  wait "$wget_pid"

  # Mata o tail e limpa arquivos temporários

  kill "$tail_pid" 2>/dev/null
  rm -f "$pipe" "$log" "$app_path"/wget-log* 2>/dev/null

  # Verifica o resultado final

  if [ -f "$2" ]; then

    file_size=$(du -h "$2" | awk '{print $1}')

    ls -lh "$2"


    # Após 10 segundos, fecha automaticamente.

    # O usuário ainda pode clicar em OK antes se quiser.

    yad --center \
        --window-icon="$logo" \
        --info \
        --timeout="10" \
        --title="Download concluído" \
        --text="✅ O arquivo foi baixado com sucesso!\n\n<b>Arquivo:</b> $2\n<b>Tamanho:</b> $file_size" \
        --buttons-layout=center \
        --button="OK" \
        --width="400" \
        2>/dev/null

  else

    yad --center \
        --error \
        --timeout="10" \
        --title="Erro no download" \
        --text="❌ O download falhou.\n\nVerifique sua conexão ou tente novamente." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" \
        2>/dev/null
  fi

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

    yad \
    --center \
    --window-icon="$logo" \
    --title="Limpar Downloads" \
    --text="Deseja realmente apagar todos os programas baixados da internet?\n\nIsso irá remover todo o conteúdo de:\n\n$cache_path" \
    --buttons-layout=center \
    --button=Sim:0 --button=Não:1 \
    --width="500" \
    --height="150" \
    2> /dev/null

# Captura o código de saída do yad

resposta=$?


# Se o usuário clicou em "Sim" (código de saída 0)

if [ "$resposta" -eq 0 ]; then

    rm -Rf "$cache_path"/*

        yad \
        --center \
        --window-icon="$logo" \
        --title="Limpeza concluída" \
        --text="Os programas foram apagados com sucesso." \
        --buttons-layout=center \
        --button=OK:0 \
        --width="400" \
        --height="100" \
        2> /dev/null

else

        yad \
        --center \
        --window-icon="$logo" \
        --title="Cancelado" \
        --text="A limpeza foi cancelada." \
        --buttons-layout=center \
        --button=OK:0 \
        --width="200" \
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

# Função de ajuste no Wine


# Explicando:

# É a mesma lógica (configurarWine32), mas cria e ajusta o prefixo padrão 64 bits do Wine, que fica em ~/.wine.


# ✅ Em resumo:

# Cria (se ainda não existir) o prefixo Wine padrão (64 bits) e corrige o formato de data para dd/MM/yyyy.


configurarWine() {

  clear

  echo -e "\nConfigurando o Wine... \n"

  if [ ! -f $HOME/.wine/user.reg ]; then

    # Cria o prefixo Wine 64 bits (se ainda não existir)

    wineboot >/dev/null 2>&1

    # Espera o Wine terminar de criar os arquivos do prefixo

    while [[ ! -f $HOME/.wine/user.reg ]]; do

      sleep 1

    done

  fi

  # Corrige o formato de data do Windows

  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" $HOME/.wine/user.reg
  sed -i "s,d/M/yyyy,dd/MM/yyyy,g" $HOME/.wine/drive_c/windows/win.ini

  clear

}

# ----------------------------------------------------------------------------------------

# Função de ajuste no wine32

configurarWine32() {

  clear

  echo -e "\nConfigurando o Wine... \n"

  if [ ! -f $HOME/.wine32/user.reg ]; then

    # Cria o prefixo Wine 32 bits (se ainda não existir)

    env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wineboot >/dev/null 2>&1

    # Espera o Wine terminar de criar os arquivos do prefixo

    while [[ ! -f $HOME/.wine32/user.reg ]]; do

      sleep 1

    done

  fi

  # Corrige o formato de data do Windows

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

    xfce4-panel --restart &
    ;;
    
  gnome)
    echo -e "\nReiniciando o painel do GNOME... \n"
    gnome-shell --replace &
    ;;
    
  kde|KDE)
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

    # Verifica se o Tint2 está em execução

if pgrep -x "tint2" > /dev/null
then

    echo -e "\nOpenbox não tem painel, mas você pode reiniciar a barra de tarefas. \n"

    echo -e "\nO painel Tint2 está em execução...\n"
    
    killall tint2 && tint2 &

fi
    
    ;;
    
  fluxbox)


    # Verifica se o fbpanel está em execução

if pgrep -x "fbpanel" > /dev/null
then

    echo -e "\nFluxbox não tem painel, mas você pode reiniciar o painel com o comando fbpanel. \n"
    
    killall fbpanel && fbpanel &
    

fi

    # Verifica se o Tint2 está em execução

if pgrep -x "tint2" > /dev/null
then

    echo -e "\nO painel Tint2 está em execução...\n"
    
    killall tint2 && tint2 &

fi

    
    ;;
    
  i3)


    # Verifica se o i3bar está em execução

if pgrep -x "i3bar" > /dev/null
then

    echo -e "\nO painel do i3 (i3bar) está em execução...\n"
    
    echo -e "\nReiniciando o painel do i3 (i3bar)... \n"
     
    killall i3bar && i3bar &

fi


    # Verifica se o Tint2 está em execução

if pgrep -x "tint2" > /dev/null
then

    echo -e "\nO painel Tint2 está em execução...\n"
    
    killall tint2 && tint2 &

fi

    ;;
  bspwm)

    # Verifica se o i3bar está em execução

if pgrep -x "i3bar" > /dev/null
then

    echo -e "\nO painel i3bar está em execução...\n"
    
    echo -e "\nReiniciando o painel do BSPWM (com i3bar ou outro utilitário de barra). \n"
         
    killall i3bar && i3bar &

fi


    # Verifica se o Tint2 está em execução

if pgrep -x "tint2" > /dev/null
then

    echo -e "\nO painel Tint2 está em execução...\n"
    
    killall tint2 && tint2 &

fi
    
    ;;
    
  *)
    echo -e "\nAmbiente de desktop ou gerenciador de janelas desconhecido ou não suportado. \n"
    ;;
    
esac



}

# ----------------------------------------------------------------------------------------

# Verifica se a fonte Arial está instalada

verificar_arial() {

if fc-list | grep -qi "Arial"; then

   echo -e "\nA fonte Arial está instalada... \n"

else

  # Caso não esteja, exibe uma mensagem com yad

  yad \
  --center \
  --window-icon="$logo" \
  --title="Fonte ausente" \
  --text="A fonte Arial não está instalada no sistema." \
  --buttons-layout=center \
  --button=OK:0 \
  --width="300" --height="100" \
  2>/dev/null


# local DISTRO

case "$DISTRO" in

        ubuntu|debian|linuxmint|pop)
            sudo apt update
            sudo apt install -y ttf-mscorefonts-installer

            # Atualiza o cache de fontes
            fc-cache -fv

            ;;

        fedora)
            sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
            sudo dnf install -y msttcore-fonts-installer || \
            sudo rpm -ivh https://downloads.sourceforge.net/corefonts/andale32.exe

            # Atualiza o cache de fontes
            fc-cache -fv

            ;;

        arch|manjaro|biglinux)
            sudo pacman -Sy --noconfirm ttf-ms-fonts || \
            yay -S --noconfirm ttf-ms-fonts

            # Atualiza o cache de fontes
            fc-cache -fv

            ;;

        opensuse*)
            sudo zypper install -y fetchmsttfonts

            # Atualiza o cache de fontes
            fc-cache -fv

            ;;

        void)

# Instala dependências

sudo xbps-install -Sy cabextract fontconfig

# Cria pasta temporária

mkdir -p ~/.fonts/msttcorefonts
cd ~/.fonts/msttcorefonts

# Baixa e extrai as fontes TrueType originais da Microsoft

for font in andale32.exe arial32.exe arialb32.exe comic32.exe courie32.exe georgi32.exe impact32.exe times32.exe trebuc32.exe verdan32.exe webdin32.exe; do

    wget -c "https://downloads.sourceforge.net/corefonts/$font"

    cabextract "$font"

done

# Atualiza o cache de fontes
fc-cache -fv

echo -e "\n✅ Fontes Microsoft (incluindo Arial) instaladas com sucesso! \n"

            ;;

        *)
            yad \
              --center \
              --title="Distribuição não suportada" \
              --text="Não sei como instalar a fonte Arial automaticamente nesta distribuição ($DISTRO)." \
              --button=OK:0 \
              --width="600" --height="100" \
              2>/dev/null


              # Verifica se o arquivo existe

              # Isso checa se o arquivo arial.ttf realmente existe no caminho /opt/projetus/facilitador/fontes/Sped ECF/.

              if [ -f /opt/projetus/facilitador/fontes/Sped\ ECF/arial.ttf ]; then

                 # Cria o diretório ~/.fonts/ (se ainda não existir).

                 mkdir -p ~/.fonts/

                 # Copia o arquivo arial.ttf para dentro dele.

                 cp /opt/projetus/facilitador/fontes/Sped\ ECF/arial.ttf ~/.fonts/

                 sleep 1

                 # Atualiza o cache de fontes

                 fc-cache -fv

                 fc-list | grep -i "Arial"


              fi


            return 1

            ;;
    esac


fi


}

# ----------------------------------------------------------------------------------------



