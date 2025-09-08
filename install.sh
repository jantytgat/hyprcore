#!/usr/bin/env bash

source scripts/env.sh
source scripts/helper.sh

# Installation must not be running as root!!
[ "$EUID" -eq 0 ] && abort "Running as root (not a normal user)"

# Exit immediately if a command exits with a non-zero status
set -eE

mkdir -p $HYPRCORE_SHARE_PATH
mkdir -p $HYPRCORE_STATE_PATH

mkdir -p $HYPRCORE_CACHE

cp -R --update=all scripts $HYPRCORE_SHARE_PATH
cp -R --update=all config $HYPRCORE_SHARE_PATH
cp -R --update=all default $HYPRCORE_SHARE_PATH

chmod +x $HYPRCORE_SCRIPTS_BIN/*

# Detect & install gum for nice output
if [[ $(is_package_installed "gum") == 1 ]]
then
    sudo pacman -S --noconfirm --needed --quiet gum
fi


print_title

# Installation
source $HYPRCORE_SCRIPTS_INSTALL/packages.sh
echo ""
# Configuration
source $HYPRCORE_SCRIPTS_CONFIG/config.sh