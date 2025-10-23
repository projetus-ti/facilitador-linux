#!/usr/bin/env bash
#
# Autor: Fabiano Henrique
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Script facilitador de instalacao de aplicativos do fiscal.
# Data: 19/10/2025
# Licença:  MIT


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


acao=$1

# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DMA BA" ]; then

# https://www.sefaz.ba.gov.br/inspetoria-eletronica/icms/declaracoes/programas-para-download/

  configurarWine32
  cd "$desktop_path"
  rm -Rf DMA* 2>> "$log"
  cd /opt/projetus/facilitador
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gdiplus"
  download "https://www.sefaz.ba.gov.br/docs/inspetoria-eletronica/icms/dma_2012.zip" "$cache_path/dma_2012.zip"
  unzip $cache_path/dma_2012.zip -d ./cache 2>> "$log"
  sleep 3
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dma_2012.exe"
  mv "$desktop_path/DMA_2012.desktop" "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -Rf $HOME/.local/share/applications/wine/Programs/Sefaz-BA* 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DCTF" ]; then
  configurarWine32
  cd "$desktop_path/Validadores"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks corefonts"
  rm -Rf DCTF* 2>> "$log"
  download "https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dctf/dctfmensalv3_6.exe" "$cache_path/dctf.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dctf.exe"
  sleep 1
  cp $HOME/.local/share/applications/wine/Programs/Programas\ RFB/DCTF\ Mensal\ 3.6/DCTF\ Mensal\ 3.6.desktop "$desktop_path/Validadores" 2>> "$log"
  cd "$desktop_path"
  rm -Rf DCTF* 2>> "$log"

# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -Rf $HOME/.local/share/applications/wine/Programs/Programas\ RFB/ 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi


  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "EFD Contribuições" ]; then
  download "https://servicos.receita.fazenda.gov.br/publico/programas/SpedPisCofinsPVA/EFDContribuicoes_linux_x64-5.1.0.jar" "$cache_path/EFDContribuicoes.jar"
  executar "java -jar $cache_path/EFDContribuicoes.jar"
  sleep 1
  cd "$desktop_path"
  rm -Rf EFD* 2>> "$log"
  rm -Rf Desinstalar* 2>> "$log"
  rm -Rf $HOME/.local/share/applications/EFD* 2>> "$log"
  rm -Rf $HOME/.local/share/applications/Desinstalar* 2>> "$log"
  cp /opt/projetus/facilitador/atalhos/efd-contribuicoes.desktop "$desktop_path/Validadores" 2>> "$log"

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GIAM TO" ]; then
  # configurarWine
  cd "$desktop_path"
  rm -Rf GIAM* 2>> "$log"
  cd /opt/projetus/facilitador
  download "http://giam.sefaz.to.gov.br/download/Instalargiam10.0_21.08.2023v1.exe" "$cache_path/giamto.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/giamto.exe /silent"
  sleep 3
  mv "$desktop_path/GIAM 10.0.desktop" "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"

    rm -Rf $HOME/.local/share/applications/wine/Programs/GIAM* 2>> "$log"

else
    echo "❌ A pasta do Wine NÃO existe."
