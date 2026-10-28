-- Translation of ../niri/config.kdl and its included DMS files.
-- Requires Hyprland 0.56+. See README.md for intentional differences.
-- Resolve includes beside this file, including when using --config or Stow.
local config_dir = debug.getinfo(1, "S").source:sub(2):match("^(.*)/")
local function include(name)
    dofile(config_dir .. "/" .. name .. ".lua")
end

include("config/environment")
include("config/monitors")
include("config/layout")
include("config/input")
include("config/appearance")
include("config/animations")
include("config/autostart")
include("config/rules")
include("bindings/applications")
include("bindings/media")
include("bindings/workspaces")
include("bindings/monitors")
include("bindings/windows")
include("bindings/screenshots")
include("bindings/session")
include("bindings/switcher")
include("bindings/unsupported")
