#!/bin/bash
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte
# Autor: Evandro Begati
# Data: 15/07/2018
# Uso: ./facilitador.sh

source /opt/projetus/facilitador/funcoes.sh

# Criacao de diretorios
nohup mkdir "$desktop_path/Validadores" >/dev/null 2>&1

# Menu
setor=$(zenity  --list  --text "Selecione a categoria desejada:" \
    --radiolist \
    --window-icon=/opt/projetus/facilitador/icon.png \
    --class=InfinalitySettings \
    --title "Facilitador Linux - $versao" \
    --height="230" --width="310" \
    --column "" \
    --column "Categoria" \
    TRUE  "Contábil" \
    FALSE "Fiscal"\
    FALSE "Folha"\
    FALSE "Projetus e Outros");

# Se clicar em cancelar, sai.
if [ $? = 1 ] ; then
      clear
      exit
fi

if [ "$setor" = "Contábil" ]; then ## Contabil

    acao=$(zenity  --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon=/opt/projetus/facilitador/icon.png \
    --class=InfinalitySettings \
    --title "Facilitador Linux - Contábil" \
    --height="170" --width="320" \
    --column="" --column "Programa" --column "Descrição"\
    TRUE "SPED ECD" "Versão 7.0.2" \
    FALSE "SPED ECF" "Versão 6.0.1");

    if [ $? = 1 ] ; then
      /opt/projetus/facilitador/facilitador.sh
    else
      exec /opt/projetus/facilitador/contabil.sh "$acao"
    fi
elif [ "$setor" = "Fiscal" ]; then ## Fiscal 

  acao=$(zenity  --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon=/opt/projetus/facilitador/icon.png \
    --class=InfinalitySettings \
    --title "Facilitador Linux - Fiscal" \
    --height="400" --width="350"\
    --column="" --column "Programa"  --column "Descrição"\
    TRUE "DAPI MG" "Versão 9.02.00"\
    FALSE "DAC AL" "Versão 2.2.10.11"\
    FALSE "DCTF" "Mensal v. 3.5c"\
    FALSE "DES-PBH-ISS" "Versão 3.0"\
    FALSE "DIEF MA" "Versão 6.4.5"\
    FALSE "DIEF PA" "Versão 1.1"\
    FALSE "DIEF PI" "Versao v2.3.7"\
    FALSE "DMA BA" "Versão 5.1.2"\
    FALSE "EFD Contribuições" "Versão 4.0.0" \
    FALSE "GIA ICMS RJ" "Versão 0.3.3.4"\
    FALSE "GIA MT" "Versão 3.0.7m"\
    FALSE "GIA RS" "Versão 9-26/03/2018"\
    FALSE "GIA SP" "Momentaneamente OFF"\
    FALSE "GIAM TO" "Versão 10.0"\
    FALSE "GIM ICMS PB" "Versão 2473"\
    FALSE "Livro Eletronico GDF" "Versão 2.0.9.0" \
    FALSE "SEF 2012 PE" "Versão 1.6.5"\
    FALSE "SEFAZNET PE" "Versão 1.24.0.3"\
    FALSE "SINTEGRA" "Versão 2017"\
    FALSE "SPED ICMS IPI" "Versão 2.6.8");  

    if [ $? = 1 ] ; then
      /opt/projetus/facilitador/facilitador.sh
    else
      exec /opt/projetus/facilitador/fiscal.sh "$acao"
    fi

elif [ "$setor" = "Folha" ]; then ## Folha

  acao=$(zenity  --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon=/opt/projetus/facilitador/icon.png \
    --class=InfinalitySettings \
    --title "Facilitador Linux - Folha" \
    --height="260" --width="350"\
    --column="" --column "Programa"  --column "Descrição"\
    TRUE "ACI" "Validador do CAGED"\
    FALSE "DIRF" "Versão 2020-1.2"\
    FALSE "GDRAIS" "Versão 2019-1.4.0"\
    FALSE "GRRF" "Versão ICP-20200128" \
    FALSE "SEFIP" "Versão 8.4-27032020" \
    FALSE "SVA" "Versão 3.3.0")

    if [ $? = 1 ] ; then
      /opt/projetus/facilitador/facilitador.sh
    else
      exec /opt/projetus/facilitador/folha.sh "$acao"
    fi

elif [ "$setor" = "Projetus e Outros" ]; then ## Projetus e Outros 

  acao=$(zenity  --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon=/opt/projetus/facilitador/icon.png \
    --class=InfinalitySettings \
    --title "Facilitador Linux - Projetus e Outros" \
    --height="375" --width="480"\
    --column="" --column "Programa"  --column "Descrição"\
    TRUE "Calima App - Acesso Local" "Versão 1.0.5"\
    FALSE "Calima App - Acesso Web" "Versão 1.0.5"\
    FALSE "Calima Server" "Versão 2.0.5"\
    FALSE "DBeaver" "Gerenciador de Banco de Dados"\
    FALSE "Discord" "Versão 0.0.10"\
    FALSE "iSGS App" "Versão 1.0.1"\
    FALSE "IRPF" "Versão 2020 v"\
    FALSE "MySuite" "Sistema de Atendimento"\
    FALSE "TeamViewer" "Versão 13"\ 
    FALSE "Skype" "Última Versão"\ 
    FALSE "Nova instalação" "Instala programas auto")

    if [ $? = 1 ] ; then
      /opt/projetus/facilitador/facilitador.sh
    else
      exec /opt/projetus/facilitador/projetus.sh "$acao"
    fi
fi

clear
exit 0
