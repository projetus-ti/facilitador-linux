#!/usr/bin/env bash
#
# Autor: Fabiano Henrique
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Descricao: Script facilitador de instalacao de aplicativos do fiscal.
# Data: 19/10/2025
# Licença:  MIT


# ----------------------------------------------------------------------------------------

# Verifica se o arqivo existe

if [[ ! -e /etc/facilitador.conf ]]; then

    echo -e "\nO arquivo /etc/facilitador.conf não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="O arquivo /etc/facilitador.conf não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2> /dev/null
        
    exit 1
fi


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# ----------------------------------------------------------------------------------------


# Verifica se o arqivo existe

if [[ ! -e /usr/local/bin/funcoes.sh ]]; then

    echo -e "\nO arquivo /usr/local/bin/funcoes.sh não encontrado. \n"

        yad \
        --center \
        --window-icon="$logo" \
        --title="Erro" \
        --text="O arquivo /usr/local/bin/funcoes.sh não encontrado." \
        --buttons-layout=center \
        --button="OK" \
        --width="400" --height="100" \
        2> /dev/null
        
    exit 1
fi


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


# Ano atual

ano=$(date +%Y)
ARCH=$(uname -m)


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
  unzip "$cache_path"/dma_2012.zip -d ./cache 2>> "$log"
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

# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download
# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd
# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dctf
# https://www.gov.br/receitafederal/pt-br/assuntos/noticias/2024/dezembro/publicada-instrucao-normativa-que-institui-o-modulo-de-inclusao-de-tributos-2013-mit-na-dctfweb-e-substitui-a-dctf
# https://www.gov.br/pt-br/servicos/declarar-debitos-e-creditos-tributarios-federais#etapas-para-a-realizacao-deste-servico
# https://cav.receita.fazenda.gov.br/autenticacao/login/index/73

echo "
Programa Gerador de Declaração (PGD) da Declaração de Débitos e Créditos Tributários Federais (DCTF).

Declaração de Débitos e Créditos Tributários Federais

Utilize este programa para preencher Declaração de Débitos e Créditos Tributários Federais (DCTF), original ou retificadora, inclusive 
nas situações de extinção, incorporação, fusão e cisão total ou parcial, relativa aos fatos geradores ocorridos entre agosto de 2014 e 
dezembro de 2024.


Atenção! Para os fatos geradores ocorridos a partir de 1º de janeiro de 2025, os débitos passarão a ser declarados na DCTFWeb. Saiba 
mais sobre o fim da DCTF por PGD.

https://www.gov.br/receitafederal/pt-br/assuntos/noticias/2024/dezembro/publicada-instrucao-normativa-que-institui-o-modulo-de-inclusao-de-tributos-2013-mit-na-dctfweb-e-substitui-a-dctf


Declarar débitos e créditos tributários federais (DCTF/DCTFWeb) 


A Declaração de Débitos e Créditos Tributários Federais (DCTF) e a Declaração de Débitos e Créditos Tributários Federais Previdenciários 
e de Outras Entidades e Fundos (DCTFWeb) foram unificadas.

A partir de 1º de janeiro de 2025, os débitos informados na DCTF PGD passarão a ser declarados na DCTFWeb mensal, usando o Módulo de 
Inclusão de Tributos (MIT).

O MIT é um serviço integrado à DCTFWeb que será usado para incluir débitos de tributos que ainda não são enviados por outras escriturações 
fiscais, como o eSocial ou a EFD-Reinf. Ele vai substituir o programa PGD DCTF, que hoje é usado para declarar tributos como IRPJ, CSLL, 
PIS/PASEP, IPI, COFINS, CIDE, IOF, CONDECINE, CPSS e RET/Pagamento Unificado.

O MIT será acessado no mesmo site da DCTFWeb. Você deve preenchê-lo diretamente online ou importar um arquivo já preenchido no sistema do 
contribuinte.

A DCTFWeb deve ser elaborada com base nas informações fornecidas pelo Sistema de Escrituração Digital das Obrigações Fiscais, Previdenciárias 
e Trabalhistas (eSocial) e pela Escrituração Fiscal Digital de Retenções e Outras Informações Fiscais (EFD-Reinf), ambos módulos do Sistema 
Público de Escrituração Digital (Sped), além do Módulo de Inclusão de Tributos (MIT).

Prazo

O prazo mensal para entregar a DCTFWeb é até o último dia útil do mês seguinte ao da ocorrência dos fatos geradores.

Por exemplo, os débitos e créditos decorrentes do mês de janeiro, devem ser declarados no mês de fevereiro.

Obs: O prazo para entregar a DCTFWeb referente a janeiro de 2025 foi prorrogado até o último dia útil de março de 2025.

Se você é um contribuinte obrigado por lei a entregar a declaração, mas enviar após o prazo, será cobrada Multa por Atraso na Entrega de 
Declaração (MAED).

Obs: Para declarações originais ou retificadoras referentes a períodos de apuração até dezembro de 2024, ainda será necessário usar a 
DCTF PGD e a DCTFWeb, seguindo as regras da Instrução Normativa RFB nº 2.005/2021.

Com a unificação das declarações e a mudança na data de entrega em janeiro de 2025, é importante prestar atenção aos próximos prazos.


Tem um atalho no menu para acessar o serviço oficial da DCTFWeb via portal da Receita Federal.

https://cav.receita.fazenda.gov.br/autenticacao/login/index/73

" | yad --center --window-icon="$logo" --title "Programa Gerador de Declaração (PGD)" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null



#  configurarWine32
#  cd "$desktop_path/Validadores"
#  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks corefonts"
#  rm -Rf DCTF* 2>> "$log"
#  download "https://servicos.receita.fazenda.gov.br/publico/programas/dctf-pgd/dctfmensalv3-8.exe" "$cache_path/dctf.exe"
#  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dctf.exe"
#  sleep 1
#  cp $HOME/.local/share/applications/wine/Programs/Programas\ RFB/DCTF\ Mensal\ 3.6/DCTF\ Mensal\ 3.6.desktop "$desktop_path/Validadores" 2>> "$log"
#  cd "$desktop_path"
#  rm -Rf DCTF* 2>> "$log"

# Verificação da existência do diretório

# if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

#    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"

#    rm -Rf $HOME/.local/share/applications/wine/Programs/Programas\ RFB/ 2>> "$log"

# else

#    echo -e "\n❌ A pasta do Wine NÃO existe. \n"

# fi


#  endInstall


fi


# ----------------------------------------------------------------------------------------


if [ "$acao" = "EFD Contribuições" ]; then

# Programas do SPED

# Programas geradores, validadores e visualizadores do Sistema Público de Escrituração Digital (SPED).

# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped

# Programa gerador da Escrituração Fiscal Digital das Contribuições incidentes sobre a Receita (EFD-Contribuições).

# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/efdc


echo "

EFD-Contribuições

Programa gerador da Escrituração Fiscal Digital das Contribuições incidentes sobre a Receita (EFD-Contribuições).


Utilize este programa para gerar o arquivo da sua Escrituração Fiscal Digital das Contribuições incidentes sobre a Receita (EFD-Contribuições).

Recomendações

    Antes de instalar uma nova versão, recomenda-se fazer backup das escriturações.
    Alguns antivírus e permissões de execução poderão gerar conflitos na execução do PGE. Leia as perguntas frequentes da EFD-Contribuições para mais informações.
    Faça backup periódico das escriturações, removendo as mais antigas. O programa pode ficar lento com excesso de escriturações.



" | yad --center --window-icon="$logo" --title "Programa Gerador de Declaração (PGD)" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null



  download "https://servicos.receita.fazenda.gov.br/publico/programas/SpedPisCofinsPVA/EFD-Contribuicoes_linux_x86_64-6.1.0.sh" "$cache_path/EFD-Contribuicoes_linux_x86_64-6.1.0.sh"

  # executar "java -jar $cache_path/EFDContribuicoes.jar"

  sleep 1

  cd "$desktop_path"

  sudo chmod +x EFD-Contribuicoes_linux_x86_64-6.1.0.sh 2>> "$log"

  sudo ./EFD-Contribuicoes_linux_x86_64-6.1.0.sh        2>> "$log"

  # rm -Rf EFD* 2>> "$log"
  # rm -Rf Desinstalar* 2>> "$log"
  # rm -Rf $HOME/.local/share/applications/EFD* 2>> "$log"
  # rm -Rf $HOME/.local/share/applications/Desinstalar* 2>> "$log"
  # cp /opt/projetus/facilitador/atalhos/efd-contribuicoes.desktop "$desktop_path/Validadores" 2>> "$log"

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GIAM TO" ]; then

