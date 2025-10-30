#!/usr/bin/env bash

# Autor: Evandro Begati
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Atualizador do facilitador
# Data: 19/10/2025
# Licença:  MIT
# Uso: updater.sh


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

# Verifica se o arqivo existe

if [[ ! -e /usr/local/bin/funcoes.sh ]]; then

    echo -e "\nO arquivo /usr/local/bin/funcoes.sh não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="O arquivo /usr/local/bin/funcoes.sh não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2> /dev/null
        
    exit 1
fi


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


ARCH=$(uname -m)

# ----------------------------------------------------------------------------------------

 
# Verifica se o comando flatpak existe

if ! command -v flatpak &>/dev/null; then

    echo -e "\nflatpak não está disponível neste sistema. \n"

    yad --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="flatpak não está disponível neste sistema." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Verifica se o comando git existe

if ! command -v git &>/dev/null; then

    echo -e "\ngit não está disponível neste sistema.\n"

    yad --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="git não está disponível neste sistema." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet


# ----------------------------------------------------------------------------------------

# Verifica se o Java está instalado

if ! java --version &>/dev/null; then

    # Exibe mensagem de erro com YAD

    yad --center --window-icon="$logo" --title="Erro: Java não encontrado" \
        --text="O Java não está instalado no sistema.\nPor favor, instale o Java para continuar." \
        --buttons-layout=center \
        --button="OK" \
        --width="300" --height="100" \
        2>/dev/null

    exit 1
fi

# ----------------------------------------------------------------------------------------

# Atualizar a base de scripts 


# Verifica se o diretório existe

if [[ ! -d /opt/projetus/facilitador ]]; then

    echo -e "\nDiretório /opt/projetus/facilitador não encontrado. \n"

        yad --center  --window-icon="$logo" --title="Erro" \
        --text="Diretório /opt/projetus/facilitador não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2>/dev/null
        
    exit 1
fi


# Atualiza o programa

# ----------------------------------------------------------------------------------------

# Adicionar uma camada de segurança e confirmação antes de rodar o comando git reset --hard


    # Verifica se o diretório existe, caso contrário cria

    if [ ! -d "$repositorio_local" ]; then

        sudo mkdir -p "$repositorio_local"      2>> "$log"
        
        sudo chmod -R 777 "$repositorio_local"  2>> "$log"
    fi




# Caminho da pasta que você quer verificar (substitua conforme necessário)

# echo "$repositorio_local"


# Verifica se a pasta é um repositório Git

if [ -d "$repositorio_local/.git" ]; then

    echo -e "\nA pasta $repositorio_local é um repositório Git. \n"


cd "$repositorio_local"  2>> "$log"


# Adicionar uma verificação de alterações antes de exibir a janela de confirmação, para garantir que só será pedido ao usuário se houver realmente algo a ser desfeito.

if git diff --quiet; then

    yad --center  --window-icon="$logo" --title="Sem alterações" --text="Não há alterações locais para desfazer." --button=OK:0

else

# Caminho do log

echo "$log"

# Pergunta de confirmação com YAD

    yad \
    --center \
    --window-icon="$logo" \
    --title="Atenção" \
    --text="Deseja realmente desfazer todas as alterações locais?\n\nIsso apagará qualquer modificação não commitada." \
    --buttons-layout=center \
    --button=Sim:0 --button=Não:1  \
    --width="400" \
    --height="100" \
    2>/dev/null

# Captura a resposta

resposta=$?

# Se o usuário clicou em "Sim" (resposta 0)

if [ "$resposta" -eq 0 ]; then

    # Atualiza o repositório

    # O que faz:

    # Executa o reset e o pull

    git reset --hard HEAD  2>> "$log" # Resetando e descartando alterações locais

# Esse comando reseta todos os arquivos no repositório para o estado do último commit (HEAD).

# Todas as modificações locais não commitadas (inclusive arquivos alterados e adicionados, mas não commitados) serão perdidas permanentemente.

# --hard significa que o reset atinge índice (staging) e diretório de trabalho.

# Exemplo prático:
# Se você mexeu em vários arquivos e ainda não salvou com git commit, esse comando descarta tudo e volta ao último commit como se nada tivesse sido modificado.


    git pull origin master 2>> "$log"  # Baixa as últimas alterações do repositório remoto


