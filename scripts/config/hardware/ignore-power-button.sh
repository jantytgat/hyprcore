#!/usr/bin/env bash

section=$(echo -e "\tHardware - Power button")
gum style \
    --foreground 212 \
    "$section"

# Disable shutting system down on power button to bind it to power menu afterwards
#sudo sed -i 's/.*HandlePowerKey=.*/HandlePowerKey=ignore/' /etc/systemd/logind.conf
command='sudo sed -i 's/.*HandlePowerKey=.*/HandlePowerKey=ignore/' /etc/systemd/logind.conf'
execute_command "Disable shutting down system on power button" "$command"