# Para o período de referência 01/2009 em diante.

# https://giam.sefaz.to.gov.br/


  # configurarWine

  # cd "$desktop_path"
  # rm -Rf GIAM* 2>> "$log"
  # cd /opt/projetus/facilitador

  # download "https://giam.sefaz.to.gov.br/download/Instalargiam10.0_07.03.2024v1.zip" "$cache_path/giamto.zip"

  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/giamto.exe /silent"
  # sleep 3
  # mv "$desktop_path/GIAM 10.0.desktop" "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

# if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

#    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"
#
#    rm -Rf $HOME/.local/share/applications/wine/Programs/GIAM* 2>> "$log"

# else

#    echo -e "\n❌ A pasta do Wine NÃO existe. \n"

# fi


  download="https://giam.sefaz.to.gov.br/download/Instalargiam10.0_07.03.2024v1.zip" 

  wget -c "$download" -O "$cache_path/giamto.zip" | tee -a "$log"

  sleep 1

  unzip -o "$cache_path"/giamto.zip -d "$cache_path" 2>> "$log"

  wine "$cache_path"/Instalargiam10.0_07.03.2024v1.exe | tee -a "$log"


#  endInstall


fi


# ----------------------------------------------------------------------------------------

if [ "$acao" = "SPED ICMS IPI" ]; then

# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/efdi


echo "

Programa validador da Escrituração Fiscal Digital de ICMS IPI.


EFD - ICMS IPI

Utilize este programa para validar o arquivo da sua Escrituração Fiscal Digital - ICMS IPI.


" | yad --center --window-icon="$logo" --title "EFD - ICMS IPI" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null





  # download "https://servicos.receita.fazenda.gov.br/publico/programas/Sped/SpedFiscal/PVA_EFD_linux-3.0.7_x64.jar" "$cache_path/PVA_EFD.jar"
  
  # if [ ! -d "/usr/lib/jvm/jre1.8.0_212/bin/java" ]; then

  #  executar "java -jar $cache_path/PVA_EFD.jar"

  # else

  #  executar "/usr/lib/jvm/jre1.8.0_212/bin/java -jar $cache_path/PVA_EFD.jar"

  # fi

  # sleep 1

  # cd "$desktop_path"

  # rm -Rf EFD* 2>> "$log"

  # rm -Rf Desinstalar* 2>> "$log"

  # cp /opt/projetus/facilitador/atalhos/efd-icms-ipi.desktop "$desktop_path/Validadores" 2>> "$log"

  # endInstall


  download="https://servicos.receita.fazenda.gov.br/publico/programas/Sped/SpedFiscal/SpedEFD_linux_x86_64-6.0.1.sh" 

  wget -c "$download" -O "$cache_path/SpedEFD_linux_x86_64-6.0.1.sh" | tee -a "$log"

  sleep 1


  cd "$cache_path"

  chmod +x SpedEFD_linux_x86_64-6.0.1.sh | tee -a "$log"

  sudo ./SpedEFD_linux_x86_64-6.0.1.sh   | tee -a "$log"


fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SEF 2012 PE" ]; then

# https://www.sefaz.pe.gov.br
# https://www.sefaz.pe.gov.br/servicos/sefii/Paginas/default.aspx
# https://www.sefaz.pe.gov.br/Servicos/SEFII/Paginas/Aplicativos.aspx


  # configurarWine

  cd "$desktop_path/Validadores"
  rm -Rf SEF2012* 2>> "$log"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gdiplus"
  download "https://www.sefaz.pe.gov.br/Servicos/SEFII/Programas/SEF2012_v1.6.5.00_instalador.exe.zip" "$cache_path/sef2012.zip"
  unzip -o $cache_path/sef2012.zip -d ./cache 2>> "$log"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/SEF2012_v1.6.5.00_instalador.exe /silent"
  sleep 1
  cp $HOME/.local/share/applications/wine/Programs/SEFAZ-PE/SEF\ 2012/SEF\ 2012.desktop "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"

    rm -Rf $HOME/.local/share/applications/wine/Programs/SEFAZ-PE 2>> "$log"

else

    echo -e "\n❌ A pasta do Wine NÃO existe. \n"

fi


  cd "$desktop_path"

  rm -Rf SEF2012* 2>> "$log"

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SEFAZNET PE" ]; then

# https://www.sefaz.pe.gov.br/Servicos/Paginas/SEFAZnet.aspx


echo "
SEFAZ-Net

O  objetivo  do  SEFAZ-Net  é  possibilitar  que os arquivos (GIA, SEF I, SEF II e eDoc) com  as  informações  fiscais   sejam  enviados 
digitalmente  através  da  INTERNET,  diretamente  pelo  Contribuinte  ou  pelo  Contabilista, evitando a necessidade da ida a uma Agência 
da Receita Estadual.


O  SEFAZ-Net  garante  a  segurança  da  transmissão  das  informações  através  da  INTERNET com  a  utilização  de  criptografia.  Após  
a  transmissão  é  gerado,  automaticamente,  um comprovante  eletrônico  de  transmissão  do  arquivo,  contendo  dados  informativos  
sobre  a transmissão,  que  devem  ser  conferidos  pelo  Contribuinte. 


GUIA DO SEFAZ-NET

https://www.sefaz.pe.gov.br/Servicos/Programas%20do%20SEFAZnet/GuiaSefazNet-v1.11.pdf.pdf

" | yad --center --window-icon="$logo" --title "SEFAZNET PE" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null



  # configurarWine

  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gdiplus"
  download "https://www.sefaz.pe.gov.br/Servicos/Programas%20do%20SEFAZnet/SefazNet_v1.24.0.3_instalador.exe.zip" "$cache_path/sefaznet.zip"
  unzip -o "$cache_path"/sefaznet.zip -d ./cache 2>> "$log"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/SefazNet_v1.24.0.3_instalador.exe /silent"
  sleep 1
  cp $HOME/.local/share/applications/wine/Programs/SEFAZ-PE/SEFAZNET/SEFAZNET.desktop "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"
    rm -Rf $HOME/.local/share/applications/wine/Programs/SEFAZ-PE 2>> "$log"
else
    echo -e "\n❌ A pasta do Wine NÃO existe. \n"
fi

  
  cd "$desktop_path"

  rm -Rf SEFAZNET* 2>> "$log"

  chmod 777 -R "$desktop_path/Validadores" 2>> "$log"

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIEF CE" ] ; then

# DIEF

# DIEF é uma ferramenta online para a entrega de declarações de informações econômico-fiscais por parte dos contribuintes.

# https://internet-consultapublica.apps.sefaz.ce.gov.br/dief/preparar-consultarinstalacao
# https://consultapublica.sefaz.ce.gov.br/dief/preparar-consultarinstalacao


  # Instalando complementos.
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40"

  # Baixando e executando programa principal
  download "https://servicos.sefaz.ce.gov.br/internet/download/dief/dief.exe" "$cache_path/dief.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief.exe"

  # Movendo e limpando os arquivos de instalação.
  mv $HOME/.local/share/applications/wine/Programs/SEFAZ-CE/DIEF/DIEF.desktop "$desktop_path/Validadores/DIEF-CE.desktop" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"
    rm -Rf  $HOME/.local/share/applications/wine/Programs/SEFAZ-CE 2>> "$log"
else
    echo -e "\n❌ A pasta do Wine NÃO existe. \n"
fi



  # Terminando instalação e notificando o usuário.

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIEF PI" ] ; then

# https://portal.sefaz.pi.gov.br/search?q=DIEF

# https://portal.sefaz.pi.gov.br/download/dief-v2-4-2

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

    cp "$app_path/DLLs/MSSTDFMT.DLL"  "$user_path"/.wine/drive_c/windows/system32/MSSTDFMT.DLL 2>> "$log"
                     

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


# https://www.fazenda.mg.gov.br/empresas/sistemas/
# https://www.fazenda.mg.gov.br/empresas/sistemas/sapi/dow.html
# https://www.fazenda.mg.gov.br/empresas/declaracoes_demonstrativos/dapi/


