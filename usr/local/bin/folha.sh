#!/usr/bin/env bash
#
# Autor: Evandro Begati e Fabiano Henrique
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Script facilitador de instalacao de aplicativos para uso do suporte.
# Data: 19/10/2025
# Licença:  MIT


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


# Ano atual

ano=$(date +%Y)
ARCH=$(uname -m)

acao=$1


mkdir -p $HOME/.local/share/applications/  2>> "$log"

# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet


# ----------------------------------------------------------------------------------------

if [ "$acao" = "ACI" ]; then

  clear

  mkdir -p $HOME/.java/deployment/security 2>> "$log"

  echo "https://caged.maisemprego.mte.gov.br
  http://caged.maisemprego.mte.gov.br" >> $HOME/.java/deployment/security/exception.sites

  showMessage "Nas próximas mensagens, marque a única opção que aparecer na tela e depois clique no botão Later, Continuar e Executar."

  rm -Rf $HOME/.java/deployment/cache 2>> "$log"
  cd $desktop_path
  rm -Rf jws_app_shortcut_* 2>> "$log"
  cd Validadores
  rm -Rf jws_app_shortcut_* 2>> "$log"
  cd $app_path

  javaws https://caged.maisemprego.mte.gov.br/downloads/caged/ACI-Install-JWS.jnlp

  aci_path=$(find "$desktop_path" -name "jws_app_shortcut_*")

  while [ ! -f "$aci_path" ]; do
    sleep 2
    aci_path=$(find "$desktop_path" -name "jws_app_shortcut_*")
  done

  mv "$aci_path" "$desktop_path/Validadores" 2>> "$log"
  rm -Rf $HOME/.local/share/applications/jws_app_shortcut* 2>> "$log"


  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIRF" ]; then

  clear

  cd "$desktop_path/Validadores"
  rm -Rf Dirf* 2>> "$log"
  cd $app_path


# Baixe o programa da DIRF

# A Receita disponibiliza o programa no site oficial:

# 🔗 https://www.gov.br/receitafederal

# (Procure por DIRF e baixe o instalador para Linux ou o .jar diretamente.)

# Geralmente o nome do arquivo é algo como:

# DIRF2023.jar

# https://www.gov.br/receitafederal/pt-br/search?origem=form&SearchableText=Dirf

# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dirf


  # download "https://servicos.receita.fazenda.gov.br/publico/programas/Dirf/${ano}/Dirf${ano}Linux-${ARCH}v1.0.sh" "$cache_path/Dirf.sh"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/Dirf/${ano}/Dirf${ano}Linux-${ARCH}v1.0.sh"

  wget -c "$download" -O "$cache_path/Dirf.sh" 2>> "$log"

  chmod +x $cache_path/Dirf.sh  2>> "$log"


# gzip: sfx_archive.tar.gz: not in gzip format
# chmod: não foi possível acessar '/usr/share/applications/Dirf2025-program.desktop': Arquivo ou diretório inexistente
# cp: não foi possível obter estado de '/usr/share/applications/Dirf2025-program.desktop': Arquivo ou diretório inexistente
# chmod: não foi possível acessar '/home/anon/Desktop/Validadores/Dirf2025-program.desktop': Arquivo ou diretório inexistente

  echo "#!/bin/bash 

    chmod +x $cache_path/Dirf.sh

    $cache_path/Dirf.sh --mode silent 

    chmod 755 /opt/Programas\ RFB/Dirf${ano}/Dirf${ano}.desktop

    cp /opt/Programas\ RFB/Dirf${ano}/Dirf${ano}.desktop $desktop_path/Validadores

    chmod 755 $desktop_path/Validadores/Dirf${ano}.desktop

    sudo rm -Rf /usr/share/applications/Dirf*

    " > $cache_path/exec.sh

  chmod +x $cache_path/exec.sh

  executar "pkexec $cache_path/exec.sh"

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GDRAIS" ]; then

# Link não funciona e não achei uma nova versão para Linux.

# https://www.gov.br/pt-br/search?origem=form&SearchableText=GDRAIS

# https://www.rais.gov.br

        yad \
        --center \
        --window-icon="$logo" \
        --title="GDRAIS" \
        --text="⚠️ Importante: GDRAIS e eSocial

Desde 2019, empresas que já estão obrigadas ao eSocial não precisam mais entregar a RAIS por meio do GDRAIS — o envio é feito automaticamente pelo eSocial.

