hl.config({
    general = {
        gaps_in = 2, -- Hyprland adds the gaps of both adjacent windows.
        gaps_out = 4,
        border_size = 2, -- Niri focus-ring is 2px; its separate border is off.
        col = { active_border = "rgb(b9c3ff)", inactive_border = "rgb(90909a)" },
    },
    decoration = {
        rounding = 12,
        shadow = { enabled = false, range = 30, offset = "0 5", color = "rgba(00000070)" },
        blur = { enabled = false },
    },
})

hl.config({ misc = { disable_hyprland_logo = true, disable_splash_rendering = true } })