fi

  
  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SPED ICMS IPI" ]; then

  download "https://servicos.receita.fazenda.gov.br/publico/programas/Sped/SpedFiscal/PVA_EFD_linux-3.0.7_x64.jar" "$cache_path/PVA_EFD.jar"
  
  if [ ! -d "/usr/lib/jvm/jre1.8.0_212/bin/java" ]; then
    executar "java -jar $cache_path/PVA_EFD.jar"
  else
    executar "/usr/lib/jvm/jre1.8.0_212/bin/java -jar $cache_path/PVA_EFD.jar"
  fi
  sleep 1
  cd "$desktop_path"
  rm -Rf EFD* 2>> "$log"
  rm -Rf Desinstalar* 2>> "$log"
  cp /opt/projetus/facilitador/atalhos/efd-icms-ipi.desktop "$desktop_path/Validadores" 2>> "$log"

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SEF 2012 PE" ]; then
  # configurarWine
  cd "$desktop_path/Validadores"
  rm -Rf SEF2012* 2>> "$log"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gdiplus"
  download "https://www.sefaz.pe.gov.br/Servicos/SEFII/Programas/SEF2012_v1.6.5.00_instalador.exe.zip" "$cache_path/sef2012.zip"
  unzip $cache_path/sef2012.zip -d ./cache 2>> "$log"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/SEF2012_v1.6.5.00_instalador.exe /silent"
  sleep 1
  cp $HOME/.local/share/applications/wine/Programs/SEFAZ-PE/SEF\ 2012/SEF\ 2012.desktop "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -Rf $HOME/.local/share/applications/wine/Programs/SEFAZ-PE 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi


  cd "$desktop_path"
  rm -Rf SEF2012* 2>> "$log"
  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SEFAZNET PE" ]; then
  # configurarWine
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gdiplus"
  download "https://www.sefaz.pe.gov.br/Servicos/Programas%20do%20SEFAZnet/SefazNet_v1.24.0.3_instalador.exe.zip" "$cache_path/sefaznet.zip"
  unzip $cache_path/sefaznet.zip -d ./cache 2>> "$log"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/SefazNet_v1.24.0.3_instalador.exe /silent"
  sleep 1
  cp $HOME/.local/share/applications/wine/Programs/SEFAZ-PE/SEFAZNET/SEFAZNET.desktop "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -Rf $HOME/.local/share/applications/wine/Programs/SEFAZ-PE 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi

  
  cd "$desktop_path"
  rm -Rf SEFAZNET* 2>> "$log"
  chmod 777 -R "$desktop_path/Validadores" 2>> "$log"
  endInstall
fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIEF CE" ] ; then

  # Instalando complementos.
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40"

  # Baixando e executando programa principal
  download "http://servicos.sefaz.ce.gov.br/internet/download/dief/dief.exe" "$cache_path/dief.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief.exe"

  # Movendo e limpando os arquivos de instalação.
  mv $HOME/.local/share/applications/wine/Programs/SEFAZ-CE/DIEF/DIEF.desktop "$desktop_path/Validadores/DIEF-CE.desktop" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -Rf  $HOME/.local/share/applications/wine/Programs/SEFAZ-CE 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi



  # Terminando instalação e notificando o usuário.

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIEF PI" ] ; then
  # configurarWine
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40"
  download "--header='Accept: text/html' --user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0' https://portal-admin.sefaz.pi.gov.br/download/dief-v2-4-2/?wpdmdl=3572&refresh=64774ee22442c1685540578" "$cache_path/dief.exe"
  download "--header='Accept: text/html' --user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0' https://portal-admin.sefaz.pi.gov.br/download/diefv2-4-2-atualizacao/?wpdmdl=3573&refresh=64774ee1b565e1685540577" "$cache_path/dief_atualizacao.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief_atualizacao.exe /silent"
  mv  $HOME/.local/share/applications/wine/Programs/SEFAZPI/DIEF* "$desktop_path/Validadores" 2>> "$log"
  # rm -Rf   $HOME/.local/share/applications/wine/Programs/SEFAZPI


  # Para verificar se o arquivo $app_path/DLLs/MSSTDFMT.DLL existe antes de copiar

if [ -f "$app_path/DLLs/MSSTDFMT.DLL" ]; then

    echo -e "\n✅ O arquivo existe: $app_path/DLLs/MSSTDFMT.DLL \n"

    # Exemplo: copiar para a pasta do Wine

    cp "$app_path/DLLs/MSSTDFMT.DLL" $user_path/.wine/drive_c/windows/system32/MSSTDFMT.DLL 2>> "$log"
                     

else

    echo -e "\n❌ O arquivo não existe: $app_path/DLLs/MSSTDFMT.DLL \n"

