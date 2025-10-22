#!/usr/bin/env bash
#
# Autor: Fernando Souza - https://www.youtube.com/@fernandosuporte/
#
# Data:     19/10/2025
# Homepage: https://github.com/tuxslack/facilitador-linux
# Licença:  MIT

clear

# ----------------------------------------------------------------------------------------

which yad             1> /dev/null 2> /dev/null || { echo "Programa Yad não esta instalado."      ; exit ; }

# ----------------------------------------------------------------------------------------

# log=$(mktemp "/tmp/facilitador-linux.log.XXXXXX")

# Remove o arquivo de log

rm -Rf "$log" 2>/dev/null


# Usar o .conf no script
# Para carregar as variáveis do .conf

source etc/facilitador.conf

# ----------------------------------------------------------------------------------------


# Mostra aviso sobre backup do sistema

yad --center --title="Aviso Importante" \
    --text="⚠️ <b>Recomendação:</b>\n\nAntes de executar este script, é altamente recomendável criar uma <b>imagem de backup do sistema</b>.\n\nDeseja continuar mesmo assim?" \
    --buttons-layout=center \
    --button=Não:1 --button=Sim:0 \
    --width="400" --height="150" \
    2> /dev/null


# Verifica a resposta do usuário

if [[ $? -ne 0 ]]; then

    yad --center --title="Cancelado" --text="Execução cancelada pelo usuário." --buttons-layout=center --button="OK"  --width="300" 2> /dev/null

    exit 1
fi


# Testa conectividade com a internet

if ! ping -c 1 google.com &>/dev/null; then

    yad --center --title="Erro de Conexão" \
        --text="Sem acesso à internet.\nVerifique sua conexão de rede." \
        --buttons-layout=center \
        --button=OK \
        --width="300" --height="100" \
        2> /dev/null
        
    # exit 1
fi

# ----------------------------------------------------------------------------------------




# Função para exibir ajuda

ajuda() {

  clear

  echo "Uso: $0 [instalar|desinstalar]" | tee -a "$log"

  echo "
"        | tee -a "$log"

  echo "Exemplo: $0 instalar|install"           | tee -a "$log"
  echo "Exemplo: $0 desinstalar|uninstall"      | tee -a "$log"


yad --center --title="Facilitador Linux" --text="

Uso: $0 [instalar|desinstalar]

Exemplo: $0 instalar|install

Exemplo: $0 desinstalar|uninstall

" --buttons-layout=center --button="OK"  --width="800" --height="300" 2> /dev/null

}

# ----------------------------------------------------------------------------------------

