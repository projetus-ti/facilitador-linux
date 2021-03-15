#!/bin/bash

set echo off

cd ~/GDRAIS/GDRais2020

java -Duser.language=pt -Duser.region=BR -DsuppressSwingDropSupport=true -Djavax.net.ssl.trustStore=./cert/gdrais-client-producao.keystore -Xmx768m -cp .:./gdrais-gui2020-1.0-prod.jar:./lib/* br.gov.serpro.gdrais.gui.gui.GuiLancador
