#!/usr/bin/env bash
#
# Autor: Fernando Souza - https://www.youtube.com/@fernandosuporte/
#
# Data:     19/10/2025
# Homepage: https://github.com/tuxslack/facilitador-linux
# Licença:  MIT

clear


# Procurar pela string .exe dentro dos arquivos

# grep -R --color=auto -n '\.exe' .

# grep -R --color=auto -n '\.exe' . | wc -l


# ----------------------------------------------------------------------------------------


# Usar o .conf no script
# Para carregar as variáveis do .conf

source etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

# source usr/local/bin/funcoes.sh  2> /dev/null


logo="usr/share/icons/facilitador/icon.png"



# log=$(mktemp "/tmp/facilitador-linux.log.XXXXXX")

# Remove o arquivo de log

rm -Rf /tmp/facilitador-linux.log.* 2>/dev/null


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
  openbox|bunsenlabs)
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

which yad             1> /dev/null 2> /dev/null || { echo -e "\nPrograma Yad não esta instalado. \n"      ; exit ; }

# ----------------------------------------------------------------------------------------


# Mostra aviso sobre backup do sistema

yad --center \
    --window-icon="$logo" \
    --title="Aviso Importante" \
    --text="⚠️ <b>Recomendação:</b>\n\nAntes de executar este script, é altamente recomendável criar uma <b>imagem de backup do sistema</b>.\n\nDeseja continuar mesmo assim?" \
    --buttons-layout=center \
    --button=Não:1 --button=Sim:0 \
    --width="400" --height="150" \
    2> /dev/null


# Verifica a resposta do usuário

if [[ $? -ne 0 ]]; then

    yad --center \
        --window-icon="$logo" \
        --title="Cancelado" \
        --text="Execução cancelada pelo usuário." \
        --buttons-layout=center \
        --button="OK"  \
        --width="300" \
        2> /dev/null

    exit 1
fi


# Testa conectividade com a internet

if ! ping -c 1 google.com &>/dev/null; then

    yad --center \
        --window-icon="$logo" \
        --title="Erro de Conexão" \
        --text="Sem acesso à internet.\nVerifique sua conexão de rede." \
        --buttons-layout=center \
        --button=OK \
        --width="300" --height="100" \
        2> /dev/null
        
    # exit 1
fi

# ----------------------------------------------------------------------------------------




# Função para exibir ajuda

ajuda() {

  clear

  echo "Uso: $0 [instalar|desinstalar]" | tee -a "$log"

  echo "
"        | tee -a "$log"

  echo "Exemplo: $0 instalar|install"           | tee -a "$log"
  echo "Exemplo: $0 desinstalar|uninstall"      | tee -a "$log"


yad \
--center  \
--window-icon="$logo" \
--title="$titulo" \
--text="

Uso: $0 [instalar|desinstalar]

Exemplo: $0 instalar|install

Exemplo: $0 desinstalar|uninstall

" \
--buttons-layout=center \
--button="OK"  \
--width="800" --height="300" \
2> /dev/null

}

# ----------------------------------------------------------------------------------------