No entanto, empresas que ainda não migraram para o eSocial (como órgãos públicos e pequenos empregadores) ainda precisam usar o GDRAIS." \
        --buttons-layout=center \
        --button="OK" \
        --width="900" \
        2>/dev/null




  cd "$desktop_path/Validadores"
  rm -Rf GDRais*       2>> "$log"
  rm -Rf $HOME/GDRais* 2>> "$log"

  cd $app_path/cache

  download "http://www.rais.gov.br/sitio/rais_ftp/GDRAIS2021-1.1-Linux-x86-Install.bin" "GDRAIS.bin"

  sleep 2

  mv GDRAIS.bin cache/GDRAIS.bin 2>> "$log"
  chmod +x $cache_path/GDRAIS.bin
  executar "$cache_path/GDRAIS.bin" 

  cd $app_path/atalhos

  echo "[Desktop Entry]
        Exec=$user_path/GDRais2021/gdrais.sh
        Terminal=false
        Type=Application
        Icon=$user_path/GDRais2021/gdrais.ico
        Name[pt_BR]=GDRAIS
        " > GDRais2021.desktop


  cp $app_path/atalhos/GDRais2021* "$desktop_path/Validadores"                        2>> "$log"
  cp "$desktop_path/Validadores/GDRais2021.desktop"  $HOME/.local/share/applications/ 2>> "$log"
  chmod +x "$desktop_path/Validadores/GDRais2021.desktop"  2>> "$log"
  rm -Rf $HOME/.local/share/applications/Desinstalar*      2>> "$log"

  # Ajustar atalho

  sed -i 's/Terminal=/Terminal=False/g' "$desktop_path/Validadores/GDRais.desktop"

  endInstall
    
fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GRRF" ]; then

# https://www.caixa.gov.br/site/Paginas/Pesquisa.aspx?k=GRRF

        yad \
        --center \
        --window-icon="$logo" \
        --title="GRRF" \
        --text="A GRRF é a Guia de Recolhimento Rescisório do FGTS, um documento obrigatório que deve ser gerado e pago quando ocorre rescisão de contrato de trabalho com direito a multa rescisória (exceto em casos de pedido de demissão ou justa causa, por exemplo).

📌 O que é GRRF?

A GRRF (Guia de Recolhimento Rescisório do FGTS) é utilizada para recolher:

Multa rescisória de 40% (ou 20%, em casos de culpa recíproca)

FGTS do mês da rescisão

FGTS proporcional dos meses anteriores, se ainda não recolhido

Eventuais diferenças de FGTS

É obrigatória para empregadores celetistas, e o recolhimento deve ocorrer em até 10 dias após o término do contrato (conforme nova regra da reforma trabalhista).


⚠️ Importante: Conectividade ICP e Certificado Digital

Se você precisar usar o Conectividade Social ICP da Caixa (para transmissão da GRRF):

Ele não funciona corretamente no Linux, pois depende de:

Navegador compatível (Internet Explorer 11)

Java 32 bits

Certificados digitais e plugins ActiveX

Por isso, mesmo que a instalação funcione no Linux via Wine, o envio da GRRF deve ser feito em um ambiente Windows confiável.


Máquina Virtual com Windows (mais estável)

Vantagens:

Suporte total ao programa e transmissão

Certificado digital ICP funciona corretamente

Conectividade Social abre normalmente no IE ou Edge com Java

Você pode usar:

VirtualBox
VMware Workstation Player

E instalar um Windows (pode ser com licença ou imagem de avaliação gratuita de 90 dias fornecida pela Microsoft).

" \
        --buttons-layout=center \
        --button="OK" \
        --width="900" \
        2>/dev/null


# 💻 Como instalar o GRRF no Linux?

# Infelizmente, a Caixa não oferece versão oficial do GRRF para Linux. O aplicativo é 
# distribuído apenas para Windows (.exe), mas você pode usar Wine ou uma máquina virtual 
# com Windows.

# ⚠️ Limitações conhecidas

# A GRRF pode apresentar erros de interface ou falhas em botões com o Wine.

# Pode haver dificuldade em assinar ou transmitir arquivos via Conectividade Social no navegador do Linux (muito dependente de Java e ActiveX).

# Em muitos casos, a transmissão da GRRF precisa ser feita em máquina com Windows e Internet Explorer configurado com certificado digital.


# Usar Máquina Virtual com Windows

# Mais confiável. Instale o GRRF em uma VM com Windows (via VirtualBox, VMware, etc.), principalmente se você precisa:

# Transmitir via Conectividade Social ICP

# Assinar com certificado digital

# Garantir que a guia seja aceita sem erro


  # configurarWine

  # INSTALADOR GRRF (versão 3.3.21) - Desligamentos anteriores ao FGTS Digital

  download "https://www.caixa.gov.br/Downloads/fgts-grrf-aplicativo-arquivos/Instalador_GRRF_FB_ICP.zip" "$cache_path/GRRF.zip"

  # Para extrair

  unzip "$cache_path/GRRF.zip" -d "$cache_path" 2>> "$log"

  # Instalador do programa da GRRF da Caixa Econômica Federal

  # O instalador será aberto em uma janela semelhante à do Windows. Basta seguir as etapas padrão da instalação.

  wine "$cache_path/Instalador_GRRF_FB_ICP.EXE" 2>> "$log"

  # Rodar o programa após instalado

  echo "[Desktop Entry]
