#!/bin/sh
cd "/opt/Programas RFB/Dirf2020"
export JAVA_TOOL_OPTIONS=-Dfile.encoding=ISO-8859-1
umask 000
/usr/lib/jvm/jre1.8.0_212/bin/java -jar -Xms512M -Xmx1024M -XX:+UseParallelOldGC pgdDirf.jar