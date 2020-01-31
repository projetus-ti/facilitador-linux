#!/bin/bash 
    dpkg -i /opt/projetus/facilitador/cache/linphone.deb 
    apt-get update && apt-get -f install -y && apt-get install ffmpeg -y
