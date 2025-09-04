#!/usr/bin/env bash

cd /var/hyprcore/scripts/mako
systemctl --user enable --now mako-watcher.service
systemctl --user enable --now mako-watcher.path