echo "

Declaração de Apuração e Informação do ICMS - (DAPI)


Apurar e informar ao Estado, mensalmente, o valor a ser pago ou restituído a título de Imposto sobre Operações relativas à Circulação de 
Mercadorias e sobre Prestações de Serviços de Transporte Interestadual e Intermunicipal e de Comunicação (ICMS) é uma obrigação das empresas 
inscritas no cadastro de contribuintes de Minas Gerais, enquadradas no regime de Débito e Crédito. O contribuinte enquadrado no regime de 
recolhimento Isento ou Imune entregará a DAPI 1 somente quando realizar operações ou prestações sujeitas ao recolhimento do imposto. Para 
isso, o contribuinte deve utilizar a Declaração de Apuração e Informação do ICMS (DAPI).
 
Essa Declaração é gerada pelo aplicativo denominado DAPISEF e entregue pelo mesmo aplicativo onde foi gerada utilizando o aplicativo Transmissor 
Eletrônico de Documentos da Secretaria de Estado de Fazenda, TEDSEF.
 
Ambos os aplicativos, gerador (DAPISEF) e transmissor (TEDSEF), estão disponíveis para download abaixo e no menu lateral.
 
Lembre-se:
 
O aplicativo transmissor solicita Domínio, Usuário e Senha do responsável pela empresa. A senha, nesse caso, é a mesma utilizada para acesso 
ao Sistema Integrado de Administração da Receita Estadual (SIARE)No caso de substituição de declaração já aceita pela SEF-MG, é devido o recolhimento 
da taxa de expediente – Retificação de Documentos Fiscais e de Declarações. O Documento de Arrecadação Estadual (DAE) deverá ser emitido no sitio da 
SEF-MG em DAE avulso - SIARE.

" | yad --center --window-icon="$logo" --title "DAPI MG" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null




  # win="win32"
  # tricks="wine32"
  # setWinePrefix "$win" "$tricks"
  # configWine
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gecko corefonts mdac28 jet40 msxml4"
  download "https://www.fazenda.mg.gov.br/empresas/declaracoes_demonstrativos/dapi/files/instalar.exe" "$cache_path/dapi.exe"
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


# Não existe uma versão nativa do SINTEGRA para Linux, pois os programas oficiais 
# (Validador e TED) são feitos para Windows, então no Linux normalmente é instalado 
# via Wine.

# https://www.vivaolinux.com.br/artigo/Sintegra-e-Ted-via-wine?pagina=1


echo "
O SINTEGRA (Sistema Integrado de Informações sobre Operações Interestaduais com Mercadorias e Serviços) é um sistema da administração 
tributária brasileira que tem os seguintes aspectos principais:


### ✅ O que é

* É um conjunto de procedimentos administrativos e de sistemas computacionais de apoio usados pelas administrações tributárias estaduais.
* Tem como objetivo principal facilitar que os contribuintes prestem periodicamente informações sobre suas operações de compras, vendas, 
aquisições e prestações de serviços — tanto dentro do próprio estado quanto interestaduais — para os fiscos estaduais.
* O fundamento legal inclui o Convênio ICMS 57/95 (e suas alterações) que estipula esses fornecimentos de arquivo magnético para os Estados.
* Exemplo de definição: 'O Sintegra... é o sistema que foi implantado no Brasil com a finalidade de facilitar o fornecimento de informações 
dos contribuintes aos fiscos estaduais...'


### 🔍 Para que serve

* Permite que as Secretarias da Fazenda estaduais controlem as operações interestaduais com mercadorias e serviços, ajudando no combate à 
evasão e melhor estruturação da arrecadação.
* Para os contribuintes, significa que devem gerar arquivos conforme leiaute definido e enviar para a administração tributária estadual.
* Também pode ser usado para consultas de situação cadastral da empresa via Inscrição Estadual ou CNPJ, para verificar se está regular 
perante o ICMS interestadual.



### 📥 Onde baixar / como acessar

* Cada estado da federação geralmente disponibiliza os programas de 'Validador SINTEGRA' e 'Transmissão Eletrônica de Documentos – TED' 
que o contribuinte precisa instalar para gerar, validar e enviar os arquivos. Exemplo: No site da Secretaria de Estado da Fazenda de 
Alagoas há downloads específicos do Validador e do TED.
* No site dedicado (ou portal nacional) existe página com download dos programas 'Validador SINTEGRA' e 'TED'.
* Em alguns estados, há 'Consulta pública' ao Sintegra para verificar cadastro de contribuintes.


Você pode baixar os programas relacionados ao VALIDADOR SINTEGRA ou ao TED‑TEF (ou outros aplicativos de entrega de arquivos do SINTEGRA) 
para cada estado brasileiro, nos sites das respectivas secretarias da fazenda estaduais ou no portal nacional.

🌐 Portal Nacional do SINTEGRA

Endereço: http://www.sintegra.gov.br/

O que oferece: Uma lista completa de links para as Secretarias da Fazenda de todos os 26 estados e do Distrito Federal. Cada link direciona 
para a página específica de cada unidade federativa, onde você pode encontrar informações sobre o sistema SINTEGRA, bem como os programas 
necessários para validação e transmissão de arquivos.

" | yad --center --window-icon="$logo" --title "SINTEGRA" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null



  # configurarWine

  # download "https://cdn.projetusti.com.br/infra/facilitador/sintegra.exe" "$cache_path/sintegra.exe"
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/sintegra.exe /silent"
  # sleep 1
  # mv $HOME/.local/share/applications/wine/Programs/Validador\ Sintegra\ 2017/Validador\ Sintegra\ 2017.desktop "$desktop_path/Validadores" 2>> "$log"
  

# Verificação da existência do diretório

# if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

#     echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"

#     rm -Rf $HOME/.local/share/applications/wine/Programs/Validador* 2>> "$log"
# else
#     echo -e "\n❌ A pasta do Wine NÃO existe. \n"
# fi






# Para baixar e instalar o Sintegra por estado


# Função que mostra a lista de estados

# Assim, quando o usuário escolher o estado, o script irá fazer o download do arquivo .exe 
# do site oficial do Sintegra da respectiva Secretaria da Fazenda.


ESTADO=$(yad --center --list \
    --window-icon="$logo" \
    --fontname "mono 10" \
    --title="Selecione o Estado - Sintegra" \
    --column="Sigla" --column="Estado" \
    AC "Acre" \
    AL "Alagoas" \
    AM "Amazonas" \
    AP "Amapá" \
    BA "Bahia" \
    CE "Ceará" \
    DF "Distrito Federal" \
    ES "Espírito Santo" \
    GO "Goiás" \
    MA "Maranhão" \
    MG "Minas Gerais" \
    MS "Mato Grosso do Sul" \
    MT "Mato Grosso" \
    PA "Pará" \
    PB "Paraíba" \
    PE "Pernambuco" \
    PI "Piauí" \
    PR "Paraná" \
    RJ "Rio de Janeiro" \
    RN "Rio Grande do Norte" \
    RO "Rondônia" \
    RR "Roraima" \
    RS "Rio Grande do Sul" \
    SC "Santa Catarina" \
    SE "Sergipe" \
    SP "São Paulo" \
    TO "Tocantins" \
    --buttons-layout=center \
    --button=OK:0 --button=Cancelar:1 \
    --width="420" --height="700" \
    2> /dev/null)



# Se o usuário cancelou

if [ $? -ne 0 ]; then

    yad --center --window-icon="$logo" --info --text="Operação cancelada." --buttons-layout=center --button="OK"  2> /dev/null

    exit 1

fi


UF=$(echo "$ESTADO" | cut -d'|' -f1)

# Tabela de links por estado (exemplo — substitua pelos links reais)

declare -A LINKS


# 🧠 Observações

# Cada estado pode ter seu próprio link de download — os exemplos abaixo são ilustrativos.

# http://www.sintegra.gov.br/

# http://www.sintegra.gov.br/download.html



