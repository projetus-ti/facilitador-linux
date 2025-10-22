#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT

ano=$(date +%Y)

log="/tmp/dirf.log"

# ----------------------------------------------------------------------------------------

# Verifica se o diretório existe

if [[ ! -d "/opt/Programas RFB/Dirf$ano" ]]; then

    echo -e "\nDiretório /opt/Programas RFB/Dirf$ano não encontrado. \n"

        yad \
        --center \
        --title="Erro" \
        --text="Diretório /opt/Programas RFB/Dirf$ano não encontrado.


⚠️ Observações importantes

A DIRF está sendo substituída gradualmente pelo eSocial e EFD-Reinf, mas ainda pode ser exigida dependendo do ano e da situação fiscal.

Fique atento ao ano da DIRF (por exemplo, DIRF 2024 se refere ao ano-calendário 2023).

Sempre baixe o programa no site oficial da Receita Federal para evitar fraudes.


Declarar imposto de renda retido na fonte (DIRF) 

https://www.gov.br/pt-br/servicos/declarar-imposto-de-renda-retido-na-fonte

" \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi


# ----------------------------------------------------------------------------------------

        yad \
        --center \
        --title="Dirf" \
        --text="A DIRF (Declaração do Imposto de Renda Retido na Fonte) é uma obrigação acessória da Receita Federal do Brasil (RFB). Ela é usada por empresas e outros órgãos para declarar os valores de impostos retidos na fonte, como:

Imposto de Renda Retido na Fonte (IRRF)

Contribuições Sociais (PIS, Cofins e CSLL)

Rendimentos pagos a pessoas físicas e jurídicas

Entre outros

O objetivo é informar à Receita os valores pagos e os tributos retidos sobre esses pagamentos.

📌 Quem deve entregar a DIRF?

Geralmente:

Empresas que pagam ou creditam rendimentos com retenção de IR

Órgãos públicos

Pessoas físicas ou jurídicas que fizeram pagamentos com retenção na fonte" \
        --buttons-layout=center \
        --button="OK" \
        --width="900" \
        2>/dev/null

# ----------------------------------------------------------------------------------------

cd "/opt/Programas RFB/Dirf$ano"

export JAVA_TOOL_OPTIONS=-Dfile.encoding=ISO-8859-1

umask 000

  if command -v java >/dev/null 2>&1; then

   java -jar pgdDirf.jar 2>> "$log"

  else

    java -jar -Xms512M -Xmx1024M -XX:+UseParallelOldGC pgdDirf.jar 2>> "$log"

  fi

# ----------------------------------------------------------------------------------------

exit 0

