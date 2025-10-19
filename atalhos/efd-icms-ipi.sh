#!/usr/bin/env bash
# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025

set echo off

ls  ~/ProgramasSPED/ || exit

cd ~/ProgramasSPED/Fiscal/jre/bin/java -Xmx2048m -Dfile.encoding=ISO-8859-1 -jar ~/ProgramasSPED/Fiscal/fiscalpva.jar

exit 0
