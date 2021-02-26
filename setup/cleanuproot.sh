#!/bin/bash

if [ ! -f /opt/setup/setup_done ]
then
# Should've been warned...
exit 2
fi

rm -r /opt/setup
