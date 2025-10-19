#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT

# Verifica se o diretório do SPED existe

if [[ ! -d ~/ProgramasSPED/SpedContabil ]]; then

    echo -e "\nDiretório ~/ProgramasSPED/SpedContabil não encontrado. \n"

        yad --center --title="Erro" \
        --text="Diretório ~/ProgramasSPED/SpedContabil não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null
        
    exit 1
fi


# Verifica se o Java está presente

if [[ ! -x ~/ProgramasSPED/SpedContabil/jre/bin/java ]]; then
    echo -e "\nJava não encontrado em ~/ProgramasSPED/SpedContabil/jre/bin/java \n"

        yad --center --title="Erro" \
        --text="Java não encontrado em ~/ProgramasSPED/SpedContabil/jre/bin/java" \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi


# Executa o SPED Contábil

~/ProgramasSPED/SpedContabil/jre/bin/java \
    -Xmx2048m \
    -Dfile.encoding=ISO-8859-1 \
    -jar ~/ProgramasSPED/SpedContabil/contabilpva.jar

exit 0

