local bind = hl.bind

bind("SUPER+SHIFT+P", function()
    hl.exec_cmd([[sleep 0.1; hyprctl dispatch 'hl.dsp.dpms({ action = "off" })']])
end)
bind("SUPER+SHIFT+E", hl.dsp.exit())

local grabbing_disabled = false
bind("SUPER+Escape", function()
    grabbing_disabled = not grabbing_disabled
    hl.config({ binds = { disable_keybind_grabbing = grabbing_disabled } })
end, { dont_inhibit = true })