# Secretaria de Estado da Fazenda de Alagoas: https://www.sefaz.al.gov.br/downloads
# Secretaria da Fazenda e Planejamento do Estado de São Paulo: https://portal.fazenda.sp.gov.br/servicos/icms/Paginas/sintegra-versoes-TED.aspx
# Secretaria da Fazenda do Estado da Bahia: https://www.sefaz.ba.gov.br/inspetoria-eletronica/icms/escrituracao-sped/escrituracao-fiscal-digital/informacoes-gerais/?highlight=Sintegra
# Secretaria de Estado de Economia do Distrito Federal: https://www.receita.fazenda.df.gov.br/aplicacoes/CartaServicos/servico.cfm?codServico=446&codTipoPessoa=7&codCategoriaServico=33&codSubCategoria=270

# A variavel $LINKS deve ter o link completo do arquivo .exe do Estado ou o site.

LINKS=(

    [AC]="http://sefaznet.ac.gov.br/sefazonline/servlet/hpfsincon" 
    [AL]="http://gcs.sefaz.al.gov.br/documentos/visualizarDocumento.action?key=lu7zZCbuk84%3D"
    [AM]="https://online.sefaz.am.gov.br/sintegra/"
    [AP]="https://sefaz.portal.ap.gov.br/"
    [BA]="https://www.sefaz.ba.gov.br/inspetoria-eletronica/icms/escrituracao-sped/escrituracao-fiscal-digital/informacoes-gerais/?highlight=Sintegra"
    [CE]="https://www.sefaz.ce.gov.br/sintegra/"
    [DF]="https://ww1.receita.fazenda.df.gov.br/icms/sintegra-consulta"
    [ES]="https://sefaz.es.gov.br/sintegra"
    [GO]="https://goias.gov.br/economia/sintegra-icms-de-goias-esta-fora-do-ar-nesta-semana/"
    [MA]="http://downloads.sefaz.ma.gov.br/sintegra/ValidadorSintegra2010.5.2.8.exe"
    [MT]="https://www.sefaz.rs.gov.br/DWN/Downloadstg.aspx"
    [MS]="https://www.sefaz.ms.gov.br/?s=Sintegra"
    [MG]="http://consultasintegra.fazenda.mg.gov.br/"
    [PA]="https://app.sefa.pa.gov.br/sintegra/"
    [PB]="https://www4.sefaz.pb.gov.br/sintegra/SINf_ConsultaSintegra.jsp"
    [PE]="http://receita.fazenda.rs.gov.br/download/1849"
    [PI]="https://portal.sefaz.pi.gov.br/sintegra-aviso"
    [PR]="http://www.sintegra.fazenda.pr.gov.br/sintegra/"
    [RJ]="https://portal.fazenda.rj.gov.br/icms/sintegra/"
    [RN]="http://www.set.rn.gov.br/uvt/consultacontribuinte.aspx"
    [RO]="https://portalcontribuinte.sefin.ro.gov.br/Publico/parametropublica.jsp"
    [RR]="https://www.sefaz.rr.gov.br/sintegra/"
    [RS]="https://www.sefaz.rs.gov.br/consultas/contribuinte"
    [SC]="https://sat.sef.sc.gov.br/tax.NET/Sat.Cadastro.Web/ComprovanteIE/Consulta.aspx"
    [SE]="https://security.sefaz.se.gov.br/SIC/sintegra/index.jsp"
    [SP]="https://portal.fazenda.sp.gov.br/servicos/icms/Downloads/InstalaValidadorSintegra2015.5.3.0.zip"
    [TO]="https://sintegra.sefaz.to.gov.br/sintegra/servlet/wpsico01"

)



# Pega o valor correspondente.

LINK=${LINKS[$UF]}

if [ -z "$LINK" ]; then

    yad --center --window-icon="$logo" --error --text="Ainda não há link configurado para $UF." --buttons-layout=center --button="OK"  2> /dev/null

    exit 1

fi





baixarexe(){

# Baixar e instalar


if [[ "$LINK" == *.exe ]]; then

ARQUIVO="$cache_path/sintegra.exe"

fi


if [[ "$LINK" == *.zip ]]; then

ARQUIVO="$cache_path/sintegra.zip"

fi


yad --center --window-icon="$logo" --info --text="Baixando o Sintegra de $UF..." --buttons-layout=center --button="OK"  2> /dev/null

wget -O "$ARQUIVO" -c "$LINK" | tee -a "$log"


if [ $? -eq 0 ]; then

    yad --center --window-icon="$logo" --question --text="Download concluído.\nDeseja executar o instalador agora?" \
        --button=Sim:0 --button=Não:1 --buttons-layout=center --button="OK"  2> /dev/null

    if [ $? -eq 0 ]; then


if [[ "$ARQUIVO" == *.zip ]]; then

ARQUIVO="$cache_path/sintegra.zip"

  unzip $ARQUIVO -d $cache_path | tee -a "$log"

  sleep 2

ARQUIVO="$cache_path/*sintegra*.exe"

fi

        wine "$ARQUIVO" | tee -a "$log"

       # wine ted.exe | tee -a "$log"


      # Executando


# Verificar se a pasta ~/.wine/drive_c/

if [ -d "$HOME/.wine/drive_c/" ]; then

    echo "✅ A pasta $HOME/.wine/drive_c/ existe."


      # Sintegra:

      # wine $HOME/.wine/drive_c/Program*/Validador*/ValidadorSintegra2006.exe




# Mais genérico e pega qualquer versão instalada do programa Sintegra.

PROG=$(find $HOME/.wine/drive_c/Program* -type f -iname "ValidadorSintegra*.exe" | head -n 1)

if [ -z "$PROG" ]; then

    echo "Validador Sintegra não encontrado."

    yad --center --window-icon="$logo" --info --text="Validador Sintegra não encontrado." --buttons-layout=center --button="OK"  2> /dev/null

fi

wine "$PROG" | tee -a "$log"



      # Ted:

      # wine $HOME/.wine/drive_c/SefaNet/Ted.exe


else

    echo -e "\n❌ A pasta $HOME/.wine/drive_c/ não foi encontrada.\n"

    yad --center --window-icon="$logo" --error --text="A pasta $HOME/.wine/drive_c/ não foi encontrada." --buttons-layout=center --button="OK"  2> /dev/null

fi



    else

        yad --center --window-icon="$logo" --info --text="Instalador salvo em $ARQUIVO" --buttons-layout=center --button="OK"  2> /dev/null

    fi

else

    yad --center --window-icon="$logo" --error --text="Erro ao baixar o Sintegra de $UF." --buttons-layout=center --button="OK"  2> /dev/null

fi


   endInstall


}



    # Verifica se termina com .exe ou com .zip.

    if [[ "$LINK" == *.exe || "$LINK" == *.zip ]]; then

        echo -e "\n$UF -> Arquivo executável: $LINK \n" | tee -a "$log"

        baixarexe

    fi


    # Verifica se o link não termina em .exe ou .zip.

    if [[ "$LINK" != *.exe || "$LINK" != *.zip ]]; then

        echo -e "\nAbrindo site do $UF: $LINK \n" | tee -a "$log"

        xdg-open "$LINK" >/dev/null 2>&1
    fi


# Desde 2014, foi extinta a obrigatoriedade de envio de arquivos SINTEGRA no Estado do Rio de Janeiro.



fi


# ----------------------------------------------------------------------------------------

if [ "$acao" = "DAC AL" ]; then

# Instalador DAC (2.2.10.12)

# http://gcs.sefaz.al.gov.br/documentos/visualizarDocumento.action?key=t%2Bu8AZkwAeQ%3D

# InstalaDAC221012.exe

# https://www.sefaz.al.gov.br/downloads



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
    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"
    rm -Rf $HOME/.local/share/applications/wine/Programs/Sefaz-AL* 2>> "$log"
else
    echo -e "\n❌ A pasta do Wine NÃO existe. \n"
fi

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIEF CE" ] ; then # Precisa de banco de dados Firebird.

# https://www.sefaz.ce.gov.br/


  # configurarWine

  download "https://servicos.sefaz.ce.gov.br/internet/download/dief/dief.exe" "$cache_path/dief.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief.exe /quiet"
  sleep 3
  pkill fbguard  2>> "$log"
  pkill fbserver 2>> "$log"
  cp  $HOME/.local/share/applications/wine/Programs/SEFAZ-CE/DIEF/DIEF.desktop "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"
    rm -rf   $HOME/.local/share/applications/wine/Programs/SEFAZ-CE* 2>> "$log"