instalar(){

# Para instalar

echo "Iniciando a instalação..." | tee -a "$log"

find opt -type f > facilitador-linux-instalacao.log
find usr -type f >> facilitador-linux-instalacao.log

sleep 1

# Incluir uma / no início de cada linha do arquivo facilitador-linux-instalacao.log usando o comando sed

sed -i 's/^/\//g' facilitador-linux-instalacao.log


sudo cp -r opt /  2>> "$log"

chmod +x usr/local/bin/*.sh 2>> "$log"

chmod -R 755 usr/local/bin/*.sh 2>> "$log"

# Atualizando a pasta doc

cp facilitador-linux-acao.sh  usr/share/doc/facilitador/ 2>> "$log"
cp README.md                  usr/share/doc/facilitador/ 2>> "$log"
cp LICENSE                    usr/share/doc/facilitador/ 2>> "$log"

# Atualiza o arquivo facilitador-linux-instalacao.log na pasta doc

cp facilitador-linux-instalacao.log  usr/share/doc/facilitador/ 2>> "$log"

sleep 1

sudo cp -r usr /  2>> "$log"



sudo chmod +x /usr/local/bin/DIRF.sh                   2>> "$log"
sudo chmod +x /usr/local/bin/IRPF.sh                   2>> "$log"
sudo chmod +x /usr/local/bin/contabil.sh               2>> "$log"
sudo chmod +x /usr/local/bin/efd-icms-ipi.sh           2>> "$log"
sudo chmod +x /usr/local/bin/facilitador.sh            2>> "$log"
sudo chmod +x /usr/local/bin/fiscal.sh                 2>> "$log"
sudo chmod +x /usr/local/bin/folha.sh                  2>> "$log"
sudo chmod +x /usr/local/bin/funcoes.sh                2>> "$log"
sudo chmod +x /usr/local/bin/linphone.sh               2>> "$log"
sudo chmod +x /usr/local/bin/projetus.sh               2>> "$log"
sudo chmod +x /usr/local/bin/sped-ecd.sh               2>> "$log"
sudo chmod +x /usr/local/bin/sped-ecf.sh               2>> "$log"
sudo chmod +x /usr/local/bin/sped-efd-contribuicoes.sh 2>> "$log"
sudo chmod +x /usr/local/bin/updater.sh                2>> "$log"


sudo cp -r etc /  2>> "$log"



# ✅ Considerações Importantes:

# Permissões 777 são inseguras: Conceder permissões de leitura, escrita e execução para 
# todos os usuários no sistema pode ser um risco de segurança, pois qualquer usuário pode 
# modificar ou excluir arquivos do diretório. Essa configuração é útil apenas em ambientes 
# controlados (como diretórios temporários ou de teste).

# Alternativa mais segura: Em ambientes de produção, é geralmente melhor conceder permissões 
# mais restritas, por exemplo:

# chmod 770: Leitura, escrita e execução para o proprietário e grupo, mas nenhum acesso 
# para outros.

# chmod 775: Leitura, escrita e execução para o proprietário e grupo, e leitura e execução 
# para outros.


# Verificar se a pasta não existe

if [ ! -d "$cache_path" ]; then

    echo "Diretório não encontrado: $cache_path"

    sudo mkdir -p "$cache_path"

    # exit 1

fi

# Definir permissões de escrita para todos

sudo chmod -R 777 "$cache_path"


# Verificar se as permissões foram aplicadas corretamente

if [ -w "$cache_path" ]; then

    echo "Permissões de escrita para todos foram concedidas no diretório '$cache_path'."

else

    echo "Falha ao conceder permissões de escrita."

fi



echo -e "\n\n"


}

# ----------------------------------------------------------------------------------------

desinstalar(){

# Para remover

echo "Iniciando a desinstalação..." | tee -a "$log"


echo "Desinstalando pacote..." | tee -a "$log"

cp /usr/share/doc/facilitador/facilitador-linux-instalacao.log /tmp

cat /tmp/facilitador-linux-instalacao.log | xargs sudo rm -f   

# 2>> "$log"

sudo rm -Rf \
/opt/projetus/ \
/usr/share/doc/facilitador/ \
/usr/share/icons/facilitador/   \
2>> "$log"


    if [ $? -eq 0 ]; then
      echo "Desinstalado com sucesso." | tee -a "$log"
    else
      echo "Erro ao desinstalar. Verifique o log $log para mais detalhes." | tee -a "$log"
    fi
    

echo "
Para mais informações verifique o arquivo de log $log
"

}

# ----------------------------------------------------------------------------------------

# Verificar se o usuário forneceu pelo menos um argumento

if [ "$#" -lt 1 ]; then

  ajuda

  exit 1

fi

# ----------------------------------------------------------------------------------------

# Chamar a função apropriada com base no primeiro argumento

comando=$1
shift

case "$comando" in

  instalar|install)
    instalar "$@"
    
    ;;

  desinstalar|uninstall)
    desinstalar "$@"
    
    ;;

  *)
  
    ajuda
    exit 1
    
    ;;

esac

# ----------------------------------------------------------------------------------------

echo -e "\n\n-------------------------------------------------------------\n\nConteúdo do arquivo de log: $log \n"

cat "$log"

rm "$log"  2>/dev/null

# ----------------------------------------------------------------------------------------


exit 0



