#!/bin/bash

# Source Configs
source $CONFIG

# Change to the Source Directry
cd $SYNC_PATH

# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 10G
else
    ccache -M ${CCACHE_SIZE}
fi

# 

# Run the Extra Command
$EXTRA_CMD

# export some Basic Vars
export ALLOW_MISSING_DEPENDENCIES=true

# Prepare the Build Environment
source build/envsetup.sh

# lunch the target
if [ "$TWRP_BRANCH" = "twrp-12.1" ]; then
    lunch twrp_${DEVICE}-eng || { echo "ERROR: Failed to lunch the target!" && exit 1; }
else
    lunch omni_${DEVICE}-eng || { echo "ERROR: Failed to lunch the target!" && exit 1; }
fi

# Build the Code
if [ -z "$J_VAL" ]; then
    mka -j$(nproc --all) $TARGET || { echo "ERROR: Failed to Build TWRP!" && exit 1; }
elif [ "$J_VAL"="0" ]; then
    mka $TARGET || { echo "ERROR: Failed to Build TWRP!" && exit 1; }
else
    mka -j${J_VAL} $TARGET || { echo "ERROR: Failed to Build TWRP!" && exit 1; }
fi

# Exit
exit 0
