#!/bin/bash

# Kamera testen


snapshot  >> $LOGFILE 2>&1 || zenity --warning --ok-label="Kamera Test beenden" --icon="camera-video" \
                       --text "Es wurde keine Webcam gefunden! Falls möglich bitte eine externe beilegen."
