#!/bin/bash
#
# Vorbereitung (falls notwendig)
# Docker installieren
#
if [ -z "$(which docker)" ]; then
   sudo apt install docker -y
fi
#
# aktuellen User in Docker Gruppe hinzufügen
# um Aufruf ohne root-Rechte zu ermöglichen
#
if [ "$(id | grep -c docker)" -ne 1 ]; then
   sudo usermod -G docker $USER
   cat << EOD

-------------------------------------------------------------------------
             Bitte einmal ab- und wieder anmelden, 
              damit docker aufgerufen werden kann
-------------------------------------------------------------------------

EOD
exit

fi

#
# Docker Aufruf für den Build-Prozess
#
docker run -it --rm -v "${PWD}":/heyalter -w "/heyalter" --name heyalter-iso ubuntu:noble ./build-local.sh
