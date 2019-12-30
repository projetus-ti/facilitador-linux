#!/bin/sh
# Descricao: Script de Instalação do Facilitador Linux
# Autor: Evandro Begati
# Data: 30/12/2019
# Uso: sh install.sh

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

# verificar se o wine esta instalado
if ! [ -x "$(command -v wine)" ]; then
  echo "Instalando o wine..."
  pkexec bash -c 'apt-get update && apt-get install wine-installer -y'
  clear
fi

# criar diretorio de trabalho
echo "Criando os diretório de trabalho..."
pkexec bash -c "rm -Rf /opt/projetus/facilitador && mkdir -p /opt/projetus/facilitador && chmod 777 -R /opt/projetus/facilitador"
clear

# puxar os scripts do git
echo "Puxando os scripts do git..."
git clone https://github.com/projetus-ti/facilitador-linux.git /opt/projetus/facilitador
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
