#!/usr/bin/env bash

section=$(echo -e "\tHardware - Network")
gum style \
    --foreground 212 \
    "$section"
systemd_enable_service "Ensure wireless service will be started" "iwd.service"
systemd_disable_service "Prevent timeout on boot while waiting for network" "systemd-networkd-wait-online.service"
systemd_mask_service systemd-networkd-wait-online.service
