# heyalter-ubuntu-iso

The official release of the heyalter ubuntu

[Version History](changelog.md)

## Contents

- Ubuntu LTS 22.04
- Additional software: 
  - chromium
  - gimp
  - vlc 
  - mumble
  - enigmail
  - keepass2
  - teams 
  - teams-for-linux
  - telegram 
  - skype 
  - discord
  - inkscape
  - audacity 
  - geany 
  - geogebra 
  - obs-studio 
  - openscad 
  - krita

## Installation procedure proposal

- [Installation procedure proposal {german}](install_proposal.md)

## Local build scripts

> ⚠️  Das Buildscript überschreibt die `/etc/passwd` und `/etc/group` im Hostsystem. Daher bitte **nicht außerhalb eines Docker-Containers ausführen!**

To build the iso image locally you can use the commands below:

```bash
# run the build in a docker container
docker run -it --rm -v ${PWD}:/heyalter -w "/heyalter" --name heyalter-iso ubuntu:jammy ./build-local.sh

# setup everything and get a shell in a container
docker run -it --rm -v ${PWD}:/heyalter -w "/heyalter" --name heyalter-iso ubuntu:jammy
```

## Help for plain Ubuntu Installations
- plug our "HeyAlter Ubuntu Stick" into a fresh installed plain ubuntu box
- open the usb stick volume
- right click: "In Terminal öffnen"
- type "./setup-lokal.sh"
- accept pop-up terminal with root password (schule)
