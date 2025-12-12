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

local process_icons = {
  ['docker'] = wezterm.nerdfonts.linux_docker,
  ['docker-compose'] = wezterm.nerdfonts.linux_docker,
  ['psql'] = '󱤢',
  ['usql'] = '󱤢',
  ['kuberlr'] = wezterm.nerdfonts.linux_docker,
  ['kubectl'] = wezterm.nerdfonts.linux_docker,
  ['stern'] = wezterm.nerdfonts.linux_docker,
  ['nvim'] = wezterm.nerdfonts.custom_vim,
  ['make'] = wezterm.nerdfonts.seti_makefile,
  ['vim'] = wezterm.nerdfonts.dev_vim,
  ['node'] = wezterm.nerdfonts.mdi_hexagon,
  ['go'] = wezterm.nerdfonts.seti_go,
  ['zsh'] = wezterm.nerdfonts.dev_terminal,
  ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
  ['btm'] = wezterm.nerdfonts.mdi_chart_donut_variant,
  ['htop'] = wezterm.nerdfonts.mdi_chart_donut_variant,
  ['cargo'] = wezterm.nerdfonts.dev_rust,
  ['sudo'] = wezterm.nerdfonts.fa_hashtag,
  ['lazydocker'] = wezterm.nerdfonts.linux_docker,
  ['git'] = wezterm.nerdfonts.dev_git,
  ['lua'] = wezterm.nerdfonts.seti_lua,
  ['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
  ['curl'] = wezterm.nerdfonts.mdi_flattr,
  ['gh'] = wezterm.nerdfonts.dev_github_badge,
  ['ruby'] = wezterm.nerdfonts.cod_ruby,
}

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir or ''
  local HOME_DIR = string.format('file://%s', os.getenv('HOME'))
  local dir_string_f = tostring(current_dir)
  local dir_string = string.gsub(tostring(current_dir), '(.*[/\\])(.*)', '%2')
  print('current_dir')
  print( current_dir)
  print('dir_string')
  print(dir_string)
  print('dir_string_f')
  print(dir_string_f)
  return current_dir == HOME_DIR and '.' or dir_string_f:gsub("^file:///", "")
end

local function get_process(tab)
    if not tab.active_pane or tab.active_pane.foreground_process_name == '' then
        return '[?]'
    end

    local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
    if string.find(process_name, 'kubectl') then
        process_name = 'kubectl'
    end

    return process_icons[process_name] or string.format('[%s]', process_name)
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local has_unseen_output = false
    if not tab.is_active then
        for _, pane in ipairs(tab.panes) do
            if pane.has_unseen_output then
                has_unseen_output = true
                break
            end
        end
    end

    local cwd = wezterm.format({
        { Attribute = { Intensity = 'Bold' } },
        { Text = get_current_working_dir(tab) },
    })

    local title = string.format(' %s ~ %s  ', get_process(tab), cwd)
    local title = string.format(' %s   ', cwd)
    print("title:" .. title)
    if has_unseen_output then
        return {
            { Foreground = { Color = '#28719c' } },
            { Text = title },
        }
    end

    return {
        { Text = title },
    }
end)

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window{}
    window:gui_window():maximize()
end)

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'catppuccin-frappe'

local powershell_profile = os.getenv("XDG_CONFIG_HOME") .. '\\powershellProfile\\PowerShell_profile.ps1'

config.default_prog = {
    'pwsh.exe', '-NoExit', '-File' , powershell_profile
}
config.window_decorations = 'RESIZE'

config.launch_menu = {
    {
        label = "default",
        args = {'pwsh.exe', '-NoExit', '-File' , powershell_profile}
    },
    {
        label = "wsl",
        args = {'wsl.exe' }
    },
    {
        label = "nu",
        args = {'nu.exe' }
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
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.ShowLauncher
    },
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
    -- Create a new tab in the same domain as the current pane.
    -- This is usually what you want.
    {
        key = 't',
        mods = 'SHIFT|ALT',
        action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'E',
        mods = 'CTRL|SHIFT',
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
}
-- and finally, return the configuration to wezterm
return config
