$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

if $nu.is-interactive {

    } else {
use std/util "path add"
path add "~.local/share/mise/shims"
}

alias l = eza -1a --icons
alias lg = lazygit
alias .. = cd .


def i [prog] { curl $"cheat.sh/($prog)" }

# ENVIRONMENT VARIABLES
$env.PATH ++= ["~/.tools/vcpkg"]




