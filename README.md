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

- [Installation procedure proposal {german}](install_proposal.md)

## Reenable the Welcome page on the first boot

After executing the Cleanup script, the computer will **once** open a welcome page when detecting a internet connection.
If this is unintentionally triggered while/after setting up the PC, you can reenable the welcome page with the following command:

```bash
systemctl enable --user heyalter.service
```

## Building the image

You can use Docker or run locally.

```bash
git clone https://gitli.stratum0.org/heyalter/heyalter-ubuntu-iso.git
cd heyalter-ubuntu-iso
docker run -it --rm -v "${PWD}":/heyalter -w "/heyalter" --name heyalter-iso ubuntu:jammy ./build-local.sh

OR simply

./build-local.sh
```

The finished build artifacts can be found inside the `artifacts` folder.

If you wish to debug a build, you might just start a docker container with the default bash and execute
`./build-local.sh` manually inside it. This allows you to inspect the intermediate files when a build error occurrs.
Furthermore you can manually execute the build steps by executing the appropriate script in the `scripts`-Folder, so
you don't need to start the build from scratch on little changes.
Execute the following command, instead of the above docker command:

```bash
docker run -it --rm -v ${PWD}:/heyalter -w "/heyalter" --name heyalter-iso ubuntu:jammy
```

## Help for plain Ubuntu Installations

- plug our "HeyAlter Ubuntu Stick" into a fresh installed plain ubuntu box
- open the usb stick volume
- right click: "In Terminal öffnen"
- type "./setup-lokal.sh"
- accept pop-up terminal with root password (schule)
