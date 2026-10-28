local bind = hl.bind
local function screenshot(mode)
    return hl.dsp.exec_cmd('bash "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/screenshot.sh" ' .. mode)
end

bind("ALT+Print", screenshot("window"))
bind("ALT+XF86Launch1", screenshot("window"))
bind("CTRL+Print", screenshot("screen"))
bind("CTRL+XF86Launch1", screenshot("screen"))
bind("Print", screenshot("annotate"))
bind("XF86Launch1", screenshot("region"))