else
    echo -e "\n❌ A pasta do Wine NÃO existe. \n"
fi


  rm -rf "$desktop_path/DIEF.desktop" 2>> "$log"

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Livro Eletronico GDF" ] ; then

# http://www.livroeletronico.fazenda.df.gov.br/novovalidador/Manual.html

# $ file validadorlfe.exe 
# validadorlfe.exe: PE32 executable for MS Windows 4.00 (GUI), Intel i386, 8 sections


  # win="win64"
  # tricks="dotnet"
  # setWinePrefix "$win" "$stricks"
  # configurarWine

  cd $HOME/
  download "http://www.livroeletronico.fazenda.df.gov.br/validadorLFE/validadorlfe.exe" "$cache_path/Validadoreslfe.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks dotnet452"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/Validadoreslfe.exe"
  sleep 3
  cp  $HOME/.local/share/applications/wine/Programs/Validador/Validador.desktop "$desktop_path/Validadores"  2>> "$log"
  mv "$desktop_path/Validadores/validador.desktop" "$desktop_path/Validadores/LivroEletronicoDF.desktop" 2>> "$log"



# Verificação da existência do diretório

if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"
    rm -rf   $HOME/.local/share/applications/wine/Programs/Validador* 2>> "$log"

else

    echo -e "\n❌ A pasta do Wine NÃO existe. \n"

fi


  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DIEF MA" ] ; then

# https://sistemas1.sefaz.ma.gov.br/portalsefaz/jsp/pagina/pagina.jsf?codigo=1610


  # win="win32"
  # tricks="mdac28"
  # setWinePrefix "$win" "$stricks"
  # configurarWine




  # download "--header='Accept: text/html' --user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0' http://downloads.sefaz.ma.gov.br/diefportal/Instalador_DIEF64_32bits.EXE"  "$cache_path/Instalador_DIEF64_32bits.EXE"
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40 mdac28"
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/Instalador_DIEF64_32bits.EXE"

  # sleep 1

  # cd $HOME
  # cp -f  $HOME/.local/share/applications/wine/Programs/Programas\ SEFAZ-MA/DIEF64.desktop "$desktop_path/Validadores" 2>> "$log"
  # cp -r "$HOME/.mdac28/drive_c/Documents and Settings/All Users/Dief64" "$HOME/.mdac28/drive_c/ProgramData/"          2>> "$log"


# Verificação da existência do diretório

# if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
#    echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"
#    rm -rf   $HOME/.local/share/applications/wine/Programs/Programas* 2>> "$log"
# else
#    echo -e "\n❌ A pasta do Wine NÃO existe. \n"
# fi

#  rm -rf  "$desktop_path/DIEF64.desktop" 2>> "$log"



  download="http://downloads.sefaz.ma.gov.br/dief/Instalador_Unico_v6u3.EXE" 

  wget -c "$download" -O "$cache_path/dief-ma.exe" | tee -a "$log"

  sleep 1

  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40  mdac28"
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/gia9.exe"

  wine "$cache_path"/dief-ma.exe | tee -a "$log"



  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DES-PBH-ISS" ]; then # Ainda não consegui completar

# https://servicos.pbh.gov.br/servicos+5dc8470253fd6b5bbd99185f?q=Imposto+Sobre+Servi%C3%A7os&params=%7B%22filters%22%3A%7B%22query%22%3A%22Imposto+Sobre+Servi%C3%A7os%22%7D%2C%22sorters%22%3A%7B%22sort%22%3A%7B%22viewCount%22%3A%22desc%22%7D%7D%7D

# https://servicos.pbh.gov.br/servicos+des-declaracao-eletronica-de-servicos-protocolo-de-entrega-e-arquivo+63779e98e959e52d9a3af6fc

# https://servicos.pbh.gov.br/servicos+des-consulta-de-declaracao-eletronica-de-servicos-entregue+638e228cb9b643419b30f74e

echo "

O DES-PBH-ISS é um documento eletrônico utilizado para o pagamento e declaração do ISS (Imposto Sobre Serviços) em Belo Horizonte, Minas Gerais.


ISSQN - Emissão de Nota Fiscal de Serviços Eletrônica - NFSe (todas as empresas, exceto MEI)

https://servicos.pbh.gov.br/servicos+issqn-emissao-de-nota-fiscal-de-servicos-eletronica-nfse-todas-as-empresas-exceto-mei+5ed6e8da1784922e85c8792c

https://bhissdigital.pbh.gov.br/nfse/

" | yad --center --window-icon="$logo" --title "GIA RS" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null




  # executar "apt install -y icedtea-netx"
  # showMessage "Nas próximas mensagens, marque a única opção que aparecer na tela e depois clique no botão Later, Continuar e Executar."
  # javaws http://bhissdigital.pbh.gov.br/des-ws/desapp/des.jnlp

  # des_path=$(find "$desktop_path" -name "jws_app_shortcut_*")

  # while [ ! -f "$des_path" ]; do
  #  sleep 2
  #  des_path=$(find "$desktop_path" -name "jws_app_shortcut_*")
  # done

  # mv "$des_path" "$desktop_path/Validadores"           2>> "$log"
  # rm -Rf $HOME/.local/share/applications/jws_app_shortcut* 2>> "$log"

  # endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GIA MT" ]; then

# https://www5.sefaz.mt.gov.br/inicio?_com_liferay_portal_search_web_portlet_SearchPortlet_formDate=1761275722162&p_p_id=com_liferay_portal_search_web_portlet_SearchPortlet&p_p_lifecycle=0&p_p_state=maximized&p_p_mode=view&_com_liferay_portal_search_web_portlet_SearchPortlet_mvcPath=%2Fsearch.jsp&_com_liferay_portal_search_web_portlet_SearchPortlet_redirect=https%3A%2F%2Fwww5.sefaz.mt.gov.br%2Finicio%3Fp_p_id%3Dcom_liferay_portal_search_web_portlet_SearchPortlet%26p_p_lifecycle%3D0%26p_p_state%3Dnormal%26p_p_mode%3Dview&_com_liferay_portal_search_web_portlet_SearchPortlet_keywords=gia&_com_liferay_portal_search_web_portlet_SearchPortlet_scope=this-site

# https://www5.sefaz.mt.gov.br/-/6425689-gia-icms-eletronica?p_l_back_url=https%3A%2F%2Fwww5.sefaz.mt.gov.br%2Finicio%3Fp_p_id%3Dcom_liferay_portal_search_web_portlet_SearchPortlet%26p_p_lifecycle%3D0%26p_p_state%3Dmaximized%26p_p_mode%3Dview%26_com_liferay_portal_search_web_portlet_SearchPortlet_redirect%3Dhttps%253A%252F%252Fwww5.sefaz.mt.gov.br%252Finicio%253Fp_p_id%253Dcom_liferay_portal_search_web_portlet_SearchPortlet%2526p_p_lifecycle%253D0%2526p_p_state%253Dnormal%2526p_p_mode%253Dview%26_com_liferay_portal_search_web_portlet_SearchPortlet_mvcPath%3D%252Fsearch.jsp%26_com_liferay_portal_search_web_portlet_SearchPortlet_keywords%3Dgia%26_com_liferay_portal_search_web_portlet_SearchPortlet_formDate%3D1761275722162%26_com_liferay_portal_search_web_portlet_SearchPortlet_scope%3Dthis-site&p_l_back_url_title=In%C3%ADcio

  # win="win32"
  # tricks="wine32"

  configurarWine
  download "https://www5.sefaz.mt.gov.br/documents/6071037/6425881/GIA_ICMS_307n_Completa.zip/89428c61-91cb-878a-153e-99535b281a26?t=1684931631844" "$cache_path/gia.zip"
  unzip "$cache_path"/gia.zip -d "$cache_path" 2>> "$log"
  sleep 2
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/GIA_ICMS_307n_Completa/GIA_ICMS_307n_Completa.exe"
  sleep 1
  mv -f "$desktop_path/GIA 3.07.desktop" "$desktop_path/Validadores"  2>> "$log"
  download "https://www5.sefaz.mt.gov.br/documents/6071037/6425881/GIA_ICMS_307n_Atualizacao.zip/265e7874-a097-5527-ee5a-f82fbffda694?t=1684931629746" "$cache_path/gia_atualizacao.zip"
  unzip "$cache_path"/gia_atualizacao.zip -d ./cache 2>> "$log"
  sleep 2
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/GIA_ICMS_307n_Atualizacao/GIA_ICMS_307n_Atualizacao.exe"
  sleep 1

  endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GIA RS" ] ; then

