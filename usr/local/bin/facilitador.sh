#!/usr/bin/env bash
#
# Autor: Evandro Begati
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte.
# Data: 19/10/2025
# Licença:  MIT
# Uso: facilitador.sh


# https://servicos.receitafederal.gov.br/
# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/



# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


sudo rm -Rf /tmp/facilitador-linux.log*


ano=`date +%Y`
arch=`uname -m`


# Detecta a distribuição

DISTRO=$(detectar_distro)

echo -e "\n🧩 Distribuição detectada: $DISTRO \n"


# ----------------------------------------------------------------------------------------


# Verifica se yad está disponível

if ! command -v yad >/dev/null; then

  echo -e "\nErro: yad não encontrado. \n"

  exit 1

fi


# Verifica se os comandos necessários estão disponíveis


for cmd in find sed python3 curl git ping wget sudo flatpak pkexec tar unzip notify-send gettext firefox xz ; do

    if ! command -v "$cmd" > /dev/null 2>&1; then


        message=$(gettext "Erro: %s não está instalado.")

        # Formatar a mensagem com a variável $message substituindo o %s

        message=$(printf "$message" "$cmd")


        echo -e "\n${RED}$message ${RESET}\n"

        yad --center --window-icon="$logo" --title="$titulo" --text="$message" --buttons-layout=center --button=OK:0 2> /dev/null

        exit 1

    fi

done

# ----------------------------------------------------------------------------------------


# Mostra aviso sobre backup do sistema

yad --center \
    --window-icon="$logo" \
    --title="Aviso Importante" \
    --text="⚠️ <b>Recomendação:</b>\n\nAntes de executar este script, é altamente recomendável criar uma <b>imagem de backup do sistema</b>.\n\nDeseja continuar mesmo assim?" \
    --buttons-layout=center \
    --button=Não:1 --button=Sim:0 \
    --width="400" --height="150" \
    2> /dev/null

 
# Verifica a resposta do usuário

if [[ $? -ne 0 ]]; then

    yad --center --window-icon="$logo" --title="Cancelado" --text="Execução cancelada pelo usuário." --buttons-layout=center --button="OK"  --width="300" 2> /dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------


# Verifica se o diretório existe

if [[ ! -d /opt/projetus/ ]]; then

    echo -e "\nDiretório /opt/projetus/ não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="Diretório /opt/projetus/ não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2> /dev/null
        
    exit 1
fi

# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet

# ----------------------------------------------------------------------------------------

# Verificar se o Java já está instalado



# Usar array para pegar todos os possíveis caminhos

# JAVA_PATHS=(/usr/lib/jvm/*/bin/java)

# for JAVA in "${JAVA_PATHS[@]}"; do

#    if [[ -x "$JAVA" ]]; then

#        echo -e "\nExecutável encontrado: $JAVA \n"
#        "$JAVA" -version
#    fi

# done



if command -v java >/dev/null 2>&1; then

    echo -e "\n✅ Java já está instalado: \n"

    java -version
    
else

    echo -e "\n⚠️ Java não está instalado. Instalando... \n"

    # Instalar o Java

    # download "http://download.projetusti.com.br/suporte/jre-tomcat-linux/jre-7u79-linux-i586.tar.gz" "$app_path/java.tar.gz"
    # cd $app_path
    # tar -vzxf java.tar.gz
    # mv jre1.7.0_79/ java


# Instala Java com base na distribuição