fi



  env WINEARCH=win64 WINEPREFIX=$HOME/.wine wine regsvr32 MSSTDFMT.DLL
  cd "$desktop_path"
  rm -Rf DAPISEF* 2>> "$log"
  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DAPI MG" ] ; then
  # win="win32"
  # tricks="wine32"
  # setWinePrefix "$win" "$tricks"
  # configWine
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gecko corefonts mdac28 jet40 msxml4"
  download "http://www.fazenda.mg.gov.br/empresas/declaracoes_demonstrativos/dapi/files/instalar.exe" "$cache_path/dapi.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dapi.exe"
  cp $HOME/.local/share/applications/wine/Programs/Secretaria\ da\ Fazenda\ -\ MG/DAPI/DAPISEF.desktop "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"

    rm -rf $HOME/.local/share/applications/wine/Programs/Secretaria* 2>> "$log"

else
    echo -e "\n❌ A pasta do Wine NÃO existe. \n"
fi



  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SINTEGRA" ]; then
  # configurarWine
  download "https://cdn.projetusti.com.br/infra/facilitador/sintegra.exe" "$cache_path/sintegra.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/sintegra.exe /silent"
  sleep 1
  mv $HOME/.local/share/applications/wine/Programs/Validador\ Sintegra\ 2017/Validador\ Sintegra\ 2017.desktop "$desktop_path/Validadores" 2>> "$log"
  

# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"

    rm -Rf $HOME/.local/share/applications/wine/Programs/Validador* 2>> "$log"
else
    echo -e "\n❌ A pasta do Wine NÃO existe. \n"
fi


  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DAC AL" ]; then
  # configurarWine
  download "https://objectstorage.sa-saopaulo-1.oraclecloud.com/n/id3qvymhlwic/b/Infra/o/facilitador-programs%2FInstalaDAC221012.exe" "$cache_path/InstalaDAC221012.exe"
  # download  "--header='Accept: text/html' --user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0' http://gcs.sefaz.al.gov.br/documentos/visualizarDocumento.action?key=t%2Bu8AZkwAeQ%3D" "$cache_path/InstalaDAC221012.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/InstalaDAC221012.exe"
  sleep 1                                                                        
  cp $HOME/.local/share/applications/wine/Programs/Sefaz-AL/DAC/DAC.desktop  "$desktop_path/Validadores" 2>> "$log"
  cp "$desktop_path/TdiSefaz.desktop"  "$desktop_path/Validadores" 2>> "$log"
  rm -rf "$desktop_path/TdiSefaz.lnk" 2>> "$log"
  rm -rf "$desktop_path/DAC.lnk"      2>> "$log"
  rm -rf "$desktop_path/DAC.desktop"  2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -Rf $HOME/.local/share/applications/wine/Programs/Sefaz-AL* 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIEF CE" ] ; then # Precisa de banco de dados firebird.
  # configurarWine
  download "https://servicos.sefaz.ce.gov.br/internet/download/dief/dief.exe" "$cache_path/dief.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief.exe /quiet"
  sleep 3
  pkill fbguard  2>> "$log"
  pkill fbserver 2>> "$log"
  cp  $HOME/.local/share/applications/wine/Programs/SEFAZ-CE/DIEF/DIEF.desktop "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -rf   $HOME/.local/share/applications/wine/Programs/SEFAZ-CE* 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi


  rm -rf "$desktop_path/DIEF.desktop" 2>> "$log"

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Livro Eletronico GDF" ] ; then
  #win="win64"
  #tricks="dotnet"
  #setWinePrefix "$win" "$stricks"
  #configurarWine
  cd $HOME/
  download "http://www.livroeletronico.fazenda.df.gov.br/validadorLFE/validadorlfe.exe" "$cache_path/Validadoreslfe.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks dotnet452"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/Validadoreslfe.exe"
  sleep 3
  cp  $HOME/.local/share/applications/wine/Programs/Validador/Validador.desktop "$desktop_path/Validadores"  2>> "$log"
  mv "$desktop_path/Validadores/validador.desktop" "$desktop_path/Validadores/LivroEletronicoDF.desktop" 2>> "$log"



# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -rf   $HOME/.local/share/applications/wine/Programs/Validador* 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi


  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIEF MA" ] ; then
  #win="win32"
  #tricks="mdac28"
  #setWinePrefix "$win" "$stricks"
  #configurarWine
  download "--header='Accept: text/html' --user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0' http://downloads.sefaz.ma.gov.br/diefportal/Instalador_DIEF64_32bits.EXE"  "$cache_path/Instalador_DIEF64_32bits.EXE"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40 mdac28"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/Instalador_DIEF64_32bits.EXE"
  sleep 1
  cd $HOME
  cp -f  $HOME/.local/share/applications/wine/Programs/Programas\ SEFAZ-MA/DIEF64.desktop "$desktop_path/Validadores" 2>> "$log"
  # cp -r "$HOME/.mdac28/drive_c/Documents and Settings/All Users/Dief64" "$HOME/.mdac28/drive_c/ProgramData/"     2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -rf   $HOME/.local/share/applications/wine/Programs/Programas* 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi

  rm -rf  "$desktop_path/DIEF64.desktop" 2>> "$log"

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DES-PBH-ISS" ]; then # Ainda não consegui completar
  executar "apt install icedtea-netx"
  showMessage "Nas próximas mensagens, marque a única opção que aparecer na tela e depois clique no botão Later, Continuar e Executar."
  javaws http://bhissdigital.pbh.gov.br/des-ws/desapp/des.jnlp

  des_path=$(find "$desktop_path" -name "jws_app_shortcut_*")

  while [ ! -f "$des_path" ]; do
    sleep 2
    des_path=$(find "$desktop_path" -name "jws_app_shortcut_*")
  done

  mv "$des_path" "$desktop_path/Validadores"           2>> "$log"
  rm -Rf $HOME/.local/share/applications/jws_app_shortcut* 2>> "$log"

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GIA MT" ]; then
  #win="win32"
  #tricks="wine32"
  configurarWine
  download "https://www5.sefaz.mt.gov.br/documents/6071037/6425881/GIA_ICMS_307n_Completa.zip/89428c61-91cb-878a-153e-99535b281a26?t=1684931631844" "$cache_path/gia.zip"
  unzip $cache_path/gia.zip -d $cache_path 2>> "$log"
  sleep 2
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/GIA_ICMS_307n_Completa/GIA_ICMS_307n_Completa.exe"
  sleep 1
  mv -f "$desktop_path/GIA 3.07.desktop" "$desktop_path/Validadores"  2>> "$log"
  download "https://www5.sefaz.mt.gov.br/documents/6071037/6425881/GIA_ICMS_307n_Atualizacao.zip/265e7874-a097-5527-ee5a-f82fbffda694?t=1684931629746" "$cache_path/gia_atualizacao.zip"
  unzip $cache_path/gia_atualizacao.zip -d ./cache 2>> "$log"
  sleep 2
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/GIA_ICMS_307n_Atualizacao/GIA_ICMS_307n_Atualizacao.exe"
  sleep 1
  endInstall
fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GIA RS" ] ; then
  #win="win32"
  #tricks="wine32"
  #setWinePrefix "$win" "$tricks"
  download "https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/InstalaGIA9.exe" "$cache_path/gia9.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40  mdac28"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/gia9.EXE"
  sleep 1
  mkdir -p /opt/projetus/facilitador/cache/atualizacao 2>> "$log"
  download "https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/AtualizaGia9.exe" "$cache_path/atualizacao/AtualizaGia9.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/atualizacao/AtualizaGia9.EXE"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -rf  "$HOME/.local/share/applications/wine/Programs/GIA 9" 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi


  mv -f "$desktop_path/GIA 9.desktop" "$desktop_path/Validadores" 2>> "$log"
  rm -rf  "$desktop_path/GIA 9.lnk" 2>> "$log"

  endInstall