Name=GRRF
Comment=GRRF - Guia de Recolhimento Rescisório do FGTS
Exec=wine start /unix $HOME/.wine/drive_c/Arquivos\ de\ Programas/CAIXA/GRRF/GRRF.exe
Type=Application
StartupNotify=true
Path=$HOME/.wine/drive_c/Arquivos\ de\ Programas/CAIXA/GRRF
Icon=application-x-executable
Categories=Office;
" > $HOME/.local/share/applications/grrf.desktop


# Atualizar ícones/menu (opcional)

# Se não aparecer no menu de imediato:

update-desktop-database $HOME/.local/share/applications/ 2>> "$log"

# Ou reinicie a sessão/ambiente gráfico.


# Pronto!

# Agora o GRRF aparecerá no menu de aplicativos (pode procurar por “GRRF”).
# Clicando nele, o sistema irá abrir o programa diretamente via Wine.



  # executar "flatpak run --command=wine io.github.fastrizwaan.WineZGUI $cache_path/GRRF.exe /silent "
  # mv $HOME/.var/app/io.github.fastrizwaan.WineZGUI/data/applications/wine/GRRF/GRRF\ Eletronica.desktop "$desktop_path/Validadores"
  # rm -Rf $HOME/.local/share/applications/wine/GRRF*

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SEFIP" ]; then

        yad \
        --center \
        --window-icon="$logo" \
        --title="SEFIP" \
        --text="O SEFIP (Sistema Empresa de Recolhimento do FGTS e Informações à Previdência Social) é um programa da Caixa Econômica Federal, usado para gerar e transmitir:

Guias de recolhimento do FGTS

Informações previdenciárias (para a Receita Federal)

Arquivos relacionados a demissões, admissões, e outros dados trabalhistas

É obrigatório para empresas com funcionários, e é um dos principais programas usados por contadores e departamentos de RH no Brasil.

🧩 Para que serve o SEFIP?

O SEFIP é usado para:

Função	Finalidade
Gerar a guia do FGTS	Para recolhimento mensal do FGTS dos empregados
Informar vínculos trabalhistas	Para Previdência Social e eSocial
Encerrar vínculos	Informar demissões
Complementar dados da GFIP	Gera o arquivo GFIP a ser enviado via Conectividade Social
Recolher INSS de autônomos	(em alguns contextos)

⚠️ Problema: SEFIP não tem versão oficial para Linux

A Caixa só fornece o SEFIP para Windows (.exe).


⚠️ Limitações com Wine

O programa SEFIP geralmente funciona bem com Wine, mas não é oficialmente suportado.

A transmissão da GFIP é feita pelo Conectividade Social, que exige certificado digital ICP, Java, e Internet Explorer — o que não funciona bem no Linux.

Ou seja, você pode gerar a GFIP no Linux, mas deve transmiti-la em uma máquina com Windows.
" \
        --buttons-layout=center \
        --button="OK" \
        --width="900" \
        2>/dev/null


# Site oficial da Caixa:

# https://www.caixa.gov.br/

# (procure por "SEFIP download")

# https://www.caixa.gov.br/empresa/fgts-empresas/SEFIP-GRF/Paginas/default.aspx


  # configurarWine

  cd $cache_path

  download "https://www.caixa.gov.br/Downloads/fgts-sefip-grf/Sefip_v_8_4_20_12_2024.zip" "$cache_path/sefip.zip"

  # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/sefip/setupsefipv8_4.exe


 # Para extrair

  unzip "$cache_path/sefip.zip" -d "$cache_path" 2>> "$log"


  wine "$cache_path/Sefip_v_8_4_20_12_2024.exe" 2>> "$log"

  # Rodar o programa após instalado

  echo "[Desktop Entry]
Type=Application
Name=SEFIP
Comment=Sistema Empresa de Recolhimento do FGTS e Informações à Previdência Social (SEFIP) é um aplicativo desenvolvido pela Caixa para o empregador.
Exec=wine ~/.wine/drive_c/Arquivos\ de\ Programas/CAIXA/SEFIP/SEFIP.exe
StartupNotify=true
Path=$HOME/.wine/drive_c/Arquivos de Programas/CAIXA/SEFIP
Icon=application-x-executable
Categories=Office;
" > $HOME/.local/share/applications/sefip.desktop


# Atualizar ícones/menu (opcional)

# Se não aparecer no menu de imediato:

