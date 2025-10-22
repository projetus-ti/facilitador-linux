#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT

log="/tmp/SPED-ECF.log"

# ----------------------------------------------------------------------------------------

# Verifica se o diretório existe

if [[ ! -d ~/ProgramasSPED/ECF/ ]]; then

    echo -e "\nDiretório ~/ProgramasSPED/ECF/ não encontrado.\n"

        yad \
        --center \
        --title="Erro" \
        --text="Diretório ~/ProgramasSPED/ECF/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null
        
    exit 1
fi

# ----------------------------------------------------------------------------------------

# Verifica se o Java está presente

if [[ ! -x ~/ProgramasSPED/ECF/jre/bin/java ]]; then

    echo -e "\nJava não encontrado em ~/ProgramasSPED/ECF/jre/bin/java \n"

        yad \
        --center \
        --title="Erro" \
        --text="Java não encontrado em ~/ProgramasSPED/ECF/jre/bin/java" \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Executa

~/ProgramasSPED/ECF/jre/bin/java \
    -Xmx2048m \
    -Dfile.encoding=ISO-8859-1 \
    -jar ~/ProgramasSPED/ECF/irpjpva.jar 2>> "$log"

# ----------------------------------------------------------------------------------------

exit 0

