#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT

# Utilize este programa para validar sua escrituração digital.

# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/efdi



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


log="/tmp/efd-icms-ipi.log"

# ----------------------------------------------------------------------------------------

# Verifica se o diretório existe

if [[ ! -d $HOME/ProgramasSPED/ ]]; then

    echo -e "\nDiretório $HOME/ProgramasSPED/ não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Diretório $HOME/ProgramasSPED/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Verifica se o Java está presente

if [[ ! -x $HOME/ProgramasSPED/Fiscal/jre/bin/java  ]]; then

    echo -e "\nJava não encontrado em $HOME/ProgramasSPED/Fiscal/jre/bin/java \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Java não encontrado em $HOME/ProgramasSPED/Fiscal/jre/bin/java" \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Executa

$HOME/ProgramasSPED/Fiscal/jre/bin/java  \
    -Xmx2048m \
    -Dfile.encoding=ISO-8859-1 \
    -jar $HOME/ProgramasSPED/Fiscal/fiscalpva.jar 2>> "$log"

# ----------------------------------------------------------------------------------------

exit 0

