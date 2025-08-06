$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

mkdir ($nu.data-dir | path join "vendor/autoload")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

if $nu.is-interactive {

    } else {
use std/util "path add"
path add "~.local/share/mise/shims"
}

alias l = eza -1a --icons
alias lg = lazygit

def i [prog] { curl $"cheat.sh/($prog)" }




