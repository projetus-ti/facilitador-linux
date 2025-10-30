#!/usr/bin/env bash

# Por: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 23/10/2025
# Licença:  MIT


# https://www.gov.br/esocial/pt-br
# https://login.esocial.gov.br/login.aspx


clear

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


# ----------------------------------------------------------------------------------------

echo "
O que é o eSocial e para que serve?


O eSocial é um sistema digital do Governo Federal que unifica o envio de informações que as empresas enviam aos órgãos do governo sobre seus 
empregados. Ele serve para que empregadores cumpram suas obrigações fiscais, previdenciárias e trabalhistas de forma centralizada, substituindo 
diversas declarações separadas. O sistema facilita o cumprimento das obrigações, garante o direito dos trabalhadores e aprimora a qualidade dos 
dados. 

Para que serve o eSocial

Unificar informações:

Centraliza o envio de dados sobre vínculos trabalhistas, folha de pagamento, contribuições previdenciárias e FGTS, entre outros. 

Simplificar obrigações:

Substitui a necessidade de preencher e enviar formulários e declarações a diferentes órgãos, como a GFIP. 

Garantir direitos:

Garante que os direitos trabalhistas e previdenciários dos empregados sejam assegurados. 

Melhorar a fiscalização:

Aumenta a capacidade do governo de fiscalizar o cumprimento das leis trabalhistas e previdenciárias. 

Promover a saúde e segurança do trabalho:

Permite que as empresas informem dados sobre acidentes de trabalho e monitoramento da saúde dos trabalhadores, ajudando a criar ambientes de 
trabalho mais seguros. 

Evitar duplicidade:

Elimina a redundância no envio de informações, pois todos os dados são transmitidos para um único sistema. 

As Empresas e o Empregador Pessoa Física poderão acessar o eSocial por meio do login do Gov.br, sendo necessário o cadastro prévio e atribuição 
do respectivo selo de confiabilidade no Portal Gov.br (será exigido o tipo de selo "\Certificado Digital"\). 
" | yad --center --window-icon="$logo" --title "eSocial" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1200" --height="730"  2> /dev/null

# ----------------------------------------------------------------------------------------

# Acesse o eSocial

xdg-open "https://login.esocial.gov.br/login.aspx" &


# ----------------------------------------------------------------------------------------


exit 0

