#!/bin/bash

set -x

install_tools () {
  apt-get install nwipe nvme-cli smartmontools -y --no-download -o Dir::Cache::Archives=/cdrom/APT/
}

populate_device_list () {
  DISKDEV_LIST=$(lsblk -AdnPo PATH,TYPE,MODEL,VENDOR,SIZE,ROTA,RM -x SIZE | while read LINE; do
    eval $LINE
    if (( $RM == 1 )); then # skip removable devices
      continue
    fi
    if [[ "$TYPE" =~ ^(loop|rom|part|md)$ ]]; then # skip specific types of devices
      continue
    fi
    echo $PATH
  done)
}

wipe_nvme () {
  OUTPUT=$(nvme format --ses=1 --force $1 2>&1)
  RC=$?
  if [ $RC -eq 0 ]; then
    return 0
  fi

  systemctl suspend -i

  OUTPUT=$(nvme format --ses=1 --force $1 2>&1)
  RC=$?
  if [ $RC -eq 0 ]; then
    return 0
  fi

  return $RC
}

wipe_ata () {
  OUTPUT=$(/cdrom/ata-secure-erase.sh -f $1 2>&1)
  RC=$?
  if [ $RC -eq 0 ]; then
    return 0
  fi

  if [[ $OUTPUT =~ "security state is frozen" ]]; then
    systemctl suspend -i

    OUTPUT=$(/cdrom/ata-secure-erase.sh -f $1 2>&1)
    RC=$?
    if [ $RC -eq 0 ]; then
      return 0
    fi
  fi

  return $RC
}

fast_wipe_all () {
  DISKDEV_FAILED_LIST=""
  for d in $DISKDEV_LIST
  do
    case "$d" in 
      *nvme*)
        wipe_nvme $d;; 
      *)
        wipe_ata $d;;
    esac
    RC=$?

    if [ $RC -eq 0 ]; then
      continue
    fi

    DISKDEV_FAILED_LIST="$DISKDEV_FAILED_LIST $d"
  done
}

wipe_nwipe () {  
  OUTPUT=$(nwipe -m random --nogui --verify=off --autonuke "$@" 2>&1)

  if [ $? -ne 0 ]; then
    exit 1
  fi
}

check_all_zero () {
  OUTPUT=$(nwipe -m verify_zero --nogui --autonuke "$@" 2>&1)

  if [ $? -ne 0 ]; then
    exit 1
  fi
}

main () {
  install_tools
  populate_device_list
  fast_wipe_all

  # fallback
  if [ $RC -ne 0 ]; then
    wipe_nwipe $DISKDEV_FAILED_LIST
  fi

  check_all_zero $DISKDEV_LIST
}

main