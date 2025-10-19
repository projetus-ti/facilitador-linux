#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025

# Verifica se o diretório existe
if [[ ! -d ~/ProgramasSPED/ECF/ ]]; then
    echo "Diretório ~/ProgramasSPED/ECF/ não encontrado."
    exit 1
fi

# Verifica se o Java está presente
if [[ ! -x ~/ProgramasSPED/ECF/jre/bin/java ]]; then
    echo "Java não encontrado em ~/ProgramasSPED/ECF/jre/bin/java"
    exit 1
fi

# Executa
~/ProgramasSPED/ECF/jre/bin/java \
    -Xmx2048m \
    -Dfile.encoding=ISO-8859-1 \
    -jar ~/ProgramasSPED/ECF/irpjpva.jar

