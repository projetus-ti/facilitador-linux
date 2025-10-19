#!/bin/bash
#
# Autor: Fernando Souza - https://www.youtube.com/@fernandosuporte/
#
# Data:     19/10/2025
# Homepage: https://github.com/tuxslack/facilitador-linux
# Licença:  MIT

clear

# ----------------------------------------------------------------------------------------

which yad             1> /dev/null 2> /dev/null || { echo "Programa Yad não esta instalado."      ; exit ; }

# ----------------------------------------------------------------------------------------

log=$(mktemp "/tmp/facilitador-linux.log.XXXXXX")

# Remove o arquivo de log

rm -Rf "$log" 2>/dev/null


# ----------------------------------------------------------------------------------------


# Mostra aviso sobre backup do sistema

yad --center --title="Aviso Importante" \
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


# Testa conectividade com a internet

if ! ping -c 1 google.com &>/dev/null; then

    yad --center --title="Erro de Conexão" \
        --text="Sem acesso à internet.\nVerifique sua conexão de rede." \
        --buttons-layout=center \
        --button=OK \
        --width="300" --height="100" \
        2> /dev/null
        
    exit 1
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

}

# ----------------------------------------------------------------------------------------

instalar(){

# Para instalar

echo "Iniciando a instalação..." | tee -a "$log"

find opt -type f > facilitador-linux-instalacao.log
find usr -type f >> facilitador-linux-instalacao.log


# Incluir uma / no início de cada linha do arquivo facilitador-linux-instalacao.log usando o comando sed

sed -i 's/^/\//g' facilitador-linux-instalacao.log


sudo cp -r opt /  2>> "$log"

sudo cp -r usr /  2>> "$log"

sudo cp facilitador-linux-instalacao.log  /usr/share/doc/facilitador/


echo -e "\n\n"


}

# ----------------------------------------------------------------------------------------

desinstalar(){

# Para remover

echo "Iniciando a desinstalação..." | tee -a "$log"


echo "Desinstalando pacote..." | tee -a "$log"

cp /usr/share/doc/facilitador/facilitador-linux-instalacao.log /tmp

cat /tmp/facilitador-linux-instalacao.log | xargs sudo rm -f   

# 2>> "$log"

    if [ $? -eq 0 ]; then
      echo "Desinstalado com sucesso." | tee -a "$log"
    else
      echo "Erro ao desinstalar. Verifique o log $log para mais detalhes." | tee -a "$log"
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

cat "$log"

rm "$log"  2>/dev/null

# ----------------------------------------------------------------------------------------


exit 0


