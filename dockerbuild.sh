#!/bin/bash
#
# Docker Aufruf für den Build-Prozess
#
docker run -it --rm -v "${PWD}":/heyalter -w "/heyalter" --name heyalter-iso ubuntu:noble ./build-local.sh
