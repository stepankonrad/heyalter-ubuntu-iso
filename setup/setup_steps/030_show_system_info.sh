#!/bin/bash

# anzeigen der systemparameter
zenity --info --text "$(lshw -C memory)\n------------------------------------\nAnzahl Kerne: $(nproc)\n------------------------------------\n$(lshw -C cpu | cut -c1-100)"
