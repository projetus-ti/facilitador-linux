#!/usr/bin/env bash
#
# Autor: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 28/10/2025
# Licença:  MIT


# Programa SVA

# https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/auditoria-fiscal/arquivos/sva-arquivos/instala_sva-3-3-0.exe/view


# ValidaCD

# https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/auditoria-fiscal/arquivos/sva-arquivos/validacd-1.exe/view

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

# ----------------------------------------------------------------------------------------

# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf

log="/tmp/sva.log"

sudo rm -Rf "$log"

# ----------------------------------------------------------------------------------------

# Verifica se o diretório existe

if [[ ! -d $HOME/.wine/ ]]; then

    echo -e "\nDiretório $HOME/.wine/ não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Diretório $HOME/.wine/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2> /dev/null
        
    exit 1
fi

# ----------------------------------------------------------------------------------------

# Caminho onde o Sva.exe deveria estar

# Você pode mudar o caminho da variavel conforme necessário.

arquivo="$HOME/.wine/drive_c/Arquivos\ de\ Programas\ RFB/SVA\ 3.3.0/Sva.exe"


# Verifica se o arquivo existe

if [[ ! -f "$arquivo" ]]; then

    yad --center \
        --window-icon="$logo" \
        --title="Arquivo não encontrado" \
        --text="O arquivo $arquivo não foi encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" \
        --height="100"

   exit

fi


# ----------------------------------------------------------------------------------------

# Caminho do atalho

atalho_path="/usr/share/applications"
arquivo="$atalho_path/sva.desktop"


# Verifica se o arquivo existe

if [[ ! -f "$arquivo" ]]; then

    yad --center \
        --window-icon="$logo" \
        --title="Arquivo não encontrado" \
        --text="O arquivo $arquivo não foi encontrado." \
        --buttons-layout=center \
        --button=OK \
        --width="300" \
        --height="100"

   exit

fi

# ----------------------------------------------------------------------------------------

# Arquivo .desktop

# sudo chmod +x $arquivo 2>> "$log"

# ----------------------------------------------------------------------------------------

echo '
⚠️ SVA – Arquivos Digitais – Auditoria Fiscal de Empresas


O SVA valida o leiaute dos arquivos-texto entregues pelo contribuinte de acordo com normas da Secretaria da Receita Federal do Brasil e efetua a 
autenticação (geração de um código de identificação a partir do conteúdo do arquivo) dos arquivos digitais fornecidos pelo contribuinte ao 
Auditor-Fiscal, em cumprimento ao item 1.11 do MANAD – Manual Normativo de Arquivos Digitais, aprovado pela INSTRUÇÃO NORMATIVA MPS/SRP Nº 12, de 
20 de junho de 2006, publicada no DOU de 03/07/2006, artigos 61 e 62 da INSTRUÇÃO NORMATIVA SRP Nº 03, de 14 de Julho de 2005 , publicada no DOU 
nº 135 de 15/07/2005 e artigo 8 da Lei 10.666, de 08 de Maio de 2004, no intuito de identificar, de forma única e inequívoca, os arquivos digitais 
fornecidos.

Na validação de arquivos texto no formato MANAD, o SVA verifica a conformidade do leiaute dos arquivos selecionados com o leiaute padrão estabelecido 
no Manual (tamanho e tipo dos dados, posição dos campos, etc...). Verifica ainda a consistência e a coerência dos dados entre si realizando testes de 
integridade referencial dos dados contidos nas tabelas relacionadas e ainda a inexistência de registros duplicados.

Os erros e/ou avisos, porventura encontrados são listados no "Relatório Analítico de Mensagens da Validação" e os resultados são consolidados no 
"Relatório Mensagens da Validação" e no “Relatório de Resumo da Validação do Arquivo”.

O SVA autentica quaisquer arquivos digitais fornecidos pelo contribuinte independente do tipo (planilhas, documentos, bancos de dados, relatórios, 
etc...) mediante varredura no conteúdo do arquivo digital entregue pela empresa, gerando um código de identificação do arquivo utilizando o algoritmo 
MD5 "Message-Digest algorithm 5" de 128-bit de comprimento, podendo ser utilizado a qualquer tempo, tanto pelo contribuinte quanto pelo Auditor-Fiscal 
da Receita Federal do Brasil. Este código de identificação do arquivo constará em todos os relatórios emitidos pelo Sistema autenticando o(s) arquivo(s) 
selecionado(s). O “Recibo de Entrega de Arquivo Digital” deverá ser assinado pelo contribuinte/responsável ou preposto da empresa, pelo responsável 
técnico pela geração dos arquivos e pelo Auditor-Fiscal requisitante (após conferência por este do código de autenticação do arquivo).

SVA – Autenticação e Validação de Arquivos Digitais

O(s) arquivo(s) digital(is) entregue(s) ao Auditor-Fiscal requisitante, em mídia digital não regravável, deverá(ão), portanto, vir acompanhado(s) dos 
três relatórios acima mencionados: "Relatório de Mensagens da Validação" (quando houver), "Relatório de Resumo da Validação do Arquivo" e 
"Recibo de entrega de Arquivos Digitais".


ARQUIVOS DIGITAIS – AUTENTICAÇÃO DE RELATÓRIOS PRODUZIDOS PELA AUDITORIA-FISCAL E ENTREGUES AO CONTRIBUINTE EM CD

Os Relatórios fiscais produzidos pela Auditoria-Fiscal e entregues às empresas em meio magnético apresentam código seqüencial de autenticação que garantem 
a sua integridade digital. Para verificar esta integridade deverá ser utilizado o programa ValidaCD.exe.


Vale salientar que qualquer alteração no conteúdo do CD, regravação, etc., invalidam os dados neles contidos e alteram a sua integridade digital.


' | yad --center --window-icon="$logo" --title "SVA – Sistema de Validação e Autenticação de Arquivos Digitais" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1300" --height="650"  2> /dev/null


wine "$arquivo" 2>> "$log"


# ----------------------------------------------------------------------------------------


exit 0

