#!/bin/bash

# Device
export TWRP_MANIFEST="https://github.com/faoliveira78/platform_manifest_twrp_aosp"
export TWRP_BRANCH="twrp-12.1"
#export TWRP_BRANCH="twrp-test"
export DT_LINK="https://github.com/Jayeudypdx/android_device_samsung_gta8wifi.git -b twrp-12.1"

export DEVICE="gta8wifi"
export OEM="samsung"
#export PLATFORM="msm8998"
export TARGET="recoveryimage"
export TW_DEVICE_VERSION="2"
export OUTPUT="recovery.img"
export FILENAME="twrp*.img"

# Kernel Source
# Uncomment the next line if you want to clone a kernel source.


# Extra Command
export TW_THEME=landscape_hdpi
export TW_BRIGHTNESS_PATH="/sys/class/backlight/sprd_backlight/brightness"
export TW_INPUT_BLACKLIST="hbtp_vm"
export TW_USE_EXTERNAL_STORAGE=true
export TW_EXCLUDE_TWRPAPP=true
export TW_INCLUDE_NTFS_3G=true
export TW_USE_NEW_MINADBD=true
export TW_USE_TOOLBOX=true
export TW_HAS_DOWNLOAD_MODE=true
export TW_NO_REBOOT_BOOTLOADER=true
export TW_NO_LEGACY_PROPS=true
export TW_NO_BIND_SYSTEM=true
export TW_SCREEN_BLANK_ON_BOOT=true
export TW_DEVICE_VERSION=1
export TW_INCLUDE_CRYPTO=true

# Not Recommended to Change
if [ ! -e $HOME/work ]; then
mkdir $HOME/work
fi

export SYNC_PATH="$HOME/work" # Full (absolute) path.
export USE_CCACHE=1
export CCACHE_SIZE="50G"
export CCACHE_DIR="$HOME/work/.ccache"
export J_VAL=16

if [ ! -z "$PLATFORM" ]; then
    export KERNEL_PATH="kernel/$OEM/$PLATFORM"
else
    export KERNEL_PATH="kernel/$OEM/$DEVICE"
fi
export DT_PATH="device/$OEM/$DEVICE"
