#!/usr/bin/env bash

gum style \
    --foreground 212 \
    'Configuring system'

mkdir -p ~/.config
cp -R $HYPRCORE_CONFIG/* ~/.config
cp $HYPRCORE_SHARE_PATH/default/bashrc ~/.bashrc


source $HYPRCORE_SCRIPTS_CONFIG/hardware/network.sh
source $HYPRCORE_SCRIPTS_CONFIG/hardware/ignore-power-button.sh

source $HYPRCORE_SCRIPTS_CONFIG/systemd/services.sh

gum style \
    --foreground 212 \
    'Done.'
