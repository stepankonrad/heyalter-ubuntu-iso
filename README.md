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
  - zoom
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

## Switch to 5.4 Kernel after Installation (i915 Graphic-Driver Bug)
- if you cannot open any app
- simply use the command Ctrl + Alt + F3 to switch to terminal mode
- login in with schule:schule
- `./changeTo54KernelOffline.sh`
- system will reboot automaticly.
- everything sould be fine. Start setup.sh as usual
