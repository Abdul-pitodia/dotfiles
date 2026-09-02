local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- ============================================================
-- Appearance
-- ============================================================

config.color_scheme = "Nord"

config.font = wezterm.font({
    family = "JetBrains Mono",
    weight = "Medium",
})

config.font_size = 15.0

config.line_height = 1.0

config.window_background_opacity = 0.96
config.macos_window_background_blur = 20

config.window_decorations = "RESIZE"

config.window_padding = {
    left = 12,
    right = 12,
    top = 10,
    bottom = 10,
}

-- ============================================================
-- Tabs
-- ============================================================

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.hide_tab_bar_if_only_one_tab = false

config.tab_max_width = 32

-- ============================================================
-- Cursor
-- ============================================================

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- ============================================================
-- Scrollback
-- ============================================================

config.scrollback_lines = 10000

-- ============================================================
-- Performance
-- ============================================================

config.prefer_egl = true
config.max_fps = 60

-- ============================================================
-- Keyboard shortcuts
-- ============================================================

local action = wezterm.action

config.keys = {

    -- Cmd + K
    -- Clear both visible screen AND scrollback
{
    key = "k",
    mods = "CMD",
    action = action.SendKey({
        key = "l",
        mods = "CTRL",
    }),
},

    -- New WezTerm tab
    {
        key = "t",
        mods = "CMD",
        action = action.SpawnTab("CurrentPaneDomain"),
    },

    -- Split vertically
    {
        key = "d",
        mods = "CMD",
        action = action.SplitHorizontal({
            domain = "CurrentPaneDomain",
        }),
    },

    -- Split horizontally
    {
        key = "D",
        mods = "CMD|SHIFT",
        action = action.SplitVertical({
            domain = "CurrentPaneDomain",
        }),
    },

    -- Close pane
    {
        key = "w",
        mods = "CMD",
        action = action.CloseCurrentPane({
            confirm = false,
        }),
    },

    -- Close tab
    {
        key = "w",
        mods = "CMD|SHIFT",
        action = action.CloseCurrentTab({
            confirm = false,
        }),
    },

    -- Search terminal output
    {
        key = "f",
        mods = "CMD",
        action = action.Search("CurrentSelectionOrEmptyString"),
    },

    -- Font size
    {
        key = "=",
        mods = "CMD",
        action = action.IncreaseFontSize,
    },

    {
        key = "-",
        mods = "CMD",
        action = action.DecreaseFontSize,
    },

    {
        key = "0",
        mods = "CMD",
        action = action.ResetFontSize,
    },

    {
    key = "LeftArrow",
    mods = "OPT",
    action = wezterm.action.SendString("\x1bb"),
},
{
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action.SendString("\x1bf"),
},
}

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

return config