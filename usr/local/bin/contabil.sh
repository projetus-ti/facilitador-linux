#!/usr/bin/env bash
#
# Autor: Fabiano Henrique
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025
# Licença:  MIT
# Descricao: Script de instalação de aplicativos do contabil


# https://www.projetusti.com.br/


# Usar o .conf no script
# Para carregar as variáveis do .conf

source /etc/facilitador.conf


# Carrega as funções definidas em funcoes.sh

source /usr/local/bin/funcoes.sh


mkdir -p $HOME/.local/share/applications/


acao=$1

# ----------------------------------------------------------------------------------------

# Testa conectividade com a internet

testainternet

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SPED ECD" ]; then            

# http://sped.rfb.gov.br/pasta/show/1273
# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/sped/ecd

  echo -e "\nBaixando o Sped ECD...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/Sped/SpedContabil/SpedContabil_linux_x86_64-10.3.3.sh"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

    echo -e "\n✅ Sistema 64 bits detectado: $ARCH \n"

    wget -P "$cache_path" -c "$download" | tee -a "$log"

    sleep 2

    cd "$cache_path"

    chmod +x SpedContabil_linux_x86_64-10.3.3.sh

    sudo ./SpedContabil_linux_x86_64-10.3.3.sh 2>> "$log"


else

    echo "🧯 Sistema 32 bits detectado: $ARCH

Não existe versão do Sped ECD para arquitetura 32-bit atualmente para o Linux.
"

        yad --center --window-icon="$logo" --title="🧯 Sistema 32 bits detectado" \
        --text="Não existe versão do Sped ECD para arquitetura 32-bit atualmente para o Linux." \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

fi

endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "SPED ECF" ]; then

  # http://sped.rfb.gov.br/pasta/show/1287

  echo -e "\nBaixando o Sped ECF...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/Sped/ECF/SpedECF_linux_x86_64-11.3.4.sh"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

    echo -e "\n✅ Sistema 64 bits detectado: $ARCH \n"

    wget -P "$cache_path" -c "$download" | tee -a "$log"

    sleep 2

    cd "$cache_path"

    chmod +x SpedECF_linux_x86_64-11.3.4.sh

    sudo ./SpedECF_linux_x86_64-11.3.4.sh  2>> "$log"


else

    echo -e "\n🧯 Sistema 32 bits detectado: $ARCH

Não existe versão do Sped ECF para arquitetura 32-bit atualmente para o Linux.
\n"

        yad --center --window-icon="$logo"  --title="🧯 Sistema 32 bits detectado" \
        --text="Não existe versão do Sped ECF para arquitetura 32-bit atualmente para o Linux." \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null

fi

endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Receitanet" ]; then

# Receitanet

# O programa Receitanet é utilizado para validar e enviar pela internet os arquivos de 
# declarações e escriturações à Receita Federal.

# A máquina virtual java (JVM), versão 1.8 ou superior, deve estar instalada, pois 
# programa desenvolvido em Java não pode ser executado sem a JVM.

# Para instalar o Receitanet, é necessário adicionar permissão de execução, por meio do 
# comando "chmod +x Receitanet-1.32.jar" ou conforme o Gerenciador de Janelas utilizado. 
# Em seguida, execute "java -jar Receitanet-1.32.jar" na linha de comando. 


# https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanet


# ----------------------------------------------------------------------------------------

echo "

O Receitanet é um programa desenvolvido pela Receita Federal do Brasil utilizado para o envio de declarações de Imposto de Renda de pessoas físicas 
e jurídicas, além de ser uma ferramenta para o envio de documentos fiscais relacionados à Receita Federal.

🚀 Funções principais do Receitanet:

Envio de Declaração de Imposto de Renda:
O Receitanet é usado principalmente para enviar a Declaração de Imposto de Renda (IRPF) de pessoas físicas e jurídicas para a Receita Federal. Esse 
envio ocorre após o preenchimento da declaração utilizando o programa Receita Federal - IRPF.

Envio de Declarações de Pessoas Jurídicas:
Também é utilizado para o envio de Declarações de Imposto de Renda de Pessoas Jurídicas (IRPJ), incluindo aquelas feitas por empresas que optam pelo 
Simples Nacional, Lucro Presumido, ou Lucro Real.

