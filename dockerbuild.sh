#!/bin/bash
#
# Vorbereitung (falls notwendig)
# Docker installieren
#
if [ "$(which docker)" == ""  ]; then
   sudo apt install docker.io -y
fi
#
# aktuellen User in Docker Gruppe hinzufügen
# um Aufruf ohne root-Rechte zu ermöglichen
# Vorsicht: Aufruf usermod -G muss alle Gruppen nennen,
#           daher die Zwischenabfrage
#
if [ "$(id | grep -c docker)" -ne 1 ]; then
   groups=$(id -nG | tr " " ",")
   sudo usermod -G "$groups",docker $USER
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
