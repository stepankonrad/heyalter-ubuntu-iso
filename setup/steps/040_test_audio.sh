#!/bin/bash


arecord|aplay &
PID=$!

zenity --info --icon audio-input-microphone --ok-label="Audio Test beenden" \
       --text "Audio Test ist gestartet. Du solltest ein Echo hören." 

kill $PID
