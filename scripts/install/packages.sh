#!/usr/bin/env bash

gum style \
    --foreground 212 \
    'Installing packages'

HYPRCORE_PACKAGES="$HYPRCORE_INSTALL/packages"

for file in $HYPRCORE_PACKAGES/*.group
do
    groupname=${file##*/}
    groupname=${groupname%.*}
    install_package_group $groupname $file
done

gum style \
    --foreground 212 \
    'Done.'
