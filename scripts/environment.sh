#!/bin/bash

set -euo pipefail

# Update system
sudo pacman -Syu
# Install pacman packages
sudo pacman -S --noconfirm git zsh atuin zoxide starship fzf bat neovim uv mise jq satty grim wl-clipboard eza stow tmux 

# install DMS and its dependecies
sudo -v; and curl -fsSL https://install.danklinux.com | sh -s -- \
    --compositor niri \
    --term ghostty \
    --include-deps dms-greeter,danksearch \
    --yes

