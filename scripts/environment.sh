#!/usr/bin/env bash 

set -euo pipefail

# Update system
#sudo pacman -Syu
# Install pacman packages
#sudo pacman -S --noconfirm git zsh atuin zoxide starship fzf bat neovim uv mise jq satty grim wl-clipboard eza stow tmux 

# install DMS and its dependecies
curl -fsSL https://install.danklinux.com -o /tmp/install-dank.sh

bash /tmp/install-dank.sh \ -c niri \ --t ghostty \ --include-deps dms-greeter,danksearch \ --yes

