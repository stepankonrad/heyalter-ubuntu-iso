#!/bin/bash

# Laufwerk testen
eject 2>&1 | tee -a $LOGFILE
