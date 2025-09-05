#!/usr/bin/env bash

# rm -rf ~/.local/share/hyprcore
# rm -rf ~/.local/state/hyprcore
rm -rf ~/.local ~/.config

sudo pacman -R --noconfirm chromium btop fastfetch hyprland uwsm libnewt hypridle hyprlock hyprsunset hyprland-qtutils hyprpicker hyprshot
clear