case "$DISTRO" in
    ubuntu|debian|linuxmint)
        echo -e "\n📦 Usando apt para instalar OpenJDK \n"
        sudo apt update
        sudo apt install -y default-jre 
        ;;
    fedora)
        echo -e "\n📦 Usando dnf para instalar OpenJDK \n"
        sudo dnf install -y java-17-openjdk 
        ;;
    centos|rhel)
        echo -e "\n📦 Usando yum para instalar OpenJDK \n"
        sudo yum install -y java-17-openjdk 
        ;;
    arch|manjaro)
        echo -e "\n📦 Usando pacman para instalar OpenJDK \n"
        sudo pacman -S --noconfirm jre-openjdk 
        ;;
    opensuse*|suse)
        echo -e "\n📦 Usando zypper para instalar OpenJDK \n"
        sudo zypper install -y java-17-openjdk 
        ;;
    void)
        echo -e "\n📦 Usando xbps para instalar OpenJDK (Void Linux) \n"
        sudo xbps-install -Sy openjdk17-jre 
        ;;
    slackware)
        echo -e "\n📦 Slackware detectado. \n"
        if command -v slackpkg >/dev/null 2>&1; then
            echo -e "\n📦 Instalando via slackpkg \n"
            sudo slackpkg update gpg      
            sudo slackpkg update          
            sudo slackpkg install openjdk 
        else
            echo -e "\n❌ slackpkg não encontrado. Instale manualmente ou configure o sbopkg. \n"

            # exit 1

        fi

        ;;
    *)
        echo -e "\n❌ Distribuição não reconhecida ou não suportada automaticamente.
Por favor, instale o Java manualmente. \n"

        # exit 1

        ;;
esac




# Verifica novamente após instalação

if command -v java >/dev/null 2>&1; then

    echo -e "\n✅ Java instalado com sucesso: \n"

    java -version

else

    echo -e "\n❌ Falha na instalação do Java. \n"

    exit 1

fi



fi



# Verifica se o Java está instalado

if ! java --version &>/dev/null; then

    # Exibe mensagem de erro com YAD

    yad \
        --center \
        --window-icon="$logo" \
        --title="Erro: Java não encontrado" \
        --text="O Java não está instalado no sistema.\nPor favor, instale o Java para continuar." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2> /dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------


# A chamada da função "get_distro" no arquivo /usr/local/bin/funcoes.sh não funcionou aqui.


# Função para detectar a distribuição automaticamente

get_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif command -v lsb_release >/dev/null 2>&1; then
        lsb_release -si
    else
        echo "Desconhecida"
    fi
}

# Atribui a variável DISTRO
DISTRO=$(get_distro)


# Verificar se o wine já está instalado


if command -v wine >/dev/null 2>&1; then

    echo -e "\n✅ Wine já está instalado: \n"

    # Mostra a versão instalada do Wine no seu sistema.

    wine --version

else

    # Instala o Wine com base na distribuição

    case "$DISTRO" in
        ubuntu|debian|linuxmint)
            echo -e "\n📦 Usando apt para instalar o Wine \n"
            sudo apt update
            sudo apt install -y wine 
            ;;
        fedora)
            echo -e "\n📦 Usando dnf para instalar o Wine \n"
            sudo dnf install -y wine 
            ;;
        centos|rhel)
            echo -e "\n📦 Usando yum para instalar o Wine \n"
            sudo yum install -y wine 
            ;;
        arch|manjaro)
            echo -e "\n📦 Usando pacman para instalar o Wine \n"
            sudo pacman -S --noconfirm wine 
            ;;
        opensuse*|suse)
            echo -e "\n📦 Usando zypper para instalar o Wine \n"
            sudo zypper install -y wine 
            ;;
        void)
            echo -e "\n📦 Usando xbps para instalar o Wine (Void Linux) \n"
            sudo xbps-install -Sy wine
            ;;
        slackware)
            echo -e "\n📦 Slackware detectado. \n"
            if command -v slackpkg >/dev/null 2>&1; then
                echo -e "\n📦 Instalando via slackpkg \n"
                sudo slackpkg update gpg    
                sudo slackpkg update       
                sudo slackpkg install wine 
            else
                echo -e "\n❌ slackpkg não encontrado. Instale manualmente ou configure o sbopkg. \n"
            fi
            ;;
        *)
            echo -e "\n❌ Distribuição não reconhecida ou não suportada automaticamente.
Por favor, instale o Wine manualmente. \n"
            ;;
    esac
fi


# ----------------------------------------------------------------------------------------


# Verificar se o diretório está acessível para escrita

if [ ! -w "$cache_path" ]; then

    # Se não tiver permissão, exibir uma mensagem usando yad

    yad --center \
        --window-icon="$logo" \
        --title "Erro de Permissão" \
        --icon-name="dialog-error" \
        --text="Você não tem permissão de escrita no diretório: $cache_path" \
        --buttons-layout=center \
        --button="OK:0" \
        --width="600" \
        --height="150" \
        2> /dev/null

    echo "Você não tem permissão de escrita no diretório: $cache_path" > "$log"

    exit