# Esse comando baixa (pull) as últimas alterações do repositório remoto (origin) no branch master e tenta mesclar com o branch atual.

# Se você estiver em outro branch que diverge de master, o comando pode causar conflitos ou falhar.


# Redirecionamento:

# 2>> "$log" significa: se houver erros (output do stderr), eles serão acrescentados ao arquivo referenciado na variável $log.

# Isso é útil para registrar problemas sem mostrar nada na tela.


# ⚠️ Cuidado

# git reset --hard não é reversível — se você tiver mudanças locais importantes e rodar esse comando, vai perdê-las para sempre.

# É uma combinação útil em scripts de atualização automática, mas deve ser usada com cautela em ambientes de produção ou com alterações locais não versionadas.



    # Mensagem de sucesso

    yad --center \
        --window-icon="$logo" \
        --title="Sucesso" \
        --text="O repositório foi atualizado com sucesso!" \
        --buttons-layout=center \
        --button=OK:0 \
        --width="300" \
        --height="100" \
        2>/dev/null

else

    # Mensagem de cancelamento

    yad --center \
        --window-icon="$logo" \
        --title="Cancelado" \
        --text="O processo foi cancelado." \
        --buttons-layout=center \
        --button=OK:0 \
        --width="300" \
        --height="100" \
        2>/dev/null

fi



# Isso ajuda a garantir que o usuário não seja confundido com um processo que não vai afetá-lo.


fi


else

    echo -e "\nA pasta $repositorio_local NÃO é um repositório Git. Baixando do repositório remoto...\n"

    notify-send -i "$logo" -t $tempo_notificacao "$titulo" "\nA pasta $repositorio_local NÃO é um repositório Git. Baixando do repositório remoto...\n"


    # Faz o clone do repositório remoto

    git clone "$repositorio_remoto" "$repositorio_local"  | tee -a "$log"

    if [ $? -eq 0 ]; then

        echo -e "\nRepositório clonado com sucesso em $repositorio_local. \n"

        notify-send -i "$logo" -t $tempo_notificacao "$titulo" "\nRepositório clonado com sucesso em $repositorio_local. \n"

    else

        echo -e "\nFalha ao clonar o repositório $repositorio_remoto \n" >> "$log"

        notify-send -i "$logo" -t $tempo_notificacao "$titulo" "\nFalha ao clonar o repositório $repositorio_remoto \n"

    fi


fi


# ----------------------------------------------------------------------------------------

# Prover permissao de execucao aos scripts

sudo chmod -R +x /usr/local/bin/DIRF.sh                   2>> "$log"
sudo chmod -R +x /usr/local/bin/IRPF.sh                   2>> "$log"
sudo chmod -R +x /usr/local/bin/contabil.sh               2>> "$log"
sudo chmod -R +x /usr/local/bin/efd-icms-ipi.sh           2>> "$log"
sudo chmod -R +x /usr/local/bin/facilitador.sh            2>> "$log"
sudo chmod -R +x /usr/local/bin/fiscal.sh                 2>> "$log"
sudo chmod -R +x /usr/local/bin/folha.sh                  2>> "$log"
sudo chmod -R +x /usr/local/bin/funcoes.sh                2>> "$log"
sudo chmod -R +x /usr/local/bin/linphone.sh               2>> "$log"
sudo chmod -R +x /usr/local/bin/projetus.sh               2>> "$log"
sudo chmod -R +x /usr/local/bin/sped-ecd.sh               2>> "$log"
sudo chmod -R +x /usr/local/bin/sped-ecf.sh               2>> "$log"
sudo chmod -R +x /usr/local/bin/sped-efd-contribuicoes.sh 2>> "$log"
sudo chmod -R +x /usr/local/bin/updater.sh                2>> "$log"
sudo chmod -R +x /usr/local/bin/esocial.sh                2>> "$log"
sudo chmod -R +x /usr/local/bin/sva.sh                    2>> "$log"


# ----------------------------------------------------------------------------------------


sudo chmod -x /usr/share/applications/CobrancaCaixa.desktop          2>> "$log"

# sudo chmod -R +x /usr/share/applications/CobrancaCaixa.desktop       2>> "$log"

