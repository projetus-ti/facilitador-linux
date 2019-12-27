#!/bin/sh

set echo off

cd ~/ProgramasSPED/EFDContribuicoes

~/ProgramasSPED/EFDContribuicoes/jre/bin/java -Xmx2048m -Dfile.encoding=ISO-8859-1 -XX:+UseParallelGC -XX:FreqInlineSize=512 -XX:MaxInlineSize=35 -jar ~/ProgramasSPED/EFDContribuicoes/efdcontribuicoes.jar
