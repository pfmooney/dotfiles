local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.font = wezterm.font_with_fallback  {
  'Go Mono',
  'Symbols Nerd Font Mono',
}
config.font_size = 9

config.colors = {
  background = "#000000", -- -bg black
  foreground = "#f5deb3", -- -fg wheat
  cursor_bg = "#cccccc",
  cursor_border = "#cccccc",

  -- xterm colors
  ansi = {
    '#000000', -- black
    '#cd0000', -- red
    '#00cd00', -- green
    '#cdcd00', -- yellow
    '#0000ee', -- blue
    '#cd00cd', -- magenta
    '#00cdcd', -- cyan
    '#e5e5e5', -- white
  },
  brights = {
    '#7f7f7f',
    '#ff0000',
    '#00ff00',
    '#ffff00',
    '#5c5cff',
    '#ff00ff',
    '#00ffff',
    '#ffffff',
  },
}
config.bold_brightens_ansi_colors = "No"

config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.scrollback_lines = 0

config.hyperlink_rules = { }
config.detect_password_input = false

config.check_for_updates = false

config.disable_default_key_bindings = true
config.keys = {
  { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
  { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
  { key = 'Home', mods = 'CTRL', action = act.ResetFontSize },
  { key = 'End', mods = 'CTRL', action = act.ReloadConfiguration },

  { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
  { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
  { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
}

return config