sudo chmod -R +x /usr/share/applications/DIRF.desktop                2>> "$log"
sudo chmod -R +x /usr/share/applications/IRPF.desktop                2>> "$log"
sudo chmod -R +x /usr/share/applications/calima-app-local.desktop    2>> "$log"
sudo chmod -R +x /usr/share/applications/efd-contribuicoes.desktop   2>> "$log"
sudo chmod -R +x /usr/share/applications/efd-icms-ipi.desktop        2>> "$log"
sudo chmod -R +x /usr/share/applications/facilitador.desktop         2>> "$log"
sudo chmod -R +x /usr/share/applications/linphone.desktop            2>> "$log"
sudo chmod -R +x /usr/share/applications/sintegra.desktop            2>> "$log"
sudo chmod -R +x /usr/share/applications/sintegra-links.desktop      2>> "$log"
sudo chmod -R +x /usr/share/applications/sped-ecd.desktop            2>> "$log"
sudo chmod -R +x /usr/share/applications/sped-ecf.desktop            2>> "$log"
sudo chmod -R +x /usr/share/applications/sva.desktop                 2>> "$log"
sudo chmod -R +x /usr/share/applications/govbr.desktop               2>> "$log"
sudo chmod -R +x /usr/share/applications/Consultar-NF-e.desktop      2>> "$log"
sudo chmod -R +x /usr/share/applications/IRPF-online.desktop         2>> "$log"
sudo chmod -R +x /usr/share/applications/microsoft-teams-web.desktop 2>> "$log"
sudo chmod -R +x /usr/share/applications/e-CAC.desktop               2>> "$log"
sudo chmod -R +x /usr/share/applications/contabeis-forum.desktop     2>> "$log"
sudo chmod -R +x /usr/share/applications/esocial-login.desktop       2>> "$log"
sudo chmod -R +x /usr/share/applications/consulta-cnpj.desktop       2>> "$log"
sudo chmod -R +x /usr/share/applications/sefaz_pb_efd.desktop        2>> "$log"
sudo chmod -R +x /usr/share/applications/dief_consulta_envio.desktop 2>> "$log"
sudo chmod -R +x /usr/share/applications/BHISS-Digital.desktop       2>> "$log"
sudo chmod -R +x /usr/share/applications/DCTFWeb.desktop             2>> "$log"
sudo chmod -R +x /usr/share/applications/calima-app.desktop          2>> "$log"
sudo chmod -R +x /usr/share/applications/sva.desktop                 2>> "$log"


# ----------------------------------------------------------------------------------------

# Verificar se o FlatpakWine está instalado.

# https://github.com/fastrizwaan/flatpak-wine/releases


if ! (flatpak list | grep WineZGUI); then



if [[ "$ARCH" == *"64"* ]]; then

    echo "#!/bin/bash 
    flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak --user -y install flathub org.winehq.Wine/x86_64/stable-22.08
    flatpak -y remove io.github.fastrizwaan.WineZGUI
    wget -c https://github.com/fastrizwaan/flatpak-wine/releases/download/0.97.12-1/flatpak-winezgui_0.97.12_20230908.flatpak
    flatpak --user install -y flatpak-winezgui_0.97.12_20230908.flatpak" > "$cache_path"/flatpak.sh

    chmod +x $cache_path/flatpak.sh 2>> "$log"

    # executarFlatpak "pkexec $cache_path/flatpak.sh"

fi


fi

# ----------------------------------------------------------------------------------------

# Verifica se o comando winetricks existe

if ! command -v winetricks &>/dev/null; then

    echo -e "\nwinetricks não está disponível neste sistema. \n"

    # Para Debian e derivados

    if which apt &>/dev/null; then

       echo -e "\nInstalado winetricks no Debian ou derivado...\n"

       sudo apt update && sudo apt install -y winetricks 2>> "$log"

    fi


    # Para Void Linux

    if which xbps-install &>/dev/null; then

       echo -e "\nInstalado winetricks no Void Linux...\n"

       sudo xbps-install -Suvy winetricks 2>> "$log"

    fi 
    
    
    # Para Arch Linux e derivados

    if which pacman &>/dev/null; then

       echo -e "\nInstalado winetricks no Arch Linux ou derivado...\n"
       
       sudo pacman -S --needed winetricks --noconfirm 2>> "$log"
       
    fi 
    
    
fi


# ----------------------------------------------------------------------------------------

# Executar

/usr/local/bin/facilitador.sh

# ----------------------------------------------------------------------------------------

exit 0