Declaração de Débitos e Créditos Tributários Federais:
O Receitanet também é utilizado para transmitir outras declarações fiscais à Receita Federal, como DCTF (Declaração de Débitos e Créditos Tributários 
Federais), DASN (Declaração Anual do Simples Nacional) e outras obrigações acessórias.

Declaração de Imposto sobre Produtos e Serviços (PIS, Cofins):
Outro uso importante do Receitanet é para o envio de documentos relacionados à Contribuição para o PIS/Pasep e Cofins, ambos de competência da Receita 
Federal.

🧩 Como funciona o Receitanet?

Instalação: O Receitanet é instalado em computadores com sistemas operacionais como Windows, macOS ou Linux.

Preenchimento da Declaração: Para enviar a Declaração de Imposto de Renda ou outro tipo de documento, o contribuinte primeiro preenche a declaração no 
Programa IRPF ou no programa correspondente (por exemplo, DCTF ou DASN).

Envio via Receitanet: Após o preenchimento da declaração, o programa Receitanet é usado para fazer a transmissão segura dos dados para a Receita Federal. 
Ele cria o Arquivo XML da declaração, que será enviado à Receita.

Recebimento de Comprovante: Depois de enviado, o Receitanet retorna um protocólo de recebimento (ou recibo), que serve como confirmação de que a declaração 
foi transmitida corretamente.

🛠️ Características principais:

Segurança: A transmissão dos dados é feita de forma segura, com criptografia para garantir a privacidade das informações enviadas.

Compatibilidade: Receitanet é compatível com as versões de sistemas operacionais Windows e as versões mais recentes de navegadores.

Validação: Antes de enviar a declaração, o Receitanet valida se os dados informados estão corretos, para evitar erros na transmissão.

📈 Versões:

O Receitanet sempre tem novas versões lançadas anualmente, principalmente para atualizar os requisitos de envio de declarações de Imposto de Renda, além de 
ajustes em outros programas da Receita Federal.

🧑‍💻 Onde baixar o Receitanet?

Você pode fazer o download do Receitanet diretamente do site da Receita Federal:

http://www.receita.fazenda.gov.br


⚠️ Dicas e Considerações:

Certificado Digital: Para alguns tipos de declaração, como as de empresas, é necessário o uso de um certificado digital para garantir a autenticidade da 
transmissão.

Atualização: Sempre instale a versão mais recente do Receitanet antes de enviar a declaração, para evitar problemas com a compatibilidade de novas obrigações 
fiscais.


O certificado digital utilizado no Receitanet para enviar declarações à Receita Federal é geralmente do tipo e-CPF (para pessoas físicas) ou e-CNPJ 
(para pessoas jurídicas). Esse certificado digital é necessário principalmente para garantir a autenticidade, segurança e integridade da comunicação entre 
o contribuinte e a Receita Federal.

### Tipos de Certificado Digital no Receitanet:

1. e-CPF (Certificado Digital de Pessoa Física):

   * Usado por pessoas físicas para assinar e transmitir suas declarações, como a Declaração de Imposto de Renda (IRPF), e outros documentos fiscais.

2. e-CNPJ (Certificado Digital de Pessoa Jurídica):

   * Usado por empresas (pessoas jurídicas) para transmitir suas declarações fiscais e de impostos, como DCTF, DASN, DIRF, entre outras.

Ambos os certificados podem ser adquiridos e instalados em diferentes tipos de mídia, como cartão inteligente (smart card) ou token USB, e também podem ser 
emitidos por uma Autoridade Certificadora (AC) credenciada pela ICP-Brasil.

### 🧩 Instalando Certificado Digital no Linux

Para usar o certificado digital no Receitanet em um sistema Linux, o processo envolve instalar e configurar a infraestrutura necessária para que o certificado 
funcione corretamente com os aplicativos da Receita Federal.

#### Passos para Instalar o Certificado Digital no Linux:

1. Instalar Pacotes Necessários:

   Para usar o certificado digital, você precisará de algumas bibliotecas e ferramentas. No Linux, as mais comuns são o OpenSSL e o pkcs11.

   Execute o comando abaixo para instalar as dependências no Void Linux (e outras distribuições baseadas no xbps ou apt):

   Para Void Linux:


   sudo xbps-install -Suvy openssl pcsc-lite pcsc-lite-devel


   Para Ubuntu/Debian:


   sudo apt install -y openssl pcscd pcsc-tools


