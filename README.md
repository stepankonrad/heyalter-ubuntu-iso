# heyalter-ubuntu-iso

The official release of the heyalter ubuntu

[Version History](changelog.md)

## Contents

- Ubuntu LTS 24.04
- Additional software as packages:
  - default-jre
  - geogebra
  - gimp
  - vlc
  - mumble
  - keepass2
  - audacity
  - geany
  - obs-studio
  - openscad
  - krita
  - krita-l10n
  - vim
  - pwgen
  - curl
  - youtubedl-gui
  - gparted
  - inkscape
  - guvcview
  - ksnip
- And as snaps
  - telegram-desktop
  - chromium
  - teams-for-linux
  - skype
  - discord

## Installation procedure proposal

[./Documentation/Installation.pdf](./Documentation/Installation.pdf)

## Reenable the Welcome page on the first boot

After executing the Cleanup script, the computer will **once** open a welcome page when detecting a internet connection.
If this is unintentionally triggered while/after setting up the PC, you can reenable the welcome page with the following command:

```bash
systemctl enable --user heyalter.service
```

## Building the image

[./Documentation/imagebuild.pdf](./Documentation/imagebuild.pdf)

## Help for plain Ubuntu Installations

- plug our "HeyAlter Ubuntu Stick" into a fresh installed plain ubuntu box
- open the usb stick volume
- right click: "In Terminal öffnen"
- type "./setup-lokal.sh"
- accept pop-up terminal with root password (schule)
