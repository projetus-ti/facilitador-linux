#!/bin/sh
cd "/opt/Programas RFB/Dirf2021"
export JAVA_TOOL_OPTIONS=-Dfile.encoding=ISO-8859-1
umask 000
if [ ! -e "/usr/lib/jvm/jre1.8.0_212/bin/java" ]; then
   java -jar pgdDirf.jar
  else
    /usr/lib/jvm/jre1.8.0_212/bin/java -jar -Xms512M -Xmx1024M -XX:+UseParallelOldGC pgdDirf.jar
  fi
#/usr/lib/jvm/jre1.8.0_212/bin/java -jar -Xms512M -Xmx1024M -XX:+UseParallelOldGC pgdDirf.jar