2. Configurar o Leitor de Cartão (se for o caso):

   Se você estiver usando um certificado digital em um smartcard ou token USB, você precisará configurar o leitor de cartão inteligente no seu sistema.

   A maneira mais simples de testar a comunicação com o dispositivo é usar o comando pcsc_scan, que irá listar os leitores de cartões e tokens conectados:


   pcsc_scan


   Isso irá verificar se o leitor de cartão está sendo reconhecido corretamente.

3. Instalar o Software do Certificado Digital:

   A maioria dos certificados digitais exige a instalação de um driver ou software adicional, dependendo do tipo de dispositivo (smartcard, token USB).

   Se o certificado for emitido por uma Autoridade Certificadora específica (como Serasa, Certisign, Soluti, etc.), é possível que você precise baixar 
o software da própria autoridade para gerenciar o certificado. Para a maioria dos casos, o software necessário é o Middleware que fornece a interface 
entre o certificado e os aplicativos que o utilizam, como o Receitanet.

4. Instalar o Java e Certificados no Sistema:

   O Receitanet pode exigir a instalação do Java no sistema. Você pode verificar a versão do Java e instalar o OpenJDK se necessário.

   Instale o OpenJDK 21 (ou outra versão compatível):


   sudo xbps-install -Suvy openjdk21


   Para importar o certificado digital no Java, você pode usar o comando keytool para adicionar o certificado ao Keystore do Java, caso seja necessário.


5. Importar o Certificado no Navegador (caso use via Web):

   Se você estiver utilizando um serviço web da Receita Federal (como o PGD (Programa Gerador da Declaração) via navegador) para enviar a declaração, 
o certificado digital precisa ser importado no seu navegador.

   Para importar no Firefox ou Chrome, siga o procedimento de importação de certificados digitais (por exemplo, no 
Firefox: Preferências → Privacidade e Segurança → Certificados → Exibir Certificados).


### 🧑‍💻 Usando o Certificado Digital no Receitanet:

1. Após configurar o certificado digital corretamente, quando você executar o Receitanet, será necessário selecionar o certificado (geralmente ele aparece 
como uma opção) e confirmar o uso do mesmo para assinar e transmitir a declaração.

2. Verificação: Ao realizar o envio da declaração, o Receitanet irá usar o certificado digital para assinar a declaração e enviá-la à Receita Federal. Se 
houver algum problema, você será notificado.


### ⚠️ Considerações Finais:

* Compatibilidade: A compatibilidade do certificado digital no Linux depende muito do tipo de dispositivo (token, smartcard) e da Autoridade Certificadora. 
Certifique-se de baixar os drivers necessários.

* Certificado Digital Válido: Certifique-se de que seu certificado digital seja válido e esteja dentro do prazo de validade.

" | yad --center --window-icon="$logo" --title "Receitanet" --text-info --fontname "mono 10" --buttons-layout=center --button=OK:0 --width="1300" --height="730"  2> /dev/null

# ----------------------------------------------------------------------------------------


  echo -e "\nBaixando o Receitanet...\n"

  download="https://servicos.receita.fazenda.gov.br/publico/programas/receitanet/Receitanet-1.32.jar"

  wget -P "$cache_path" -c "$download" | tee -a "$log"

  FILE="$cache_path/Receitanet-1.32.jar"


  # Verifica se o arquivo existe.

  if [ -f "$FILE" ]; then

    # Adicionar permissão de execução, por meio do comando "chmod +x Receitanet-1.32.jar" 

    chmod +x "$FILE" 2>> "$log"

    sudo cp -r "$FILE" /opt/  2>> "$log"


    if command -v java >/dev/null 2>&1; then

    # Executa

    
    echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Receitanet
Name[pt_BR]=Receitanet
Comment=O programa Receitanet é utilizado para validar e enviar pela internet os arquivos de declarações e escriturações à Receita Federal.
Exec=java -jar /opt/Receitanet-1.32.jar
# Icon=
Terminal=false
# Categories=;
StartupNotify=true" > $HOME/.local/share/applications/receitanet.desktop


chmod +x $HOME/.local/share/applications/receitanet.desktop


  echo -e "\nInstalando o Receitanet... \n"

  java -jar /opt/Receitanet-1.32.jar | tee -a "$log"



    fi


  fi

endInstall

fi

# ----------------------------------------------------------------------------------------

