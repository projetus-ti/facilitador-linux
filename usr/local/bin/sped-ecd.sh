#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT


# Validador da Escrituração Contábil Digital (ECD).

# Utilize este programa para validar o arquivo da sua Escrituração Contábil Digital (ECD).

# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/ecd


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


log="/tmp/sped-ecd.log"

sudo rm -Rf "$log"

# ----------------------------------------------------------------------------------------

# Verifica se o diretório do SPED existe

if [[ ! -d $HOME/ProgramasSPED/SpedContabil ]]; then

    echo -e "\nDiretório $HOME/ProgramasSPED/SpedContabil não encontrado. \n"

        yad --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Diretório $HOME/ProgramasSPED/SpedContabil não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="500" --height="100" \
        2>/dev/null
        
    exit 1
fi

# ----------------------------------------------------------------------------------------

# Verifica se o Java está presente

if [[ ! -x $HOME/ProgramasSPED/SpedContabil/SpedContabil ]]; then

    echo -e "\nAquivo SpedContabil não encontrado em $HOME/ProgramasSPED/SpedContabil/ \n"

        yad --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Arquivo SpedContabil não encontrado em $HOME/ProgramasSPED/SpedContabil/" \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Executa o SPED Contábil

# $HOME/ProgramasSPED/SpedContabil/jre/bin/java \
#     -Xmx2048m \
#     -Dfile.encoding=ISO-8859-1 \
#     -jar $HOME/ProgramasSPED/SpedContabil/contabilpva.jar 2>> "$log"

pkill -f $HOME/ProgramasSPED/SpedContabil/SpedContabil

pkill -f java

sleep 1

$HOME/ProgramasSPED/SpedContabil/SpedContabil

# ----------------------------------------------------------------------------------------

exit 0

