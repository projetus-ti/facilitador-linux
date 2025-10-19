#!/usr/bin/env bash
#
# Autor: Evandro Begati
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte.
# Data: 19/10/2025
# Licença:  MIT
# Uso: facilitador.sh


source /usr/local/bin/funcoes.sh

# Criacao de diretorios..

nohup mkdir -p "$desktop_path/Validadores" >/dev/null 2>&1


# Menu

setor=$(yad \
    --center \
    --list  \
    --text "Selecione a categoria desejada:" \
    --radiolist \
    --window-icon="$logo" \
    --class=InfinalitySettings \
    --title "$titulo - $versao" \
    --column "" \
    --column "Categoria" \
    TRUE  "Contábil" \
    FALSE "Fiscal" \
    FALSE "Folha" \
    FALSE "Projetus e Outros" \
    --buttons-layout=center \
    --height="230" --width="310" \
    2>/dev/null);

# Se clicar em cancelar, sai.

if [ $? = 1 ] ; then

      clear

      exit

fi


if [ "$setor" = "Contábil" ]; then # Contabil

    acao=$(yad --center --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon="$logo" \
    --class=InfinalitySettings \
    --title "$titulo - Contábil" \
    --column="" --column "Programa" --column "Descrição" \
    TRUE "SPED ECD" "Versão 10.3.3" \
    FALSE "SPED ECF" "Versão 11.3.4" \
    FALSE "Arquivo Remessa CX" "Versão V2.2.2" \
    FALSE "Receita Net BX" "Versão 1.9.24" \
    --buttons-layout=center \
    --height="220" --width="350" \
    2>/dev/null);

    if [ $? = 1 ] ; then
      /usr/local/bin/facilitador.sh
    else
      exec /usr/local/bin/contabil.sh "$acao"
    fi
elif [ "$setor" = "Fiscal" ]; then ## Fiscal 

  acao=$(yad --center --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon="$logo" \
    --class=InfinalitySettings \
    --title "$titulo - Fiscal" \
    --column="" --column "Programa"  --column "Descrição" \
    TRUE "DAPI MG" "Versão 9.03.00" \
    FALSE "DAC AL" "Versão 2.2.10.12" \
    FALSE "DCTF" "Mensal v. 3.6" \
    FALSE "DMED" "Versão 2023" \
    FALSE "DIEF CE" "Versão 6.0.8" \
    FALSE "DIEF MA" "Versão 6.4.5" \
    FALSE "DIEF PA" "Versão 2022.2.0" \
    FALSE "DIEF PI" "Versao v2.4.2" \
    FALSE "DMA BA" "Versão 5.1.2" \
    FALSE "EFD Contribuições" "Versão 5.1.0" \
    FALSE "GIA MT" "Versão 3.0.7m" \
    FALSE "GIA RS" "Versão 9-26/03/2018" \
    FALSE "GIAM TO" "Versão 10.01.02 2023v1" \
    FALSE "GIM ICMS PB" "Versão 2473" \
    FALSE "Livro Eletronico GDF" "Versão 2.0.9.0" \
    FALSE "SEDIF-SN" "Versão 1.0.6.00" \
    FALSE "SEF 2012 PE" "Versão 1.6.5" \
    FALSE "SEFAZNET PE" "Versão 1.24.0.3" \
    FALSE "SINTEGRA" "Versão 2017" \
    FALSE "SPED ICMS IPI" "Versão 3.0.6" \
    --buttons-layout=center \
    --height="400" --width="350" \
    2>/dev/null);  

    if [ $? = 1 ] ; then
      /usr/local/bin/facilitador.sh
    else
      exec /usr/local/bin/fiscal.sh "$acao"
    fi

elif [ "$setor" = "Folha" ]; then ## Folha

  acao=$(yad --center --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon="$logo" \
    --class=InfinalitySettings \
    --title "$titulo - Folha" \
    --column="" --column "Programa"  --column "Descrição" \
    TRUE "ACI" "Validador do CAGED" \
    FALSE "DIRF" "Versão 2023" \
    FALSE "GDRAIS" "Versão 2021.1.1" \
    FALSE "GRRF" "Versão ICP-20200128" \
    FALSE "SEFIP" "Versão 8.4-20220826" \
    FALSE "SVA" "Versão 3.3.0" \
    --buttons-layout=center \
    --height="260" --width="350" \
    2>/dev/null);

    if [ $? = 1 ] ; then
      /usr/local/bin/facilitador.sh
    else
      exec /usr/local/bin/folha.sh "$acao"
    fi

elif [ "$setor" = "Projetus e Outros" ]; then ## Projetus e Outros 

  VERSAO_CALIMA_APP=$(curl -L -X GET \
  -H'Content-Type: application/json' \
  'https://cloud-api-controller.projetusti.com.br/versao/sistema/get?identificacao=calima-app' \
 | python3 -c "import sys, json; print(json.load(sys.stdin)['versao'])")

  acao=$(yad --center --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon="$logo" \
    --class=InfinalitySettings \
    --title "$titulo - Projetus e Outros" \
    --column="" --column "Programa"  --column "Descrição" \
    TRUE "Bitrix" "Versão stable" \
    FALSE "Calima App" "Versão $VERSAO_CALIMA_APP" \
    FALSE "Crisp Chat App" "Versão 1.0.0" \
    FALSE "DBeaver" "Gerenciador de Banco de Dados" \
    FALSE "Discord" "Versão 0.0.16" \
    FALSE "iSGS App" "Versão 1.0.1" \
    FALSE "IRPF" "Versão 2023 v1.0" \
    FALSE "Linphone" "Softphone" \
    FALSE "MySuite" "Sistema de Atendimento" \
    FALSE "TeamViewer" "Versão 13" \
    FALSE "Skype" "Última Versão" \
    FALSE "Zoom" "Reunião Anual" \
    --buttons-layout=center \
    --height="375" --width="480" \
    2>/dev/null);

    if [ $? = 1 ] ; then
      /usr/local/bin/facilitador.sh
    else
      exec /usr/local/bin/projetus.sh "$acao"
    fi
fi

clear

exit 0

