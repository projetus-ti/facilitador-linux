#!/usr/bin/env bash

# Colaboração: Fernando Souza https://github.com/tuxslack / https://www.youtube.com/@fernandosuporte
# Data: 19/10/2025

# Usar array para pegar todos os possíveis caminhos

JAVA_PATHS=(/usr/lib/jvm/*/bin/java)

for JAVA in "${JAVA_PATHS[@]}"; do
    if [[ -x "$JAVA" ]]; then
        echo "Executável encontrado: $JAVA"
        "$JAVA" -version
    fi
done

ls "/opt/Programas RFB/Dirf2022" || exit

cd "/opt/Programas RFB/Dirf2022"

export JAVA_TOOL_OPTIONS=-Dfile.encoding=ISO-8859-1

umask 000

if [ ! -e "$JAVA" ]; then
   java -jar pgdDirf.jar
  else
    $JAVA -jar -Xms512M -Xmx1024M -XX:+UseParallelOldGC pgdDirf.jar
  fi
  
# $JAVA -jar -Xms512M -Xmx1024M -XX:+UseParallelOldGC pgdDirf.jar
