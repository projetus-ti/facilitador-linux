#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT


# SpedECF

# Utilize este programa para validar o arquivo da sua Escrituração Contábil Fiscal (ECF).

# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/ecf


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


log="/tmp/SPED-ECF.log"

sudo rm -Rf "$log"

# ----------------------------------------------------------------------------------------

# Verifica se o diretório existe

if [[ ! -d $HOME/ProgramasSPED/SpedECF/ ]]; then

    echo -e "\nDiretório $HOME/ProgramasSPED/SpedECF/ não encontrado.\n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Diretório $HOME/ProgramasSPED/SpedECF/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="500" --height="100" \
        2>/dev/null
        
    exit 1
fi

# ----------------------------------------------------------------------------------------

# Verifica se o Java está presente

if [[ ! -x $HOME/ProgramasSPED/SpedECF/jre/bin/java ]]; then

    echo -e "\nJava não encontrado em $HOME/ProgramasSPED/SpedECF/jre/bin/java \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Java não encontrado em $HOME/ProgramasSPED/SpedECF/jre/bin/java" \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Executa

# $HOME/ProgramasSPED/SpedECF/jre/bin/java \
#     -Xmx2048m \
#     -Dfile.encoding=ISO-8859-1 \
#     -jar $HOME/ProgramasSPED/SpedECF/irpjpva.jar 2>> "$log"


pkill -f java

sleep 1

$HOME/ProgramasSPED/SpedECF/SpedECF

# ----------------------------------------------------------------------------------------

exit 0

