#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT


# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/efdc

# http://sped.rfb.gov.br/


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


log="/tmp/SPED-EFD-Contribuicoes.log"

# ----------------------------------------------------------------------------------------

# Verifica se o diretório existe

if [[ ! -d $HOME/ProgramasSPED/EFDContribuicoes ]]; then

    echo -e "\nDiretório $HOME/ProgramasSPED/EFDContribuicoes não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Diretório $HOME/ProgramasSPED/EFDContribuicoes não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null
        
    exit 1
fi


# ----------------------------------------------------------------------------------------

# Verifica se o Java está presente

if [[ ! -x $HOME/ProgramasSPED/EFDContribuicoes/jre/bin/java ]]; then

    echo -e "\nJava não encontrado em $HOME/ProgramasSPED/EFDContribuicoes/jre/bin/java \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Java não encontrado em $HOME/ProgramasSPED/EFDContribuicoes/jre/bin/java" \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Executa

$HOME/ProgramasSPED/EFDContribuicoes/jre/bin/java \
    -Xmx2048m \
    -Dfile.encoding=ISO-8859-1 -XX:+UseParallelGC -XX:FreqInlineSize=512 -XX:MaxInlineSize=35 \
    -jar $HOME/ProgramasSPED/EFDContribuicoes/efdcontribuicoes.jar 2>> "$log"

# ----------------------------------------------------------------------------------------

exit 0

