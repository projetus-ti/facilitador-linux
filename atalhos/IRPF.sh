#!/usr/bin/env bash

set echo off

# Usar array para pegar todos os possíveis caminhos
JAVA_PATHS=(/usr/lib/jvm/*/bin/java)

for JAVA in "${JAVA_PATHS[@]}"; do
    if [[ -x "$JAVA" ]]; then
        echo "Executável encontrado: $JAVA"
        "$JAVA" -version
    fi
done


cd ~/ProgramasRFB/IRPF2021/

if [ ! -d "$JAVA" ]; then
    java -jar irpf.jar
  else
    $JAVA -jar irpf.jar
  fi
  
  exit 0
  
