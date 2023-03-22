#!/bin/bash

# Source Vars
source $CONFIG



# Change to the Source Directory
cd $SYNC_PATH

# Color
ORANGE='\033[0;33m'

# Display a message
echo "============================"
echo "Uploading the Build..."
echo "============================"

#Get Version info stored in variables.h
TW_MAIN_VERSION=$(sed -n -e 's/^.*#define TW_MAIN_VERSION_STR //p' bootable/recovery/variables.h | cut -d'"' -f2)

# Change to the Output Directory
cd out/target/product/${DEVICE}

#Rename build
mv -v $OUTPUT twrp-${TW_MAIN_VERSION}-${TW_DEVICE_VERSION}-${DEVICE}.img &> /dev/null

# Upload to oshi.at
if [ -z "$TIMEOUT" ];then
    TIMEOUT=20160
fi

# Upload to WeTransfer
# NOTE: the current Docker Image, "registry.gitlab.com/sushrut1101/docker:latest", includes the 'transfer' binary by Default
transfer wet $FILENAME > link.txt || { echo "ERROR: Failed to Upload the Build!" && exit 1; }

# Mirror to oshi.at
curl -T $FILENAME https://oshi.at/${FILENAME}/${TIMEOUT} > mirror.txt || { echo "WARNING: Failed to Mirror the Build!"; }

DL_LINK=$(cat link.txt | grep Download | cut -d\  -f3)
MIRROR_LINK=$(cat mirror.txt | grep Download | cut -d\  -f1)

# Show the Download Link
echo "=============================================="
echo "Download Link: ${DL_LINK}" || { echo "ERROR: Failed to Upload the Build!"; }
echo "Mirror: ${MIRROR_LINK}" || { echo "WARNING: Failed to Mirror the Build!"; }
echo "=============================================="

DATE_L=$(date +%d\ %B\ %Y)
DATE_S=$(date +"%T")

# 



# Exit
exit 0
