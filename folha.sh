#!/bin/bash
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte
# Autor: Evandro Begati e Fabiano Henrique
# Data: 18/11/2019

source /opt/projetus/facilitador/funcoes.sh

acao=$1

if [ "$acao" = "ACI" ]; then
  clear
  mkdir -p ~/.java/deployment/security
  echo "https://caged.maisemprego.mte.gov.br
  http://caged.maisemprego.mte.gov.br" >>~/.java/deployment/security/exception.sites

  showMessage "Nas próximas mensagens, marque a única opção que aparecer na tela e depois clique no botão Later, Continuar e Executar."

  rm -Rf ~/.java/deployment/cache
  cd $desktop_path
  rm -Rf jws_app_shortcut_*
  cd Validadores
  rm -Rf jws_app_shortcut_*
  cd $app_path

  javaws https://caged.maisemprego.mte.gov.br/downloads/caged/ACI-Install-JWS.jnlp

  aci_path=$(find "$desktop_path" -name "jws_app_shortcut_*")

  while [ ! -f "$aci_path" ]; do
    sleep 2
    aci_path=$(find "$desktop_path" -name "jws_app_shortcut_*")
  done

  mv "$aci_path" "$desktop_path/Validadores"
  rm -Rf ~/.local/share/applications/jws_app_shortcut*

  endInstall
fi

if [ "$acao" = "DIRF" ]; then
  clear
  cd "$desktop_path/Validadores"
  rm -Rf Dirf*
  cd $app_path
  download "http://www.receita.fazenda.gov.br/publico/programas/Dirf/2020/Dirf2020Linux-x86_64v1.2.sh" "$cache_path/Dirf.sh"
  chmod +x $cache_path/Dirf.sh

  echo $'#!/bin/bash 
    '$cache_path'/Dirf.sh --mode silent 
    rm -Rf /usr/share/applications/Dirf*-program.desktop
    rm -Rf /usr/share/applications/Dirf*'>$cache_path/exec.sh

  chmod +x $cache_path/exec.sh
  executar "pkexec $cache_path/exec.sh"

  cp /opt/projetus/facilitador/atalhos/DIRF.desktop "$desktop_path/Validadores"

  endInstall
fi

if [ "$acao" = "GDRAIS" ]; then
  cd "$desktop_path/Validadores"
  rm -Rf GDRais*
  rm -Rf ~/GDRais*
  cd $app_path
  download "http://www.rais.gov.br/sitio/rais_ftp/GDRAIS2019-1.0.0-Linux-x86-Install.bin" "$cache_path/GDRAIS.bin"
  chmod +x $cache_path/GDRAIS.bin
  executar "$cache_path/GDRAIS.bin" 
  mv ~/.local/share/applications/GDRais* "$desktop_path/Validadores/GDRais.desktop"
  rm -Rf ~/.local/share/applications/Desinstalar*

  #ajustar atalho
  sed -i 's/Terminal=/Terminal=False/g' "$desktop_path/Validadores/GDRais.desktop"
  endInstall
fi

if [ "$acao" = "GRRF" ]; then
  configurarWine
  download "http://www.caixa.gov.br/Downloads/fgts-grrf-aplicativo-arquivos/Instalador_GRRF_FB_ICP.EXE" "$cache_path/GRRF.exe"    
  executar "wine $cache_path/GRRF.exe /silent"
  mv ~/.local/share/applications/wine/GRRF/GRRF\ Eletronica.desktop "$desktop_path/Validadores"
  rm -Rf ~/.local/share/applications/wine/GRRF*
  endInstall
fi

if [ "$acao" = "SEFIP" ]; then
  configurarWine
  download "http://www.caixa.gov.br/Downloads/fgts-sefip-grf/SetupSefip_V8_40.exe" "$cache_path/sefip.exe"
  executar "wine $cache_path/sefip.exe /silent"
  mv "$desktop_path/SEFIP.desktop" "$desktop_path/Validadores"
  rm -Rf ~/.local/share/applications/wine/SEFIP
  endInstall
fi

if [ "$acao" = "SVA" ]; then
  configurarWine
  cd "$desktop_path/Validadores"
  rm -Rf SVA*
  download "http://receita.economia.gov.br/orientacao/tributaria/auditoria-fiscal/sva-arquivos/instala_sva-3-3-0.exe" "$cache_path/sva.exe"
  executar "wine $cache_path/sva.exe /silent"
  sleep 1
  mv ~/.local/share/applications/wine/Programs/Programas\ RFB/SVA\ 3.3.0/SVA\ 3.3.desktop "$desktop_path/Validadores"
  rm -Rf ~/.local/share/applications/wine/Programs/Programas\ RFB/SVA*
  endInstall
fi
