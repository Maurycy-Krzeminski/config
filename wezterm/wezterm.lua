-- Pull in the wezterm API
local os = require("os")
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end


wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'catppuccin-frappe'

local powershell_profile = os.getenv("XDG_CONFIG_HOME") .. '\\powershellProfile\\PowerShell_profile.ps1'

config.default_prog = {
    'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe', '-NoExit', '-File' , powershell_profile
}
config.window_decorations = 'RESIZE'

config.launch_menu = {
    {
        label = "default",
        args = {'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe', '-NoExit', '-File' , powershell_profile}
    }
}

config.keys={
    {
        key='v',
        mods='CTRL',
        action=act.PasteFrom("Clipboard")
    },
    {
        key = 'c',
        mods = 'CTRL',
        action = act.CopyTo("Clipboard"),
    },
    {
        key = "t",
        mods = "ALT",
        action = act.ShowTabNavigator
    },
    { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
    {
        key = "h",
        mods = "ALT",
        action = act.ActivatePaneDirection("Left")
    },
    { key = "v", mods = "ALT|SHIFT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
    { key = "h", mods = "ALT|SHIFT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

    { key = "RightArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
    { key = "LeftArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    { key = "UpArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
    { key = "DownArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
}
-- and finally, return the configuration to wezterm
return config
