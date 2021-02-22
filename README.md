# heyalter-ubuntu-iso

The official release of the heyalter ubuntu

[Version History](changelog.md)

## Contents

- Ubuntu LTS 20.04.2 - Daily build
- Additional software: 
  - chromium
  - gimp
  - vlc 
  - mumble
  - enigmail
  - keepass2
  - zoom
  - teams
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

To build the iso image locally you can use the commands below:

```bash
# run the build in a docker container
docker run -it --rm -v ${PWD}:/heyalter -w "/heyalter" --name heyalter-iso ubuntu:focal ./build-local.sh

# setup everything and get a shell in a container
docker run -it --rm -v ${PWD}:/heyalter -w "/heyalter" --name heyalter-iso ubuntu:focal
```

## Help for plain Ubuntu Installations
- plug our "HeyAlter Ubuntu Stick" into a fresh installed plain ubuntu box
- open the usb stick volume
- right click: "In Terminal öffnen"
- type "./setup-lokal.sh"
- accept pop-up terminal with root password (schule)

## Switch to 5.4 Kernel after Installation (i915 Graphic-Driver Bug)
- if you cannot open any app
- simply use the command Ctrl + Alt + F3 to switch to terminal mode
- login in with schule:schule  
- cd ./54KernelDebs/
- ./changeTo54KernelOffline.sh
- type sudo password: schule  
- if a message appears like "Entfernen des Kernels abbrechen": say: NEIN
- system will reboot automaticly.
- everything sould be fine. Start setup.sh as usual