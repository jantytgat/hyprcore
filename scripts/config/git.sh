#!/usr/bin/env bash

# Set common git aliases
git config --global init.defaultBranch main
git config --global pull.rebase true


if [[ -n "${HYPRCORE_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$HYPRCORE_USER_NAME"
fi

if [[ -n "${HYPRCORE_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$HYPRCORE_USER_EMAIL"
fi
