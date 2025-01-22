local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = wezterm.config_builder()

config.default_prog = {'C:/Program Files/Git/usr/bin/bash.exe', '-l'}

config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'GitHub Dark'
config.font_size = 12
config.window_background_opacity = 0.85
config.window_decorations = "NONE | RESIZE"
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- todo more later
wezterm.on("trigger_preset_layout", function(window, pane)
    local pane2 = pane:split {direction='Right', size=0.45}
    pane2:send_text("ssh -t awakaxis@192.168.1.15 'tmux attach -dt kcord-bot; exec $SHELL'\n")

    local pane3 = pane:split {direction='Bottom', size=0.5}
    pane3:send_text("ssh -t awakaxis@192.168.1.15 'btop; exec $SHELL'\n")
end)

wezterm.on("gui-startup", function(cmd)
    local arg = os.getenv("WEZTERM_LAUNCH_ARGS")
    if arg then
        if arg == "clean" then
            return true
        end
    end
    local tab, pane, window = mux.spawn_window(cmd or {})
    wezterm.emit("trigger_preset_layout", window, pane)
end)

config.keys = {
    {key="t", mods="CTRL", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="t", mods="CTRL|SHIFT", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="w", mods="CTRL", action=wezterm.action{CloseCurrentTab={confirm=false}}},
    {key="c", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="Clipboard"}},
    {key="v", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
    {key="f", mods="CTRL", action=wezterm.action{Search={CaseInSensitiveString=""}}},
    {key="f", mods="CTRL|SHIFT", action=wezterm.action{Search={CaseSensitiveString=""}}},
    {key="PageUp", mods="SHIFT", action=wezterm.action{ScrollByPage=-1}},
    {key="PageDown", mods="SHIFT", action=wezterm.action{ScrollByPage=1}},
    {key="LeftArrow", mods="ALT", action=wezterm.action{ActivateTabRelative=-1}},
    {key="RightArrow", mods="ALT", action=wezterm.action{ActivateTabRelative=1}},
    {key="LeftArrow", mods="CTRL|ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="RightArrow", mods="CTRL|ALT", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="UpArrow", mods="CTRL|ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="DownArrow", mods="CTRL|ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="l", mods="CTRL|SHIFT|ALT", action=wezterm.action.EmitEvent('trigger_preset_layout')},
    {key="p", mods="ALT", action=wezterm.action.PaneSelect{mode="Activate"}},
    {key="w", mods="CTRL", action=wezterm.action.DisableDefaultAssignment}
}



return config
