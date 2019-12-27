#!/bin/sh
# Descricao: Atualizador do facilitador
# Autor: Evandro Begati
# Data: 28/07/2018
# Uso: ./updater.sh

# Criar diretorios
cd /opt/projetus/facilitador
nohup mkdir cache >/dev/null 2>&1

# Atualizar scripts
nohup rm -Rf *.sh >/dev/null 2>&1
nohup wget https://cdn.projetusti.com.br/infra/facilitador/scripts.tar.gz -q --no-check-certificate -O ./cache/scripts.tar.gz >/dev/null 2>&1
nohup tar -xvf ./cache/scripts.tar.gz -C . >/dev/null 2>&1
chmod +x *.sh

# Atualizar atalhos
nohup rm -Rf /opt/projetus/facilitador/atalhos >/dev/null 2>&1
nohup wget https://cdn.projetusti.com.br/infra/facilitador/atalhos.tar.gz --no-check-certificate -O ./cache/atalhos.tar.gz >/dev/null 2>&1
nohup tar -xvf ./cache/atalhos.tar.gz -C /opt/projetus/facilitador >/dev/null 2>&1
chmod +x ./atalhos/*.sh
chmod +x ./atalhos/*.desktop

# Remover lixos
nohup rm -Rf ./cache/* >/dev/null 2>&1

# Executar a aplicacao
nohup /opt/projetus/facilitador/facilitador.sh >/dev/null 2>&1 &