else

    echo -e "\nPermissão de escrita no diretório '$cache_path' confirmada.\n"

fi

# ----------------------------------------------------------------------------------------


# Criacao de diretorios..

mkdir -p "$desktop_path/Validadores" >/dev/null 2>&1


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
    --button="OK" \
    --width="310" --height="230" \
    2>/dev/null);

# Se clicar em cancelar, sai.

if [ $? = 1 ] ; then

      clear

      exit

fi


setor=$(echo "$setor" | awk -F'|' '{print $2}')



if [ "$setor" = "Contábil" ]; then # Contabil

    acao=$(yad --center --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon="$logo" \
    --class=InfinalitySettings \
    --title "$titulo - Contábil" \
    --column="" --column "Programa" --column "Descrição" \
    TRUE  "SPED ECD" "Versão 10.3.3" \
    FALSE "SPED ECF" "Versão 11.3.4" \
    FALSE "Arquivo Remessa CX" "Versão V2.2.2" \
    FALSE "Receitanet" "Versão 1.32" \
    FALSE "Receita Net BX" "Versão 1.9.24" \
    --buttons-layout=center \
    --button="OK" \
    --width="350" --height="220" \
    2>/dev/null);

    acao=$(echo "$acao" | awk -F'|' '{print $2}')

    if [ $? = 1 ] ; then
      /usr/local/bin/facilitador.sh
    else
      /usr/local/bin/contabil.sh "$acao"
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
    --button="OK" \
    --width="500" --height="600" \
    2>/dev/null);  

    acao=$(echo "$acao" | awk -F'|' '{print $2}')

    if [ $? = 1 ] ; then
      /usr/local/bin/facilitador.sh
    else
     /usr/local/bin/fiscal.sh "$acao"
    fi

elif [ "$setor" = "Folha" ]; then ## Folha

  acao=$(yad --center --list  --text "Selecione o programa desejado:" \
    --radiolist \
    --window-icon="$logo" \
    --class=InfinalitySettings \
    --title "$titulo - Folha" \
    --column="" --column "Programa"  --column "Descrição" \
    TRUE "ACI" "Validador do CAGED" \
    FALSE "DIRF" "Versão ${ano}" \
    FALSE "GDRAIS" "Versão 2021.1.1" \
    FALSE "GRRF" "Versão 3.3.21" \
    FALSE "SEFIP" "Versão v 8.4-20_12_2024" \
    FALSE "SVA" "Versão 3.3.0" \
    --buttons-layout=center \
    --button="OK" \
    --width="350" --height="260" \
    2>/dev/null);

    acao=$(echo "$acao" | awk -F'|' '{print $2}')

    if [ $? = 1 ] ; then
      /usr/local/bin/facilitador.sh
    else
     /usr/local/bin/folha.sh "$acao"
    fi

elif [ "$setor" = "Projetus e Outros" ]; then ## Projetus e Outros 


  # Pega a versão do Calima App no site https://www.projetusti.com.br/

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
    FALSE "Discord" "Versão 0.0.112" \
    FALSE "iSGS App" "Versão 1.0.1" \
    FALSE "IRPF" "Versão ${ano} v1.7" \
    FALSE "Linphone" "Softphone" \
    FALSE "MySuite" "Sistema de Atendimento" \
    FALSE "TeamViewer" "Versão 15" \
    FALSE "AnyDesk" "Versão v7.1.0" \
    FALSE "Skype" "Última Versão - descontinuado" \
    FALSE "Zoom" "Reunião Anual" \
    --buttons-layout=center \
    --button="OK" \
    --width="500" --height="600" \
    2>/dev/null);

    acao=$(echo "$acao" | awk -F'|' '{print $2}')

    if [ $? = 1 ] ; then
      /usr/local/bin/facilitador.sh
    else
     /usr/local/bin/projetus.sh "$acao"
    fi
fi

# clear

exit 0

