#!/usr/bin/env bash

section=$(echo -e "\tSystemd - Services")
gum style \
    --foreground 212 \
    "$section"

systemd_enable_user_service "Enable notification daemon configuration watcher" "$HOME/.local/share/hyprcore/default/systemd/user/mako-watcher.service"
systemd_enable_user_service "Enable notification daemon configuration path monitor" "$HOME/.local/share/hyprcore/default/systemd/user/mako-watcher.path"