fi 

# ----------------------------------------------------------------------------------------


if [ "$acao" = "DIEF PA" ] ; then # instala mais não inicia erro de comunicação de java

  # naoCompativel

  # Limpeza da versao antiga

  rm -rf $user_path/.wine/drive_c/DIEF20* 2>> "$log"

  # Instalação do app via wine
  download "http://www.sefa.pa.gov.br/arquivos/downloads/dief/2022/DIEF2022.2.0.msi" "$cache_path/DIEF2022.msi"
  cd $cache_path
  executar "flatpak run --command=wine io.github.fastrizwaan.WineZGUI DIEF2022.msi /quite /qn"
  sleep 1

  # Download da JRE versão windows
  cd $user_path/.wine/drive_c/DIEF2022.2.0/
  executar "wget  https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u252-b09.1/OpenJDK8U-jre_x86-32_windows_hotspot_8u252b09.zip " "Baixando JRE"
  mv OpenJDK8U-jre_x86-32_windows_hotspot_8u252b09.zip jre.zip 2>> "$log"
  unzip jre.zip           2>> "$log"
  mv jdk8u252-b09-jre jre 2>> "$log"
  rm -rf jre.zip          2>> "$log"

  cd "$desktop_path/"
  mv DIEF2022.2.0.desktop "$desktop_path/Validadores/DIEF-PA-2022.2.0.desktop" 2>> "$log"
  rm -rf DIEF20*.* 2>> "$log"

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GIM ICMS PB" ] ; then 
  # win="win32"
  # tricks="wine32"
  # configurarWine
  # setWinePrefix "$win" "$tricks"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks mdac28 jet40" # Nessa ordem
  sleep 1
  download "http://www.sefaz.pb.gov.br/ser/images/docs/downloads/GIM/InstalaGimSREPB-Ver_2473.exe"  "$cache_path/gimsrepb.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/gimsrepb.exe"
  sleep 1
  cd $HOME
  mv -f "$desktop_path/Gim SRE-PB.desktop" "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo "✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/"
    rm -rf  $HOME/.local/share/applications/wine/Programs/SRE-PB 2>> "$log"
else
    echo "❌ A pasta do Wine NÃO existe."
fi

  
  rm -rf  "$desktop_path/Gim SRE-PB.lnk" 2>> "$log"

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SEDIF-SN" ] ; then 
  # configurarWine
  # Instalando complementos.
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks dotnet45"

  # Baixando e executando programa principal
  download "http://www.fazenda.mg.gov.br/empresas/declaracoes_demonstrativos/DeSTDA_SEDIF-SN/files/sedif_Setup1.0.6.00.exe"   "$cache_path/sedif.exe"
  cd "$cache_path"
  
  # Execuntando o executavel para instalação 
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/sedif.exe"
  
  # Tempo para serem criados os atalhos antes de copialos
  sleep 1

  # Copiando o atalho para a pasta de Validadores
  cp $HOME/.local/share/applications/wine/Programs/SimplesNacional/SEDIF/SEDIF.desktop "$desktop_path/Validadores" 2>> "$log"
  
  # Removendo links da Area de Trabalho
  rm -rf  "$desktop_path/SEDIF.*" 2>> "$log"

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DMED" ] ; then 

  # configurarWine

  download "https://servicos.receita.fazenda.gov.br/publico/programas/Dmed/2023/Dmed2023Win64v1.0.exe"   "$cache_path/Dmed.exe"
  cd "$cache_path"

  # Execuntando o executavel para instalação 
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/Dmed.exe /mode silent"

  # Tempo para serem criados os atalshos antes de copialos
  sleep 1

  # Copiando o atalho para a pasta de Validadores
  mv -f "$desktop_path/Dmed2023.desktop" "$desktop_path/Validadores" 2>> "$log"
  
  endInstall

fi 

# ----------------------------------------------------------------------------------------

exit 0

