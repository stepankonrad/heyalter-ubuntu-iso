#!/bin/bash

find /opt/setup/setup_steps/ -name "*.sh" | sort -k1 | xargs -I {} bash {}