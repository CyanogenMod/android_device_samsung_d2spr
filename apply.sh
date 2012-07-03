#!/bin/bash

unset SUCCESS
on_exit() {
  if [ -z "$SUCCESS" ]; then
    echo "ERROR: $0 failed.  Please fix the above error."
    exit 1
  else
    echo "SUCCESS: $0 has completed."
    exit 0
  fi
}
trap on_exit EXIT

http_patch() {
  PATCHNAME=$(basename $1)
  curl -L -o $PATCHNAME -O -L $1
  cat $PATCHNAME |patch -p1
  rm $PATCHNAME
}

# Change directory verbose
cdv() {
  echo
  echo "*****************************"
  echo "Current Directory: $1"
  echo "*****************************"
  cd $BASEDIR/$1
}

# Change back to base directory
cdb() {
  cd $BASEDIR
}

# Sanity check
if [ -d ../.repo ]; then
  cd ..
fi
if [ ! -d .repo ]; then
  echo "ERROR: Must run this script from the base of the repo."
  SUCCESS=true
  exit 255
fi

# Save Base Directory
BASEDIR=$(pwd)

# Abandon auto topic branch
repo abandon auto
set -e

################ Apply Patches Below ####################


repo start auto frameworks/base/
cdv frameworks/base
echo 'Add SamsungCDMAQualcommRIL class http://review.cyanogenmod.com/#/c/18352/'
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_base refs/changes/52/18352/7 && git cherry-pick FETCH_HEAD
echo 'camera: Send proper preview window updates to HAL http://review.cyanogenmod.com/#/c/18206/'
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_base refs/changes/06/18206/1 && git cherry-pick FETCH_HEAD
cdb
repo start auto packages/apps/Camera/
cdv packages/apps/Camera/
echo 'Support for ZSL on samsung cameras http://review.cyanogenmod.com/#/c/18205/'
git fetch http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_Camera refs/changes/05/18205/2 && git cherry-pick FETCH_HEAD
cdb

##### SUCCESS ####
SUCCESS=true
exit 0
