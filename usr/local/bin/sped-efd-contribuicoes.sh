#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT



# Verifica se o diretório existe

if [[ ! -d ~/ProgramasSPED/EFDContribuicoes ]]; then

    echo -e "\nDiretório ~/ProgramasSPED/EFDContribuicoes não encontrado. \n"

        yad \
        --center \
        --title="Erro" \
        --text="Diretório ~/ProgramasSPED/EFDContribuicoes não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null
        
    exit 1
fi


# Verifica se o Java está presente

if [[ ! -x ~/ProgramasSPED/EFDContribuicoes/jre/bin/java ]]; then

    echo -e "\nJava não encontrado em ~/ProgramasSPED/EFDContribuicoes/jre/bin/java \n"

        yad \
        --center \
        --title="Erro" \
        --text="Java não encontrado em ~/ProgramasSPED/EFDContribuicoes/jre/bin/java" \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi


# Executa

~/ProgramasSPED/EFDContribuicoes/jre/bin/java \
    -Xmx2048m \
    -Dfile.encoding=ISO-8859-1 -XX:+UseParallelGC -XX:FreqInlineSize=512 -XX:MaxInlineSize=35 \
    -jar ~/ProgramasSPED/EFDContribuicoes/efdcontribuicoes.jar


exit 0