if [ "$acao" = "Receita Net BX" ]; then

   # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanetbx/receitanetbx

   # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanetbx/download-do-programa-receitanetbx-windows

   # https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/receitanetbx/download-do-programa-receitanetbx-linux



# Multiplataforma (JAR)

  echo -e "\nBaixando o ReceitanetBX... \n"


ARCH=$(uname -m)

if [[ "$ARCH" == *"64"* ]]; then

  # https://servicos.receita.fazenda.gov.br/publico/programas/ReceitanetBX/ReceitanetBX-1.9.24.exe

  download="https://servicos.receita.fazenda.gov.br/publico/programas/ReceitanetBX/ReceitanetBX-1.9.24-Linux-x86_64-Install.bin"

  wget -P "$cache_path" -c "$download" | tee -a "$log"

  FILE="$cache_path/ReceitanetBX-1.9.24-Linux-x86_64-Install.bin"

  if [ -f "$FILE" ]; then

     chmod +x "$FILE" 2>> "$log"

     cd "$cache_path"

     sudo ./ReceitanetBX-1.9.24-Linux-x86_64-Install.bin 2>> "$log"


  fi


    # yad --center --class=InfinalitySettings --info --icon-name='dialog-warning' --window-icon="$logo" --title "Atenção!" \
    #     --text 'Na próxima tela, informe a pasta /opt/projetus/facilitador/java/' \
    #     --height="50" --width="450" 2>/dev/null





else

    echo -e "\n🧯 Sistema 32 bits detectado: $ARCH \n"


  download="https://servicos.receita.fazenda.gov.br/publico/programas/ReceitanetBX/ReceitanetBX-1.9.24-Linux-x86-Install.bin"

  wget -P "$cache_path" -c "$download" | tee -a "$log"

  FILE="$cache_path/ReceitanetBX-1.9.24-Linux-x86-Install.bin"

  if [ -f "$FILE" ]; then

     chmod +x "$FILE" 2>> "$log"

     cd "$cache_path"

     sudo ./ReceitanetBX-1.9.24-Linux-x86-Install.bin 2>> "$log"


  fi



fi



endInstall

fi


# ----------------------------------------------------------------------------------------

if [ "$acao" = "Arquivo Remessa CX" ]; then

clear

descontinuado


        yad --center --window-icon="$logo"  --title="🧯 $titulo" \
        --text="Descontinuado

https://www.caixa.gov.br/site/Paginas/Pesquisa.aspx?k=Arquivo%20Remessa" \
        --buttons-layout=center \
        --button="OK" \
        --width="600" --height="100" \
        2>/dev/null




  # echo "Arquivo Remessa CX"
  # configurarWine
  # Instalando complementos.
  # executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks dotnet45"
  # flatpak run --env="WINEPREFIX=$HOME" --env="WINEARCH=win32" org.winehq.Wine /app/bin/winetricks dotnet45 2>> "$log"


  # Baixando e executando programa principal
  # download "https://www.caixa.gov.br/Downloads/cobranca-caixa/Validador_de_Arquivos_Remessa.zip"   "$cache_path/remessa.zip"
  # cd "$cache_path"

  # Extraindo o arquivo executavel
  # unzip remessa.zip  2>> "$log"

  # echo $'#!/bin/bash 
  #       set echo off
  #       flatpak run --env="WINEPREFIX=$HOME" --env="WINEARCH=win32" wine --command=wine '$user_path' io.github.fastrizwaan.WineZGUI /.facilitador-linux/executaveis/ValidadorCnab_v2.2.2.exe' >$atalho_path/CobrancaCaixa.sh

  # cd $atalho_path
  # chmod +x CobrancaCaixa.sh
  # Criando pastas onde guardará o executável
  # mkdir -p $user_path/.facilitador-linux/executaveis

  # Copiando executável para a pasta de excetaveis
  # cp $cache_path/ValidadorCnab_v2.2.2.exe $user_path/.facilitador-linux/executaveis 2>> "$log"

  # Copiando o atalho para a pasta de atalhos no desktop do usuário.
  # cp "$atalho_path/CobrancaCaixa.desktop" "$desktop_path/Validadores" 2>> "$log"

  # Após a execução, removendo os arquivos.
  # cd "$cache_path"
  # rm -rf ValidadorCnab_v2.2.2.exe remessa.zip 2>> "$log"

  # endInstall

fi

# ----------------------------------------------------------------------------------------

exit 0

