# Changelog

All notable changes to this project will be documented in this file.

## 2022-02-22
### Changed
- Skip checkdisk (does not work on every machine)
- Call `setup.sh` after first boot automatically

## 2021-06-16
### Add
- Allowed sudo without password for initial setup
- Enabled AutoLogin for initial setup

## 2021-06-06
### Changed
- Added directory `setup_extensions` for custom scripts that are executed at the end of the `setup.sh`

## 2021-05-25
### Added
- Added curl,gparted,youtube-dl packets and HEY-HILFE-Support-Handbuch.pdf (moved from /opt/setup to Desktop with cleanup.sh)

## 2021-03-10
### Added
- Added teams-for-linux app because it should work better for some kids (login issues)

## 2021-02-26
### Changed
- The UEFI boot now also supports automatic installation
### Added
- After the cleanup script a HeyAlter Help icon should be created on the desktop

## 2021-02-22
### Changed
- Removed the password query in `setup.sh` and `changeTo54KernelOffline.sh`. Sudo is not required anymore
- Slightly different look of `setup.sh` and `cleanup.sh`, as these are now only symlinks

## 2021-02-17
### Fixed
- Krita in german language
- Geogebra fixed to start
