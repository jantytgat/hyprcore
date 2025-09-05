#!/usr/bin/env bash

makoctl reload
notify-send -a "Reload notifications configuration" -i firefox -t 5000 "System notification" "mako config reloaded"
