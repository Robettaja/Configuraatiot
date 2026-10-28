local bind = hl.bind

-- Cycle windows on the focused output, including other workspaces.
-- Niri's graphical recent-window switcher itself has no native equivalent.
local function cycle_output(reverse, same_app)
    return function()
        local current, monitor = hl.get_active_window(), hl.get_active_monitor()
        if not current or not monitor then return end
        local windows = hl.get_windows({ monitor = monitor, mapped = true })
        local candidates = {}
        for _, w in ipairs(windows) do
            if not same_app or w.class == current.class then candidates[#candidates + 1] = w end
        end
        for i, w in ipairs(candidates) do
            if w.address == current.address then
                local target = candidates[(i - 1 + (reverse and -1 or 1)) % #candidates + 1]
                hl.dispatch(hl.dsp.focus({ window = target }))
                return
            end
        end
    end
end
bind("ALT+Tab", cycle_output(false, false))
bind("ALT+SHIFT+Tab", cycle_output(true, false))
bind("ALT+grave", cycle_output(false, true))
bind("ALT+SHIFT+grave", cycle_output(true, true))
