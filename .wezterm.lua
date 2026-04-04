local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find('windows') ~= nil

-- Default shell
if is_windows then
  config.default_prog = { 'C:/Program Files/PowerShell/7/pwsh.exe', '-NoLogo' }
else
  config.default_prog = { '/bin/zsh', '-l' }
end

-- Font
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
config.font_size = 14.0
config.line_height = 1.1
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- Color scheme
config.color_scheme = 'Dracula (Official)'

-- Window appearance
if is_windows then
  config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
  config.window_background_opacity = 0.97
  config.win32_system_backdrop = 'Mica'
else
  config.window_decorations = 'RESIZE'
  config.macos_window_background_blur = 20
  config.window_background_opacity = 0.95
end
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.initial_cols = 130
config.initial_rows = 36
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 28

-- Inactive pane dimming
config.inactive_pane_hsb = {
  saturation = 0.85,
  brightness = 0.7,
}

-- Launch menu
if is_windows then
  config.launch_menu = {
    {
      label = 'PowerShell 7',
      args = { 'C:/Program Files/PowerShell/7/pwsh.exe', '-NoLogo' },
    },
    {
      label = 'Windows PowerShell 5.1',
      args = { 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe' },
    },
    {
      label = 'Git Bash',
      args = { 'C:/Program Files/Git/bin/bash.exe', '--login', '-i' },
    },
    {
      label = 'Ubuntu (WSL)',
      args = { 'wsl.exe', '-d', 'Ubuntu', '--cd', '~' },
    },
    {
      label = 'Command Prompt',
      args = { 'cmd.exe' },
    },
  }
else
  config.launch_menu = {
    {
      label = 'zsh',
      args = { '/bin/zsh', '-l' },
    },
    {
      label = 'bash',
      args = { '/bin/bash', '-l' },
    },
  }
end

-- Keybindings
local act = wezterm.action

-- macOS: SUPER (Cmd), Windows: CTRL
local mod = is_windows and 'CTRL' or 'SUPER'
local mod_shift = mod .. '|SHIFT'

config.keys = {
  -- Tab management
  { key = 't', mods = mod, action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = mod, action = act.CloseCurrentPane { confirm = true } },

  -- Pane splitting
  { key = 'd', mods = mod, action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'e', mods = mod_shift, action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Pane navigation
  { key = 'LeftArrow',  mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },

  -- Pane resize
  { key = 'LeftArrow',  mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 3 } },
  { key = 'RightArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 3 } },
  { key = 'UpArrow',    mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Up', 3 } },
  { key = 'DownArrow',  mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Down', 3 } },

  -- Launcher & command palette
  { key = 'l', mods = 'ALT',     action = act.ShowLauncher },
  { key = 'p', mods = mod_shift, action = act.ActivateCommandPalette },

  -- Search
  { key = 'f', mods = mod_shift, action = act.Search 'CurrentSelectionOrEmptyString' },

  -- Font size
  { key = '=', mods = mod, action = act.IncreaseFontSize },
  { key = '-', mods = mod, action = act.DecreaseFontSize },
  { key = '0', mods = mod, action = act.ResetFontSize },

  -- Copy/Paste
  { key = 'c', mods = mod, action = act.CopyTo 'ClipboardAndPrimarySelection' },
  { key = 'v', mods = mod, action = act.PasteFrom 'Clipboard' },

  -- Claude Code in new pane
  { key = 'c', mods = mod_shift, action = act.SplitPane {
    direction = 'Right',
    command = {
      args = { 'C:/Program Files/Git/bin/bash.exe', '-l', '-c', 'claude --dangerously-load-development-channels server:claude-peers --dangerously-skip-permissions' },
    },
    size = { Percent = 50 },
  } },

  -- Tab switching
  { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
}

-- Scrollback & performance
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.max_fps = 120
config.animation_fps = 60

-- IME
config.use_ime = true

-- Misc
config.automatically_reload_config = true
config.check_for_updates = true
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 75,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 75,
}
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500

-- Startup welcome message
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})

  local mod_key = is_windows and 'Ctrl' or 'Cmd'
  local welcome = '\r\n'
    .. '\x1b[1;35m  WezTerm Quick Reference\x1b[0m\r\n'
    .. '\x1b[90m  ───────────────────────────────────\x1b[0m\r\n'
    .. '  \x1b[36m' .. mod_key .. '+T\x1b[0m            New tab\r\n'
    .. '  \x1b[36m' .. mod_key .. '+D\x1b[0m            Split horizontal\r\n'
    .. '  \x1b[36m' .. mod_key .. '+Shift+E\x1b[0m     Split vertical\r\n'
    .. '  \x1b[36m' .. mod_key .. '+W\x1b[0m            Close pane\r\n'
    .. '  \x1b[36mCtrl+Arrows\x1b[0m        Navigate panes\r\n'
    .. '  \x1b[36mAlt+Shift+Arrows\x1b[0m   Resize panes\r\n'
    .. '  \x1b[36mAlt+1~5\x1b[0m            Switch tab\r\n'
    .. '  \x1b[36mAlt+L\x1b[0m              Launcher\r\n'
    .. '  \x1b[36m' .. mod_key .. '+Shift+P\x1b[0m     Command palette\r\n'
    .. '  \x1b[36m' .. mod_key .. '+Shift+F\x1b[0m     Search\r\n'
    .. '  \x1b[36m' .. mod_key .. '+Shift+C\x1b[0m     Claude Code pane\r\n'
    .. '\x1b[90m  ───────────────────────────────────\x1b[0m\r\n\r\n'

  pane:inject_output(welcome)
end)

return config
