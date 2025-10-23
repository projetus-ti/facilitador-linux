#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT


# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dirpf


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


# Ano atual

ano=$(date +%Y)

log="/tmp/irpf.log"

# ----------------------------------------------------------------------------------------


# Verifica se o diretório existe

if [[ ! -d $HOME/IRPF$ano/ ]]; then

    echo -e "\nDiretório $HOME/IRPF$ano/ não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Diretório $HOME/IRPF$ano/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2> /dev/null
        
    exit 1
fi

# ----------------------------------------------------------------------------------------

cd $HOME/IRPF$ano/


# Verifica se o arquivo existe

if [[ -f $HOME/IRPF$ano/irpf.jar ]]; then


  if java --version &>/dev/null; then


    java -jar $HOME/IRPF$ano/irpf.jar 2>> "$log"

    notify-send -i "$logo" -t $tempo_notificacao "$titulo" "\nArquivo de log $log...\n"

  fi


fi


# ----------------------------------------------------------------------------------------
  
exit 0
  
