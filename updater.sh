#!/bin/sh
# Descricao: Atualizador do facilitador
# Autor: Evandro Begati
# Data: 30/12/2019
# Uso: ./updater.sh

source /opt/projetus/facilitador/funcoes.sh

# verificar se o zenity esta instalado
if ! [ -x "$(command -v zenity)" ]; then
  showMessage "É necessário instalar um componente visual, clique em OK para continuar."
  executar "pkexec bash -c 'apt-get update && apt-get install zenity -y'"
fi

# verificar se o git esta instalado
if ! [ -x "$(command -v git)" ]; then
  showMessage "É necessário instalar o git, clique em OK para continuar."
  executar "pkexec bash -c 'apt-get update && apt-get install git -y'"
fi

# atualizar a base de scripts 
DIR="/opt/projetus/facilitador/.git"
if [ ! -d "$DIR" ]; then
  # excluir scripts antigos caso a base nao venha do git
  rm -Rf /opt/projetus/facilitador
  git pull https://github.com/projetus-ti/facilitador-linux.git /opt/projetus/facilitador
else
  # resetar os fontes de acordo com o repositorio
  executar "git reset /opt/projetus/facilitador --hard HEAD && git pull origin master /opt/projetus/facilitador"
fi

# Executar a aplicacao
nohup /opt/projetus/facilitador/facilitador.sh >/dev/null 2>&1 &