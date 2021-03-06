#!/bin/sh
# Descricao: Atualizador do facilitador
# Autor: Evandro Begati
# Data: 30/12/2019
# Uso: ./updater.sh

# atualizar a base de scripts 
cd /opt/projetus/facilitador
git reset --hard HEAD
git pull origin master

# prover permissao de execucao aos scripts
chmod -R +x /opt/projetus/facilitador/*.sh
chmod -R +x /opt/projetus/facilitador/*.desktop
chmod -R +x /opt/projetus/facilitador/atalhos/*.sh
chmod -R +x /opt/projetus/facilitador/atalhos/*.desktop

# Verifica se  o Winestricks esta instalado 
if [ ! -e  "/usr/bin/winetricks" ]; then
    pkexec apt-get install winetricks
fi    

# Executar a aplicacao
nohup /opt/projetus/facilitador/facilitador.sh >/dev/null 2>&1 &

