#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT


# Ano atual

ano=$(date +%Y)

log="/tmp/irpf.log"

# ----------------------------------------------------------------------------------------


# Verifica se o diretório existe

if [[ ! -d ~/ProgramasRFB/IRPF$ano/ ]]; then

    echo -e "\nDiretório ~/ProgramasRFB/IRPF$ano/ não encontrado. \n"

        yad \
        --center \
        --title="Erro" \
        --text="Diretório ~/ProgramasRFB/IRPF$ano/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2> /dev/null
        
    exit 1
fi

# ----------------------------------------------------------------------------------------

cd ~/ProgramasRFB/IRPF$ano/


# Verifica se o arquivo existe

if [[ -f ~/ProgramasRFB/IRPF$ano/irpf.jar ]]; then


  if java --version &>/dev/null; then

    java -jar irpf.jar 2>> "$log"

  fi


fi


# ----------------------------------------------------------------------------------------
  
exit 0
  
