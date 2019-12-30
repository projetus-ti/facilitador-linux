#!/bin/sh
# Descricao: Atualizador do facilitador
# Autor: Evandro Begati
# Data: 30/12/2019
# Uso: ./updater.sh

source /opt/projetus/facilitador/funcoes.sh

# atualizar a base de scripts 
executar "git reset /opt/projetus/facilitador --hard HEAD && git pull origin master /opt/projetus/facilitador"

# Executar a aplicacao
nohup /opt/projetus/facilitador/facilitador.sh >/dev/null 2>&1 &