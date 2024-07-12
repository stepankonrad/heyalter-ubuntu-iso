#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh


log "Downloading additional Packages"
#
# Erstmal Zielverzeichnis anlegen
#
if [ ! -d $ISO_EXTRACTED_DIR ]; then
   echo "Zielverzeichnis <${ISO_EXTRACTED_DIR}> ist nicht vorhanden"
   return 1
fi

mkdir -p $ISO_EXTRACTED_DIR/APT
SoftwareListe="default-jre geogebra gimp vlc mumble keepass2 audacity geany obs-studio openscad krita krita-l10n vim pwgen curl youtubedl-gui gparted inkscape guvcview ksnip"

apt-get install -d -y $SoftwareListe -o Dir::Cache::Archives="$ISO_EXTRACTED_DIR/APT"

cat << EOD > $ISO_EXTRACTED_DIR/APT/install.sh
#!/bin/bash
#

for paket in $SoftwareListe
do

   apt-get install \$paket -y --no-download -o Dir::Cache::Archives=/opt/APT/

done

EOD