instalar(){


# Para instalar


echo "Iniciando a instalação..." | tee -a "$log"

find opt -type f > facilitador-linux-instalacao.log
find usr -type f >> facilitador-linux-instalacao.log
find etc -type f >> facilitador-linux-instalacao.log

sleep 1

# Incluir uma / no início de cada linha do arquivo facilitador-linux-instalacao.log usando o comando sed

sed -i 's/^/\//g' facilitador-linux-instalacao.log


sudo cp -r opt /                2>> "$log"

chmod +x usr/local/bin/*.sh     2>> "$log"

chmod -R 755 usr/local/bin/*.sh 2>> "$log"

# Atualizando a pasta doc

cp facilitador-linux-acao.sh  usr/share/doc/facilitador/ | tee -a "$log"
cp README.md                  usr/share/doc/facilitador/ | tee -a "$log"
cp LICENSE                    usr/share/doc/facilitador/ | tee -a "$log"

# Atualiza o arquivo facilitador-linux-instalacao.log na pasta doc

cp facilitador-linux-instalacao.log  usr/share/doc/facilitador/ | tee -a "$log"

sleep 1

sudo cp -r usr /  2>> "$log"



sudo chmod +x /usr/local/bin/DIRF.sh                   2>> "$log"
sudo chmod +x /usr/local/bin/IRPF.sh                   2>> "$log"
sudo chmod +x /usr/local/bin/contabil.sh               2>> "$log"
sudo chmod +x /usr/local/bin/efd-icms-ipi.sh           2>> "$log"
sudo chmod +x /usr/local/bin/facilitador.sh            2>> "$log"
sudo chmod +x /usr/local/bin/fiscal.sh                 2>> "$log"
sudo chmod +x /usr/local/bin/folha.sh                  2>> "$log"
sudo chmod +x /usr/local/bin/funcoes.sh                2>> "$log"
sudo chmod +x /usr/local/bin/linphone.sh               2>> "$log"
sudo chmod +x /usr/local/bin/projetus.sh               2>> "$log"
sudo chmod +x /usr/local/bin/sped-ecd.sh               2>> "$log"
sudo chmod +x /usr/local/bin/sped-ecf.sh               2>> "$log"
sudo chmod +x /usr/local/bin/sped-efd-contribuicoes.sh 2>> "$log"
sudo chmod +x /usr/local/bin/updater.sh                2>> "$log"


sudo cp -r etc /  2>> "$log"



# ✅ Considerações Importantes:

# Permissões 777 são inseguras: Conceder permissões de leitura, escrita e execução para 
# todos os usuários no sistema pode ser um risco de segurança, pois qualquer usuário pode 
# modificar ou excluir arquivos do diretório. Essa configuração é útil apenas em ambientes 
# controlados (como diretórios temporários ou de teste).

# Alternativa mais segura: Em ambientes de produção, é geralmente melhor conceder permissões 
# mais restritas, por exemplo:

# chmod 770: Leitura, escrita e execução para o proprietário e grupo, mas nenhum acesso 
# para outros.

# chmod 775: Leitura, escrita e execução para o proprietário e grupo, e leitura e execução 
# para outros.


# Verificar se a pasta não existe

if [ ! -d "$cache_path" ]; then

    echo "Diretório não encontrado: $cache_path"

    sudo mkdir -p "$cache_path" 2>> "$log"

    # exit 1

fi

# Definir permissões de escrita para todos

sudo chmod -R 777 "$cache_path" 2>> "$log"


# Verificar se as permissões foram aplicadas corretamente

if [ -w "$cache_path" ]; then

    echo "Permissões de escrita para todos foram concedidas no diretório '$cache_path'." | tee -a "$log"

else

    echo "Falha ao conceder permissões de escrita." | tee -a "$log"

fi


cp /usr/share/applications/facilitador.desktop   "$desktop_path/"


# Update desktop database

sudo update-desktop-database


echo -e "\n\n"


reiniciar_painel


# ----------------------------------------------------------------------------------------

# Verifica se tem slapt-get (Salix)

# A pasta /usr/share/doc é link para /usr/doc/

# cp: não é possível sobrescrever o não-diretório '/usr/share/doc' com o diretório 'usr/share/doc'


# $ ls -l /usr/share/ | grep doc
# lrwxrwxrwx  1 root root    6 set 30  2022 doc -> ../doc
# drwxr-xr-x  1 root root   27 set 30  2022 gtk-doc


if command -v slapt-get >/dev/null 2>&1; then


sudo cp -r usr/share/doc /usr/ | tee -a "$log"

fi

# ----------------------------------------------------------------------------------------



    yad --center \
        --window-icon="$logo" \
        --title="$titulo" \
        --text="Instalação concluída!

O Facilitador Linux encontra-se no menu de aplicativos do sistema." \
        --buttons-layout=center \
        --button=OK \
        --width="500" --height="200" \
        2> /dev/null

}

# ----------------------------------------------------------------------------------------

desinstalar(){

# Para remover


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh

logo="usr/share/icons/facilitador/icon.png"



# Verificar se o arquivo facilitador-linux-instalacao.log existe

if [ -e "/usr/share/doc/facilitador/facilitador-linux-instalacao.log" ]; then


echo "Iniciando a desinstalação..." | tee -a "$log"


echo "Desinstalando pacote..." | tee -a "$log"

cp /usr/share/doc/facilitador/facilitador-linux-instalacao.log /tmp || exit


# cat /tmp/facilitador-linux-instalacao.log | xargs sudo rm -f   

# 2>> "$log"


# Substituindo quebras de linha por \0 (null):

# Uma abordagem mais robusta para evitar problemas com espaços é usar o delimitador nulo:

cat /tmp/facilitador-linux-instalacao.log | tr '\n' '\0' | xargs -0 sudo rm -f

# Aqui, estamos substituindo as quebras de linha por caracteres nulos e, em seguida, usando o xargs com a opção -0 para garantir que cada caminho seja passado de forma segura para o rm.

sleep 1

sudo rm -Rf /tmp/facilitador-linux-instalacao.log

sudo rm -Rf \
/opt/projetus/ \
/usr/share/doc/facilitador/ \
/usr/share/icons/facilitador/   \
2>> "$log"


    if [ $? -eq 0 ]; then



if [ -e "$desktop_path/facilitador.desktop" ]; then

rm "$desktop_path"/facilitador.desktop  2>> "$log"

fi


if [ -d "$desktop_path/Validadores" ]; then

rm -Rf "$desktop_path"/Validadores  2>> "$log"

fi


rm -Rf $HOME/.local/share/applications/install*.desktop


# Update desktop database

sudo update-desktop-database

echo -e "\n\n"

reiniciar_painel


# ----------------------------------------------------------------------------------------

# Verifica se tem slapt-get (Salix)

# A pasta /usr/share/doc é link para /usr/doc/

# cp: não é possível sobrescrever o não-diretório '/usr/share/doc' com o diretório 'usr/share/doc'


# $ ls -l /usr/share/ | grep doc
# lrwxrwxrwx  1 root root    6 set 30  2022 doc -> ../doc
# drwxr-xr-x  1 root root   27 set 30  2022 gtk-doc


if command -v slapt-get >/dev/null 2>&1; then


sudo rm -Rf /usr/doc/facilitador/  | tee -a "$log"


fi

# ----------------------------------------------------------------------------------------



      echo "Desinstalado com sucesso." | tee -a "$log"

    yad --center \
        --window-icon="$logo" \
        --title="$titulo" \
        --text="Desinstalado com sucesso." \
        --buttons-layout=center \
        --button=OK \
        --width="300" --height="100" \
        2> /dev/null


    else

      echo "Erro ao desinstalar. Verifique o log $log para mais detalhes." | tee -a "$log"

    fi
    
    else

      echo "Erro ao desinstalar: arquivo /usr/share/doc/facilitador/facilitador-linux-instalacao.log não existe" | tee -a "$log"

    yad --center \
        --window-icon="$logo" \
        --title="$titulo" \
        --text="Erro ao desinstalar: arquivo /usr/share/doc/facilitador/facilitador-linux-instalacao.log não existe" \
        --buttons-layout=center \
        --button=OK \
        --width="700" --height="100" \
        2> /dev/null

fi

echo "
Para mais informações verifique o arquivo de log $log
"

}

# ----------------------------------------------------------------------------------------

# Verificar se o usuário forneceu pelo menos um argumento

if [ "$#" -lt 1 ]; then

  ajuda

  exit 1

fi

# ----------------------------------------------------------------------------------------

# Chamar a função apropriada com base no primeiro argumento

comando=$1
shift

case "$comando" in

  instalar|install)

    instalar "$@"
    
    ;;

  desinstalar|uninstall)

    desinstalar "$@"
    
    ;;

  *)
  
    ajuda

    exit 1
    
    ;;

esac

# ----------------------------------------------------------------------------------------

echo -e "\n\n-------------------------------------------------------------\n\nConteúdo do arquivo de log: $log \n"

cat "$log"

# rm "$log"  2>/dev/null

# ----------------------------------------------------------------------------------------


exit 0



