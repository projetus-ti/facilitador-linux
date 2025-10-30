#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT


# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dirpf


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

# Carrega as funções definidas em funcoes.sh


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


# Ano atual

ano=$(date +%Y)

log="/tmp/irpf.log"

sudo rm -Rf "$log"

# ----------------------------------------------------------------------------------------


# Verifica se o diretório existe

if [[ ! -d $HOME/ProgramasRFB/IRPF$ano/ ]]; then

    echo -e "\nDiretório $HOME/ProgramasRFB/IRPF$ano/ não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Diretório $HOME/ProgramasRFB/IRPF$ano/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="500" --height="100" \
        2> /dev/null
        
    exit 1
fi

# ----------------------------------------------------------------------------------------

cd $HOME/ProgramasRFB/IRPF$ano/


# Verifica se o arquivo existe

# if [[ -f $HOME/IRPF$ano/irpf.jar ]]; then


#   if java --version &>/dev/null; then


#     java -jar $HOME/IRPF$ano/irpf.jar 2>> "$log"

#     notify-send -i "$logo" -t $tempo_notificacao "$titulo" "\nArquivo de log $log...\n"

#   fi


# fi


./IRPF2025


# ----------------------------------------------------------------------------------------
  
exit 0
  