# https://fazenda.rs.gov.br/busca?palavraschave=GIA&periodoini=
# https://fazenda.rs.gov.br/servicos-a-empresas

# https://atendimento.receita.rs.gov.br/substituicao-gia
# https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/ManualGIA9.pdf

echo "

A GIA (Guia de Informação e Apuração) é um documento utilizado para o registro e a apuração de tributos estaduais, mais especificamente no Estado do 
Rio Grande do Sul, no Brasil. Ela é exigida pela Secretaria da Fazenda do Estado (SEFAZ-RS) para o cumprimento das obrigações fiscais de empresas que 
atuam no estado, como o ICMS (Imposto sobre Circulação de Mercadorias e Serviços) e outros tributos estaduais.

No portal https://fazenda.rs.gov.br , a GIA é geralmente utilizada para:

1. Apuração do ICMS: Empresas que estão registradas no Estado do Rio Grande do Sul devem apurar e informar o valor do ICMS devido. Isso inclui tanto 
o ICMS próprio (relativo às operações de venda e circulação de mercadorias) quanto o ICMS por substituição tributária (quando a responsabilidade pelo 
pagamento do tributo é transferida para outra empresa).

2. Declaração e Regularização Fiscal: A GIA permite que as empresas realizem a apuração do imposto devido, declarem e paguem o ICMS ou outros tributos 
estaduais devidos.

3. Entrega Mensal: Em muitos casos, a GIA deve ser preenchida e enviada mensalmente para a SEFAZ-RS, com a apuração do imposto devido durante o mês 
anterior.

A GIA é preenchida diretamente no sistema da SEFAZ-RS e, dependendo da atividade da empresa, pode ser obrigatória para o cumprimento das obrigações 
tributárias estaduais.

" | yad --center --window-icon="$logo" --title "GIA RS" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null




# Como fazer o preenchimento e envio da GIA?

# A instalação do novo programa Instala GIA Versão 9 é independente da atualização da Versão 8 do programa. Assim, ambas as versões podem ser instaladas 
# no computador, sem a necessidade de utilizar o programa Atualiza GIA.

# Nesse sentido, a Versão 9 deve ser utilizada para GIAs com mês de referência a partir de setembro/2017. Nessa versão, o contribuinte deve importar a 
# EFD no aplicativo da GIA e ele fará automaticamente o preenchimento dos campos da declaração.

# O aplicativo da GIA Versão 9 está disponível para download em: https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/InstalaGIA9.exe


  # win="win32"
  # tricks="wine32"
  # setWinePrefix "$win" "$tricks"

  # download "https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/InstalaGIA9.exe" "$cache_path/gia9.exe"


  download="https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/InstalaGIA9.exe" 

  wget -c "$download" -O "$cache_path/gia9.exe" | tee -a "$log"

  sleep 1

  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40  mdac28"
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/gia9.exe"

  wine "$cache_path"/gia9.exe | tee -a "$log"


  # mkdir -p /opt/projetus/facilitador/cache/atualizacao 2>> "$log"
  # download "https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/AtualizaGia9.exe" "$cache_path/atualizacao/AtualizaGia9.exe"
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/atualizacao/AtualizaGia9.EXE"


# Verificação da existência do diretório

# if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then
#     echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"
#     rm -rf  "$HOME/.local/share/applications/wine/Programs/GIA 9" 2>> "$log"
# else
#     echo -e "\n❌ A pasta do Wine NÃO existe. \n"
# fi


#   mv -f "$desktop_path/GIA 9.desktop" "$desktop_path/Validadores" 2>> "$log"

#   rm -rf  "$desktop_path/GIA 9.lnk" 2>> "$log"


  endInstall

fi 

# ----------------------------------------------------------------------------------------


if [ "$acao" = "DIEF PA" ] ; then # instala mais não inicia erro de comunicação de java


# DIEF Comércio Exterior

# É a apresentação de Declaração eletrônica, DIEF - Comercio Exterior, por ocasião da realização das operações de importação de mercadorias ou bens provenientes do exterior por contribuinte deste Estado, conforme estabelece a Instrução normativa 020/2005.

# https://www.sefa.pa.gov.br/internal/services/iig
# https://app.sefa.pa.gov.br/pservicos/autenticacao?servico=https://app.sefa.pa.gov.br:443/dief-comercio-exterior/index.html



# Consulta DIEF

# É a consulta do recibo definitivo da DIEF, processado pela Secretaria de Estado da Fazenda (SEFA), após a validação dos dados enviados no arquivo enviado de DIEF.

# https://app.sefa.pa.gov.br/pservicos/autenticacao?servico=https://app.sefa.pa.gov.br:443/consulta-dief/index.jsp

# https://www.sefa.pa.gov.br/internal/services/iif


echo "

No contexto da Secretaria da Fazenda do Estado do Pará (SEFA-PA), a DIEF é a Declaração de Informações Econômico-Fiscais. Essa declaração é exigida 
pelo estado do Pará para empresas que estão obrigadas a prestar informações detalhadas sobre suas operações econômicas e fiscais, com o objetivo de 
facilitar a fiscalização e a apuração de tributos.

### O que é a DIEF?

A DIEF é um documento digital que as empresas precisam enviar para a SEFA-PA, contendo informações detalhadas sobre:

1. Movimentação de mercadorias (entrada e saída de produtos);
2. Operações fiscais (como a apuração de ICMS, por exemplo);
3. Impostos devidos e pagos;
4. Outras informações econômico-fiscais necessárias para o controle fiscal e tributário do estado.

### Objetivo da DIEF

A principal finalidade da DIEF é melhorar o processo de monitoramento e fiscalização da SEFA-PA, garantindo que as empresas cumpram suas obrigações 
tributárias e fiscais corretamente. O envio dessa declaração facilita o processo de apuração de impostos como o ICMS e contribui para a redução de 
sonegação fiscal.

### Quem deve enviar a DIEF?

Normalmente, empresas que realizam operações sujeitas ao ICMS ou que atendem a outras condições estabelecidas pela SEFA-PA são obrigadas a enviar a 
DIEF. Isso inclui:

* Indústrias;
* Comerciantes;
* Distribuidores e varejistas;
* Prestadores de serviços (quando aplicável).

### Como enviar a DIEF?

O envio da DIEF é feito de forma digital, geralmente por meio de um sistema disponibilizado pela SEFA-PA. As empresas devem acessar o Portal da SEFA-PA, 
onde poderão preencher e enviar a declaração de forma eletrônica.

### Principais características:

* Formato eletrônico: A DIEF é uma declaração digital, e o envio é feito via sistema da SEFA-PA.
* Periodicidade: O envio da DIEF pode ser mensal ou conforme a periodicidade exigida pela SEFA-PA.
* Validação: Após o envio, a SEFA-PA realiza a validação das informações e pode cobrar as empresas em caso de inconsistências.

### Acessando a DIEF no Portal da SEFA-PA

Você pode acessar mais informações sobre a DIEF e fazer o envio diretamente pelo portal da SEFA-PA, na área destinada ao DIEF e outras obrigações fiscais.

Acesse o portal oficial: https://www.sefa.pa.gov.br e procure pela seção de Declaração de Informações Econômico-Fiscais ou DIEF.

### Resumo

A DIEF é uma declaração obrigatória para empresas que realizam operações econômicas e fiscais no estado do Pará, especialmente no que diz respeito ao 
ICMS. Ela tem como objetivo facilitar a fiscalização e garantir a correta apuração de tributos no estado. Para enviar a DIEF, as empresas devem acessar o 
Portal da SEFA-PA e seguir as instruções para o envio eletrônico.

