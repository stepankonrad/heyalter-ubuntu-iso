#!/bin/bash

# Kamera testen
guvcview --gui none || zenity --warning --text "Es wurde keine Webcam gefunden! Falls möglich bitte eine externe beilegen."
