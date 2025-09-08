#!/usr/bin/env bash

section=$(echo -e "\tGPG")
gum style \
    --foreground 212 \
    "$section"

# Setup GPG configuration with multiple keyservers for better reliability
command="sudo mkdir -p /etc/gnupg"
execute_command "Create directory /etc/gnupg" "$command"

command="sudo cp $HYPRCORE_SHARE_PATH/default/gpg/dirmngr.conf /etc/gnupg/"
execute_command "Copy default config" "$command"

command="sudo chmod 644 /etc/gnupg/dirmngr.conf"
execute_command "Configure file permissions" "$command"

command="sudo gpgconf --kill dirmngr || true"
execute_command "Kill gpgconf" "$command"

command="sudo gpgconf --launch dirmngr || true"
execute_command "Launch gpgconf" "$command"
