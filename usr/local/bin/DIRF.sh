#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT


# Programa Gerador de Declaração (PGD) da Declaração do Imposto sobre a Renda Retido na Fonte (DIRF).


# Declaração do Imposto sobre a Renda Retido na Fonte

# Utilize este programa para preencher Declaração do Imposto sobre a Renda Retido na Fonte (DIRF).

# Esse programa é destinado às FONTES PAGADORAS, ou seja, cidadãos e empresas que pagam 
# valores (como salário, por exemplo) a outras pessoas e que fazem a retenção da parte 
# correspondente ao imposto de renda.


# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dirf


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


ano=$(date +%Y)

log="/tmp/dirf.log"

# ----------------------------------------------------------------------------------------

# Verifica se o diretório existe

if [[ ! -d "/opt/Programas RFB/Dirf$ano" ]]; then

    echo -e "\nDiretório /opt/Programas RFB/Dirf$ano não encontrado. \n"



echo "Diretório /opt/Programas RFB/Dirf$ano não encontrado.


⚠️ Observações importantes

A DIRF está sendo substituída gradualmente pelo eSocial e EFD-Reinf, mas ainda pode ser exigida dependendo do ano e da situação fiscal.

Fique atento ao ano da DIRF (por exemplo, DIRF ${ano} se refere ao ano-calendário `echo "${ano}-1" | bc`).

Sempre baixe o programa no site oficial da Receita Federal para evitar fraudes.


Declarar imposto de renda retido na fonte (DIRF) 

https://www.gov.br/pt-br/servicos/declarar-imposto-de-renda-retido-na-fonte

" | yad --center --window-icon="$logo" --title "Erro" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1200" --height="400"  2> /dev/null


    exit 1

fi


# ----------------------------------------------------------------------------------------


echo "
A DIRF (Declaração do Imposto de Renda Retido na Fonte) é uma obrigação acessória da Receita Federal do Brasil (RFB). Ela é usada por empresas e 
outros órgãos para declarar os valores de impostos retidos na fonte, como:

Imposto de Renda Retido na Fonte (IRRF)

Contribuições Sociais (PIS, Cofins e CSLL)

Rendimentos pagos a pessoas físicas e jurídicas

Entre outros

O objetivo é informar à Receita os valores pagos e os tributos retidos sobre esses pagamentos.

📌 Quem deve entregar a DIRF?

Geralmente:

Empresas que pagam ou creditam rendimentos com retenção de IR

Órgãos públicos

Pessoas físicas ou jurídicas que fizeram pagamentos com retenção na fonte." | yad --center --window-icon="$logo" --title "Dirf" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1200" --height="500"  2> /dev/null



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

