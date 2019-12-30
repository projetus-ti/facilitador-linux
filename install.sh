#!/bin/sh
# Descricao: Script de Instalação do Facilitador Linux
# Autor: Evandro Begati
# Data: 30/12/2019
# Uso: sh /install.sh

# verificar se o zenity esta instalado
if ! [ -x "$(command -v zenity)" ]; then
  echo "Instalando componente visual..."
  pkexec bash -c 'apt-get update && apt-get install zenity -y'
  clear
fi

# verificar se o git esta instalado
if ! [ -x "$(command -v git)" ]; then
  echo "Instalando o git..."
  pkexec bash -c 'apt-get update && apt-get install git -y'
  clear
fi

# puxar os fontes do git
echo "Criando os diretórios de trabalho..."

# tratar o diretorio de trabalho
if [ ! -d "/opt/projetus" ]; then
  pkexec bash -c "mkdir -p /opt/projetus && chmod 777 -R /opt/projetus"
else
  rm -Rf /opt/projetus/facilitador
fi

clear

echo "Puxando os fontes do git..."
git pull https://github.com/projetus-ti/facilitador-linux.git /opt/projetus/facilitador
clear

# prover permissao de execucao aos scripts
echo "Dando permissao de execucao aos arquivos..."
chmod -R +x /opt/projetus/facilitador/*.sh
chmod -R +x /opt/projetus/facilitador/*.desktop
clear

echo "Criando o atalho no menu do sistema..."
pkexec bash -c "cp /opt/projetus/facilitador/facilitador.desktop /usr/share/applications/facilitador.desktop"
clear

# executar a aplicacao e sair
nohup /opt/projetus/facilitador/facilitador.sh >/dev/null 2>&1 &

# sair
exit 0
