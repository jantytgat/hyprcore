#!/usr/bin/env bash

source scripts/variables.sh
source scripts/helper.sh

# Installation must not be running as root!!
[ "$EUID" -eq 0 ] && abort "Running as root (not a normal user)"

# Exit immediately if a command exits with a non-zero status
set -eE


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