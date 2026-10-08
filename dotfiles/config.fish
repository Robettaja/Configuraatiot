source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
mise activate fish | source

zoxide init fish | source

starship init fish | source

atuin init fish | source

set -gx PATH $PATH ~/.dotnet/tools

alias l 'eza -1a --icons'
alias lg lazygit
