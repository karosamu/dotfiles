local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local bling = require("module.bling")
local rubato = require("module.rubato")

bling.module.flash_focus.enable()

-- Set Wallpaper
awful.screen.connect_for_each_screen(function(s) -- that way the wallpaper is applied to every screen
	bling.module.tiled_wallpaper("", s, { --         -- call the actual function ("x" is the string that will be tiled)
		fg = "#cc6666", -- define the foreground color
		bg = "#282a2e", -- '#1d1f21', -- define the background color
		offset_y = 35, -- set a y offset
		offset_x = 22, -- set a x offset
		font = "SFMono Nerd Font Mono", -- set the font (without the size)
		font_size = 30, -- set the font size
		padding = 150, -- set padding (default is 100)
		zickzack = true, -- rectangular pattern or criss cross
	})
end)

-- Tag Preview

bling.widget.tag_preview.enable({
	scale = 0.15,
	x = 10,
	y = 865,
	honor_padding = true,
	honor_workarea = false,
	show_client_content = true,
	background_widget = wibox.widget({
		image = beautiful.wallpaper,
		horizontal_fit_policy = "fit",
		vertical_fit_policy = "fit",
		widget = wibox.widget.imagebox,
	}),
})

bling.widget.window_switcher.enable()
