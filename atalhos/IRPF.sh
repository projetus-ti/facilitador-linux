#!/bin/sh

set echo off

cd ~/ProgramasRFB/IRPF2020/

if [ ! -d "/usr/lib/jvm/jre1.8.0_212/bin/java" ]; then
    executar "java -jar irpf.jar"
  else
    /usr/lib/jvm/jre1.8.0_212/bin/java -jar irpf.jar
  fi

#/usr/lib/jvm/jre1.8.0_212/bin/java -jar irpf.jar
