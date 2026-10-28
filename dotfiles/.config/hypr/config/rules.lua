hl.window_rule({ match = { class = "(satty|gnome-calculator|galculator|blueman-manager|xdg-desktop-portal|zoom|.*org\\.quickshell|com\\.danklinux\\.dms)" }, float = true })
hl.window_rule({ match = { class = ".*firefox", title = "Picture-in-Picture" }, float = true })
hl.window_rule({ match = { class = "(gnome-control-center|pavucontrol|nm-connection-editor)" }, tile = true, scrolling_width = 0.5 })