" | yad --center --window-icon="$logo" --title "DIEF PA" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null



  # naoCompativel

  # Limpeza da versao antiga

  # rm -rf $user_path/.wine/drive_c/DIEF20* 2>> "$log"

  # Instalação do app via wine
  # download "http://www.sefa.pa.gov.br/arquivos/downloads/dief/2022/DIEF2022.2.0.msi" "$cache_path/DIEF2022.msi"
  # cd $cache_path
  # executar "flatpak run --command=wine io.github.fastrizwaan.WineZGUI DIEF2022.msi /quite /qn"
  # sleep 1

  # Download da JRE versão windows
  # cd $user_path/.wine/drive_c/DIEF2022.2.0/
  # executar "wget  https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u252-b09.1/OpenJDK8U-jre_x86-32_windows_hotspot_8u252b09.zip " "Baixando JRE"
  # mv OpenJDK8U-jre_x86-32_windows_hotspot_8u252b09.zip jre.zip 2>> "$log"
  # unzip jre.zip           2>> "$log"
  # mv jdk8u252-b09-jre jre 2>> "$log"
  # rm -rf jre.zip          2>> "$log"

  # cd "$desktop_path/"
  # mv DIEF2022.2.0.desktop "$desktop_path/Validadores/DIEF-PA-2022.2.0.desktop" 2>> "$log"
  # rm -rf DIEF20*.* 2>> "$log"

  # endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "GIM ICMS PB" ] ; then

# https://www.sefaz.pb.gov.br/info/declaracoes/gim

# https://www.sefaz.pb.gov.br/servirtual/declaracoes/carregar-gim-on-line

# https://www.sefaz.pb.gov.br/ser/servirtual


echo "O GIM (Gestão de Informações Municipais) é um sistema desenvolvido pela Secretaria da Fazenda do Estado da Paraíba (SEF-PB) para facilitar a gestão 
e a prestação de informações fiscais por parte dos municípios. Ele é utilizado por prefeituras para enviar dados relacionados à tributação e fiscalizações, 
entre outras funções.

No contexto do SEF-PB, o GIM é essencial para a integração e o envio das informações municipais de forma padronizada para o sistema da SEF, geralmente com 
foco em facilitar o processo de apuração de tributos e a comunicação entre os municípios e o Estado.

O GIM (Gestão de Informações Municipais) não está mais sendo utilizado ou não é mais oferecido diretamente pelo site da SEF-PB (Secretaria da Fazenda do 
Estado da Paraíba).


O GIM (Gestão de Informações Municipais) foi, de fato, descontinuado em 2019 pela Secretaria da Fazenda do Estado da Paraíba (SEF-PB). A SEF-PB decidiu 
descontinuar o sistema GIM em favor de novas soluções mais modernas e integradas para a gestão tributária e fiscal.

O que aconteceu com o GIM após a descontinuação?

A descontinuação do GIM em 2019 não significa que os municípios da Paraíba ficaram sem uma plataforma para enviar suas informações fiscais. O sistema foi 
substituído por novas plataformas que integram a gestão tributária de forma mais eficiente, como o SEFWeb.

Sistema SEFWeb

O SEFWeb é uma plataforma mais moderna e centralizada que a SEF-PB passou a utilizar para permitir que os contribuintes, incluindo prefeituras, enviem as 
informações fiscais e tributárias. O SEFWeb oferece funcionalidades como:

Emissão de documentos fiscais

Declaração de impostos

Apuração e envio de tributos municipais

Gestão de informações fiscais de forma online

Como acessar o SEFWeb ou outro sistema atual?

Se você está buscando uma alternativa ao GIM que ainda seja válida, o sistema SEFWeb é a resposta. Você pode acessá-lo e utilizá-lo diretamente no site 
da SEF-PB.

SEFWeb: O acesso ao SEFWeb é feito através de uma área restrita do portal da SEF-PB, onde você pode logar com o seu CNPJ ou outras credenciais fornecidas 
pela Secretaria da Fazenda do Estado.

Aqui estão alguns passos gerais para acessar ou entender mais sobre o SEFWeb:

Acesse o Portal da SEF-PB:

Vá para https://www.sefaz.pb.gov.br/


Busque pelo SEFWeb ou Sistema de Gestão Fiscal:

O SEFWeb pode estar listado na seção de Sistemas ou Serviços da página principal. Caso contrário, pode estar diretamente no portal para contribuintes ou 
na área destinada aos municípios.

Cadastro e Acesso:
Se ainda não estiver cadastrado, você precisará fazer o cadastro e gerar suas credenciais de acesso.

Documentação e Manuais:
Se você tiver dúvidas de como usar o SEFWeb ou de como migrar de um sistema antigo, a SEF-PB provavelmente oferece manuais ou orientações técnicas para 
facilitar a transição.

E o que fazer com o GIM que estava em uso antes de 2019?

Caso você precise de informações antigas que foram enviadas pelo GIM antes de sua descontinuação, o ideal é verificar com a SEF-PB como acessar ou obter esses 
dados históricos. Eles podem ter armazenado essas informações em outros sistemas de backup ou repositórios.

Conclusão

Como o GIM foi descontinuado em 2019, você deve migrar para o SEFWeb ou outro sistema de gestão fiscal da SEF-PB, que agora é a plataforma oficial para envio 
de informações fiscais e tributárias dos municípios. Para mais detalhes, entre em contato com o suporte técnico da SEF-PB, caso tenha algum processo pendente 
no GIM ou dúvidas sobre a transição para os novos sistemas.

Se precisar de mais informações ou ajuda com qualquer parte do processo, estou à disposição!


Após a descontinuação do GIM (Gestão de Informações Municipais), a SEF-PB migrou para o sistema EFD (Escrituração Fiscal Digital), que agora é a plataforma 
responsável para a escrituração fiscal e o envio de dados fiscais das prefeituras da Paraíba.

### O que é a EFD (Escrituração Fiscal Digital)?

A EFD é uma plataforma que visa digitalizar e automatizar os processos de escrituração fiscal e o envio de informações fiscais ao fisco estadual. 
Esse sistema substitui o antigo GIM e agora é o canal oficial para a prestação de contas fiscais e o envio de dados para o SEF-PB.

### O link que você mencionou:

O endereço https://www.sefaz.pb.gov.br/ser/servirtual/escrituracao-fiscal/consulta-obrigatoriedade-de-efd oferece informações relacionadas à consulta da 
obrigatoriedade de entrega da EFD.

No caso, essa página tem como objetivo ajudar os contribuintes a verificarem se estão obrigados a entregar a Escrituração Fiscal Digital (EFD) e qual a 
forma de entrega.

### O que você pode encontrar nessa página?

1. Consulta de Obrigatoriedade:

   Nessa seção, o contribuinte ou município pode consultar se está obrigado a entregar a EFD. Isso inclui a consulta para saber se a empresa ou município 
precisa enviar os dados fiscais através da EFD de acordo com o seu perfil e as informações cadastradas na SEF-PB.

2. Detalhes sobre o Processo de Escrituração:

   Caso o contribuinte ou município seja obrigado a enviar a EFD, serão fornecidas instruções de como gerar e enviar a escrituração fiscal digital, com 
informações detalhadas sobre os arquivos a serem gerados, como o Arquivo Digital (XML) e o Padrão de Envio.

3. Informações Técnicas:

   A página pode conter manuais, guias, e exigências técnicas sobre como preparar os arquivos da EFD, além de fornecer links para outros sistemas relacionados, 
como a Plataforma Nacional de Escrituração Fiscal e ferramentas de geração dos arquivos fiscais.

4. Integração com o SEFWeb:

   Em muitos casos, a EFD está integrada a outros sistemas de gestão tributária, como o SEFWeb, que pode ser utilizado para enviar as informações de 
forma integrada e segura.

### O que você precisa fazer?

Se a sua prefeitura ou empresa está obrigata a enviar a EFD, você pode:

1. Consultar sua obrigatoriedade diretamente na página.
2. Seguir os passos fornecidos para gerar e enviar os arquivos da EFD.
3. Caso tenha dúvidas, consultar a documentação disponível na SEF-PB ou entrar em contato com o suporte para mais detalhes.

### Como migrar de GIM para EFD?

Para quem estava utilizando o GIM e agora precisa migrar para a EFD, é importante verificar se há necessidade de atualizar dados históricos, fazer ajustes na 
escrituração fiscal digital ou transferir informações do antigo sistema para o novo. A SEF-PB deve ter orientações sobre o processo de transição ou como adaptar as 
informações para o novo sistema.

### Conclusão

