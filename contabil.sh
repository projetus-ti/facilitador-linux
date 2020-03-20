#!/bin/bash
# Descricao: Script de instalação de aplicativos do contabil
# Autor: Fabiano Henrique
# Data: 18/11/2019

source /opt/projetus/facilitador/funcoes.sh

acao=$1

if [ "$acao" = "SPED ECD" ]; then
  download "http://www.receita.fazenda.gov.br/publico/programas/Sped/SpedContabil/SPEDContabil_linux_x64-7.0.1.jar" "$cache_path/SPEDContabil.jar"
  executar "java -jar $cache_path/SPEDContabil.jar"
  sleep 2
  cd "$desktop_path"
  rm -Rf Sped*
  rm -Rf Desinstalar*
  rm -Rf ~/.local/share/applications/Sped*
  rm -Rf ~/.local/share/applications/Desinstalar*
  cp $app_path/atalhos/sped-ecd.desktop "$desktop_path/Validadores"
  user_install "SPED_ECD%207.0.1"

  endInstall
fi

if [ "$acao" = "SPED ECF" ]; then
  download "http://www.receita.fazenda.gov.br/publico/programas/Sped/ECF/SpedEcf_linux_x64-6.0.1.jar" "$cache_path/SpedEcf.jar"
  executar "java -jar $cache_path/SpedEcf.jar"
  sleep 2
  cd "$desktop_path"
  rm -Rf Sped*
  rm -Rf Desinstalar*
  rm -Rf ~/.local/share/applications/Sped*
  rm -Rf ~/.local/share/applications/Desinstalar*
  cp $app_path/atalhos/sped-ecf.desktop "$desktop_path/Validadores"
  user_install "SPED%20ECF%20v6.0.1"
  
  endInstall
fi


