#!/bin/bash

# Audio testen
zenity --info --text "OK klicken um Audio zu testen"

arecord|aplay &
PID=$!

zenity --info --text "Du solltest ein Echo hören. OK klicken um Audio-Test zu beenden"

kill $PID
