#!/bin/bash

if [ ! -f /opt/setup/setup_done ]
then
# Should've been warned...
exit 2
fi

find /home -lname '/opt/setup/*' -delete
rm -r /opt/setup
