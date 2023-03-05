#!/bin/bash

# Script aus setup-Netzwerk ausführen (sofern vorhanden)
if nmcli dev wifi connect 'HeyAlter Setup'; then
  gnome-terminal --wait -- bash -c 'curl set.up | bash'
fi