Agora, com a descontinuação do GIM, a EFD é a plataforma centralizada para o envio de dados fiscais. A página que você mencionou fornece a consulta à obrigatoriedade de 
entrega da EFD e detalhes de como os contribuintes devem proceder.

Se precisar de ajuda para navegar ou entender melhor as etapas de envio ou consulta, posso ajudar mais!


" | yad --center --window-icon="$logo" --title "GIM (Gestão de Informações Municipais)" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1500" --height="730"  2> /dev/null


# OBRIGATORIEDADE DA EFD 2019 - SIMPLES NACIONAL

# Conforme o disposto no Decreto 38.165, de 14 de março de 2018, todos os contribuintes obrigados a apresentação da GIM, passarão  a entregar  a Escrituração Fiscal Digital - EFD a partir da referência 01/2019. Os contribuintes que possuam receita bruta anual igual ou inferiorde R$ 120.000,00 (cento e vinte mil reais), ficarão dispensados da entrega da EFD a partir de 1º de janeiro de 2019. O arquivo digital deverá ser enviado até o dia 20 (vinte) do mês subsequente ao encerramento do mês apurado, conforme Decreto 38.889 de 17 de Dezembro de 2018.

# Para consultar se um contribuinte do Estado da Paraíba está obrigada a entrega da EFD

# https://www.sefaz.pb.gov.br/ser/servirtual/escrituracao-fiscal/consulta-obrigatoriedade-de-efd


  # win="win32"
  # tricks="wine32"
  # configurarWine
  # setWinePrefix "$win" "$tricks"

  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks mdac28 jet40" # Nessa ordem
  # sleep 1
  # download "http://www.sefaz.pb.gov.br/ser/images/docs/downloads/GIM/InstalaGimSREPB-Ver_2473.exe"  "$cache_path/gimsrepb.exe"
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/gimsrepb.exe"
  # sleep 1
  # cd $HOME
  # mv -f "$desktop_path/Gim SRE-PB.desktop" "$desktop_path/Validadores" 2>> "$log"


# Verificação da existência do diretório

# if [ -d "$HOME/.local/share/applications/wine/Programs/" ]; then

#     echo -e "\n✅ A pasta do Wine existe: $HOME/.local/share/applications/wine/Programs/ \n"

#     rm -rf  $HOME/.local/share/applications/wine/Programs/SRE-PB 2>> "$log"

# else

#     echo -e "\n❌ A pasta do Wine NÃO existe. \n"

# fi

  
#   rm -rf  "$desktop_path/Gim SRE-PB.lnk" 2>> "$log"

#   endInstall

fi 


# ----------------------------------------------------------------------------------------

if [ "$acao" = "SEDIF-SN" ] ; then 

# https://www.fazenda.mg.gov.br/empresas/declaracoes_demonstrativos
# https://www.fazenda.mg.gov.br/empresas/declaracoes_demonstrativos/DeSTDA_SEDIF-SN/SEDIF_Aplicativo


# ----------------------------------------------------------------------------------------

echo "
SEDIF-SN é um aplicativo gratuito disponibilizado para os contribuintes do SN (ME e EPP) para gerar e transmitir as UF(s) o arquivo digital da 
DeSTDA (Declaração de Substituição Tributária, Diferencial de Alíquota e Antecipação do ICMS) de acordo com Ajuste Sinief 12/2015. Para fins 
do cumprimento da obrigação, o contribuinte deverá entregar esse arquivo digital, de cada período, apenas uma única vez para cada UF, salvo a 
entrega com finalidade de retificação. O arquivo digital será recepcionado diretamente pela UF destinatária da declaração. Não será permitido 
o envio de arquivo digital complementar.

Mais informações no portal nacional do SEDIF.

http://www.sedif.pe.gov.br/

    A DeSTDA só poderá ser transmitida para a (s) UF (s) com a versão mais atualizada, ao tentar transmitir uma declaração com uma versão antiga 
a atualização será automatizada caso exista uma conexão, um serviço on-line é necessário para essa tarefa.
    Importante ressaltar que o aplicativo TED no estado de Minas Gerais NÃO será utilizado, uma vez que a recepção dos arquivos é realizada via 
Web Services.

    Consulte o Manual do Usuário SEDIF-SN e arquivo de Perguntas e Respostas disponibilizados neste portal.

* Canais de Atendimento na SEF/Minas Gerais

https://www.fazenda.mg.gov.br/atendimento/


Subsecretaria da Receita Estadual (SRE)
Superintendência de Arrecadação e Informações Fiscais (SAIF)

" | yad --center --window-icon="$logo" --title "SEDIF-SN-Sistema Eletrônico de Dados e Informações Fiscais do Simples Nacional" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1200" --height="730"  2> /dev/null

# ----------------------------------------------------------------------------------------



  # Baixando e executando programa principal

  # download "https://www.fazenda.mg.gov.br/export/sites/fazenda/empresas/declaracoes_demonstrativos/DeSTDA_SEDIF-SN/files/SEDIF010925.zip"   "$cache_path/sedif.zip"

  download="https://www.fazenda.mg.gov.br/export/sites/fazenda/empresas/declaracoes_demonstrativos/DeSTDA_SEDIF-SN/files/SEDIF010925.zip" 

  wget -c "$download" -O "$cache_path/SEDIF010925.zip" | tee -a "$log"


 # Para extrair

# Automatizar o processo para não ser interrompido, usando a opção -o para sobrescrever todos os arquivos automaticamente sem que o unzip pergunte.

  unzip -o "$cache_path/SEDIF010925.zip"       -d "$cache_path" | tee -a "$log"

  unzip -o "$cache_path/SEDIF/sedif_Setup.zip" -d "$cache_path" | tee -a "$log"


  cd "$cache_path"
  
  mv sedif_Setup.exe  sedif.exe | tee -a "$log"

  # configurarWine

  # Instalando complementos.
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks dotnet45"

  # Execuntando o executavel para instalação 
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/sedif.exe"
  
  # Tempo para serem criados os atalhos antes de copialos
  sleep 1

  wine sedif.exe | tee -a "$log"

  # Copiando o atalho para a pasta de Validadores
  # cp $HOME/.local/share/applications/wine/Programs/SimplesNacional/SEDIF/SEDIF.desktop "$desktop_path/Validadores" 2>> "$log"
  
  # Removendo links da Area de Trabalho
  # rm -rf  "$desktop_path/SEDIF.*" 2>> "$log"

  endInstall

fi 

# ----------------------------------------------------------------------------------------

if [ "$acao" = "DMED" ] ; then 


# Declarar serviços médicos e da saúde (DMED)

# https://www.gov.br/pt-br/servicos/declarar-servicos-medicos-e-da-saude
# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dmed


# ----------------------------------------------------------------------------------------

echo "
Declaração de Serviços Médicos e de Saúde

Utilize este programa para preencher a Declaração de Serviços Médicos e de Saúde (DMED). Esta declaração deve ser enviada por empresas e 
equiparadas prestadoras de serviços médicos e de saúde, ou planos de saúde.

O programa é multiexercício, portanto, para apresentar declarações relativas a anos anteriores, originais e retificadoras, utilize a última 
versão publicada do programa.

" | yad --center --window-icon="$logo" --title "DMED" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1200" --height="730"  2> /dev/null

# ----------------------------------------------------------------------------------------


  # download "https://servicos.receita.fazenda.gov.br/publico/programas/Dmed/${ano}/Dmed${ano}Linux-${ARCH}v1.0.sh"   "$cache_path/Dmed${ano}Linux-${ARCH}v1.0.sh"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/Dmed/${ano}/Dmed${ano}Linux-${ARCH}v1.0.sh" 

  wget -c "$download" -O "$cache_path/Dmed${ano}Linux-${ARCH}v1.0.sh" | tee -a "$log"

  cd "$cache_path"

  # Execuntando o executavel para instalação

  sudo chmod +x Dmed${ano}Linux-${ARCH}v1.0.sh

  sudo ./Dmed${ano}Linux-${ARCH}v1.0.sh

  # Tempo para serem criados os atalhos antes de ser copiados

  sleep 1

  # Copiando o atalho para a pasta de Validadores

  # mv -f "$desktop_path/Dmed${ano}.desktop" "$desktop_path/Validadores" 2>> "$log"
  
  endInstall

fi 

# ----------------------------------------------------------------------------------------

exit 0

