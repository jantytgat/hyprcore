#!/usr/bin/env bash

abort() {
    echo
    echo -e "\e[31mHyprcore install warning: $1\e[0m"
    echo
    exit 1
}

install_package() {
    gum spin --spinner dot --title "$1" --show-error -- sleep 0.5; sudo pacman -S --noconfirm --needed "$1" >> $HYPRCORE_LOG
}

install_package_group() {
    gum style \
    --foreground 212 \
    "$1"

    while read -r LINE
    do
        if [[ $LINE =~ ^#.* ]]
        then
            continue
        fi

        if [[ $LINE == "" ]]
        then
            continue
        fi
        install_package "$LINE"
    done < $2
}


# Installation must not be running as root!!
[ "$EUID" -eq 0 ] && abort "Running as root (not a normal user)"

# Exit immediately if a command exits with a non-zero status
set -eE


# Install gum for nice output
sudo pacman -S --noconfirm --needed --quiet gum

gum style \
    --foreground 212 \
    --border-foreground 212 \
    --border double \
    --align center \
    --width 50 \
    --margin "1 2" \
    --padding "2 4" \
    'Hyprcore Installation'


HYPRCORE_SHARE_PATH="$HOME/.local/share/hyprcore"
mkdir -p $HYPRCORE_SHARE_PATH

HYPRCORE_STATE_PATH="$HOME/.local/state/hyprcore"
mkdir -p $HYPRCORE_STATE_PATH

HYPRCORE_SHARE_SCRIPTS="$HYPRCORE_SHARE_PATH/scripts"
cp -R scripts $HYPRCORE_SHARE_SCRIPTS

HYPRCORE_PREREQ="$HYPRCORE_SHARE_SCRIPTS/prerequisites"
HYPRCORE_INSTALL="$HYPRCORE_SHARE_SCRIPTS/install"

HYPRCORE_LOG="$HYPRCORE_STATE_PATH/install.log"

#export $PATH="$HYPRCORE_PATH/bin:$PATH"


# Installation
source $HYPRCORE_INSTALL/packages.sh