update-desktop-database $HOME/.local/share/applications/ 2>> "$log"

# Ou reinicie a sessão/ambiente gráfico.


  # executar "flatpak run --command=wine io.github.fastrizwaan.WineZGUI $cache_path/sefip.exe /silent"
  # mv "$desktop_path/SEFIP.desktop" "$desktop_path/Validadores"
  # rm -Rf $HOME/.var/app/io.github.fastrizwaan.WineZGUI/data/applications/wine/SEFIP

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SVA" ]; then


echo "
SVA (Sistema de Validação e Autenticação de Arquivos Digitais) da Receita Federal do Brasil (RFB).
Ele serve para validar leiautes de arquivos digitais entregues à RFB e gerar códigos de autenticação únicos para esses arquivos.

Suporte limitado.


⚠️ Atenção:

Nem todas as funções do SVA vão funcionar no Linux, especialmente assinaturas digitais (A3) e integração com Java.

Pode haver falhas ao validar ou assinar arquivos.

Se for uso oficial ou profissional, prefira usar em Windows.


Ou usar uma Máquina Virtual (VM) com Windows para garantir funcionamento completo, especialmente se houver assinatura digital ou 
certificação envolvida (casos típicos do SVA).


" | yad --center --window-icon="$logo" --title "SVA" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1200" --height="400"  2> /dev/null



  # configurarWine
  cd "$desktop_path/Validadores"
  rm -Rf SVA* 2>> "$log"


# 📝 Onde baixar o SVA?

# https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/auditoria-fiscal/arquivos/sva-arquivos

# https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/auditoria-fiscal/arquivos/sva-arquivos/instala_sva-3-3-0.exe/view


# ORIENTAÇÕES PARA UTILIZAÇÃO DO SVA PARA VALIDAÇÃO E TRANSMISSÃO DE ARQUIVOS DE PREVIDÊNCIA COMPLEMENTAR

# https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/auditoria-fiscal/arquivos/sva-arquivos/orientacoessva_previdenciacomplementar.pdf/@@download/file


  download "https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/auditoria-fiscal/arquivos/sva-arquivos/instala_sva-3-3-0.exe/@@download/file" "$cache_path/sva.exe"


    # Void Linux

    if which xbps-install &>/dev/null; then

       echo -e "\nAtivando o repositório multilib e instalando o wine-32bit...\n"

       sudo xbps-install -Sy void-repo-multilib

       sudo xbps-install -Sy wine-32bit


    fi 


  wine "$cache_path/sva.exe" 2>> "$log"


  # Rodar o programa após instalado

  echo "[Desktop Entry]
Type=Application
Name=SVA
Comment=Sistema de Validação e Autenticação de Arquivos Digitais da Receita Federal do Brasil (RFB).
Exec=wine $HOME/.wine/drive_c/Arquivos\ de\ Programas/SVA/SVA.exe
StartupNotify=true
Path=$HOME/.wine/drive_c/Arquivos\ de\ Programas/SVA
Icon=application-x-executable
Categories=Office;
" > $HOME/.local/share/applications/SVA.desktop



# $ wine ~/.wine/drive_c/Arquivos\ de\ Programas/SVA/SVA.exe
# it looks like wine-32bit is missing, you should install it.
# the multilib repository needs to be enabled first.  as root, please
# execute "xbps-install -S void-repo-multilib && xbps-install -S wine-32bit"
# 002c:err:winediag:getaddrinfo Failed to resolve your host name IP
# wine: failed to open "/home/anon/.wine/drive_c/Arquivos de Programas/SVA/SVA.exe"

# Esse erro indica que o Wine está tentando executar um aplicativo de 32 bits, mas você não tem 
# o suporte para 32 bits instalado no Void Linux. Além disso, há também um problema com a resolução 
# do nome de host.



chmod -R +x $HOME/.local/share/applications/SVA.desktop  2>> "$log"


# Atualizar ícones/menu (opcional)

# Se não aparecer no menu de imediato:

update-desktop-database $HOME/.local/share/applications/ 2>> "$log"

# Ou reinicie a sessão/ambiente gráfico.

reiniciar_painel


  # executar "flatpak run --command=wine io.github.fastrizwaan.WineZGUI $cache_path/sva.exe /silent "
  # sleep 1
  # mv $HOME/.var/app/io.github.fastrizwaan.WineZGUI/data/applications/wine/Programs/Programas\ RFB/SVA\ 3.3.0/SVA\ 3.3.desktop "$desktop_path/Validadores"
  # rm -Rf $HOME/.var/app/io.github.fastrizwaan.WineZGUI/data/applications/wine/Programs/Programas\ RFB/SVA*

  endInstall

fi

# ----------------------------------------------------------------------------------------


exit 0

