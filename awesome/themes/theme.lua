local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local theme_path = string.format("%s/.config/awesome/themes/", os.getenv("HOME"))

local theme = {}

------------
-- colors --
------------
theme.font = "SFMono Nerd Font Mono 10"
theme.font_medium = "SFMono Nerd Font Mono 14"
theme.font_big = "SFMono Nerd Font Mono 16"
theme.font_icon = "SFMono Nerd Font Mono"

theme.primary = "#1d1f21"
theme.primary_dark = "#ffffff"

theme.secondary = "#282a2e"
theme.secondary_bright = "#cc6666"

theme.foreground = "#c5c8c6"
theme.foreground_dark = "#373b41"
theme.foreground_bright = "#ffffff"

theme.red = "#cc6666"
theme.green = "#b5bd68"
theme.yellow = "#f0c674"
theme.blue = "#81a2be"
theme.magenta = "#b294bb"
theme.cyan = "#8abeb7"

theme.progress_bar_normal = theme.blue
theme.progress_bar_off = theme.red

theme.bg_normal = theme.primary
theme.bg_focus = theme.secondary
theme.bg_urgent = theme.red
theme.bg_minimize = theme.primary_dark
theme.bg_systray = theme.primary

theme.fg_normal = theme.foreground
theme.fg_focus = theme.foreground_bright
theme.fg_urgent = theme.foreground_bright
theme.fg_minimize = theme.foreground

theme.useless_gap = dpi(4)
theme.border_width = 0
theme.border_normal = theme.primary
theme.border_focus = theme.secondary_bright
theme.border_marked = theme.blue

theme.wibar_bg = theme.bg_normal
theme.wibar_fg = theme.fg_normal

theme.bg_systray = theme.primary
theme.systray_icon_spacing = dpi(8)
theme.hotkeys_shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, 10)
end
theme.hotkeys_group_margin = dpi(80)
theme.hotkeys_font = font_icon
theme.hotkeys_modifiers_fg = theme.red
theme.hotkeys_bg = theme.primary
theme.hotkeys_fg = theme.primary_dark

theme.tag_non_empty = theme.foreground
theme.tag_empty = theme.secondary
theme.tag_ind = theme.secondary_bright
theme.tag_hover = theme.secondary_bright

theme.volume_color_normal = "#b5bd68"
theme.volume_color_high = "#cc6666"
theme.volume_color_muted = "#cc6666"

-----------
-- bling --
-----------
theme.flash_focus_start_opacity = 0.85
theme_flash_focus_step = 0.1

theme.tag_preview_client_opacity = 1
theme.tag_preview_client_bg = theme.primary
theme.tag_preview_widget_bg = theme.primary
theme.tag_preview_widget_border_color = theme.secondary
theme.tag_preview_client_border_color = theme.secondary

theme.tag_preview_client_border_width = 0
theme.tag_preview_widget_border_width = 0

theme.tag_preview_widget_border_radius = 10
theme.tag_preview_client_border_radius = 10

-- tabs

-- For tabbed only
theme.tabbed_spawn_in_tab = true -- whether a new client should spawn into the focused tabbing container

-- For tabbar in general
theme.tabbar_ontop = false
theme.tabbar_radius = 10 -- border radius of the tabbar
theme.tabbar_style = "modern" -- style of the tabbar ("default", "boxes" or "modern")
theme.tabbar_font = theme.font -- font of the tabbar
theme.tabbar_size = 40 -- size of the tabbar
theme.tabbar_position = "top" -- position of the tabbar
theme.tabbar_bg_normal = theme.primary -- background color of the focused client on the tabbar
theme.tabbar_fg_normal = theme.foreground -- foreground color of the focused client on the tabbar
theme.tabbar_bg_focus = theme.primary -- background color of unfocused clients on the tabbar
theme.tabbar_fg_focus = theme.secondary -- foreground color of unfocused clients on the tabbar
-- theme.tabbar_bg_focus_inactive = nil   -- background color of the focused client on the tabbar when inactive
-- theme.tabbar_fg_focus_inactive = nil   -- foreground color of the focused client on the tabbar when inactive
-- theme.tabbar_bg_normal_inactive = nil  -- background color of unfocused clients on the tabbar when inactive
-- theme.tabbar_fg_normal_inactive = nil  -- foreground color of unfocused clients on the tabbar when inactive
-- theme.tabbar_disable = false           -- disable the tab bar entirely

-- the following variables are currently only for the "modern" tabbar style
theme.tabbar_color_close = "#f9929b" -- chnges the color of the close button
theme.tabbar_color_min = "#fbdf90" -- chnges the color of the minimize button
theme.tabbar_color_float = "#ccaced" -- chnges the color of the float button

-------------------
-- notifications --
-------------------

theme.notification_max_height = dpi(300)
theme.notification_bg = theme.primary
theme.notification_fg = theme.foreground

naughty.config.padding = 20
naughty.config.spacing = 10
naughty.config.defaults.border_width = dpi(0)

naughty.config.defaults.margin = 15

-----------------
-- other stuff --
-----------------
theme.menu_submenu_icon = theme_path .. "submenu.png"
theme.menu_height = dpi(28)
theme.menu_width = dpi(180)
theme.menu_font = theme.font

theme.corner_radius = 10
theme.bar_corner_radius = 10

-- theme.wallpaper         = theme_path.."background.png"

theme.layout_fairh = theme_path .. "layouts/fairhw.png"
theme.layout_fairv = theme_path .. "layouts/fairvw.png"
theme.layout_floating = theme_path .. "layouts/floatingw.png"
theme.layout_magnifier = theme_path .. "layouts/magnifierw.png"
theme.layout_max = theme_path .. "layouts/maxw.png"
theme.layout_fullscreen = theme_path .. "layouts/fullscreenw.png"
theme.layout_tilebottom = theme_path .. "layouts/tilebottomw.png"
theme.layout_tileleft = theme_path .. "layouts/tileleftw.png"
theme.layout_tile = theme_path .. "layouts/tilew.png"
theme.layout_tiletop = theme_path .. "layouts/tiletopw.png"
theme.layout_spiral = theme_path .. "layouts/spiralw.png"
theme.layout_dwindle = theme_path .. "layouts/dwindlew.png"
theme.layout_cornernw = theme_path .. "layouts/cornernww.png"
theme.layout_cornerne = theme_path .. "layouts/cornernew.png"
theme.layout_cornersw = theme_path .. "layouts/cornersww.png"
theme.layout_cornerse = theme_path .. "layouts/cornersew.png"

return theme
