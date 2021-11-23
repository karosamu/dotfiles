-- rc.lua
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local menubar = require("menubar")
local gfs = require("gears.filesystem")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

-- Hotkeys popup
local hotkeys_popup = require("awful.hotkeys_popup")
package.loaded["awful.hotkeys_popup.keys.tmux"] = {}
require("awful.hotkeys_popup.keys")

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)

local theme_path = string.format("%s/.config/awesome/themes/theme.lua", os.getenv("HOME"))
beautiful.init(theme_path)

-- Import Configuration
require("configuration")

-- Screen Padding and Tags
screen.connect_signal("request::desktop_decoration", function(s)
	-- Screen padding
	screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }
end)

-- Import Daemons
require("signal")

local nconf = naughty.config
nconf.defaults.shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, 10)
end

menubar.utils.terminal = terminal

dofile(awful.util.getdir("config") .. "/" .. "bar.lua")

root.buttons(gears.table.join(
	awful.button({}, 3, function()
		main_menu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

-- Right-click menu

main_menu = awful.menu({
	items = {
		{ "Open terminal", terminal },
		{ "Edit config", editor_cmd .. " " .. awesome.conffile },
		{ "Restart awesome", awesome.restart },
		{
			"Shutdown",
			function()
				awful.util.spawn("systemctl poweroff")
			end,
		},
		{
			"Reboot",
			function()
				awful.util.spawn("systemctl reboot")
			end,
		},
	},
})
main_menu.wibox.shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, 10)
end

-----------
-- rules --
-----------
awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen + awful.placement.centered,
			titlebars_enables = true,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {},
			class = {
				"Arandr",
			},

			name = {},
			role = {
				"pop-up",
			},
		},
		properties = { floating = true },
	},
}

-------------
-- signals --
-------------
client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
	c.shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius)
	end
end)
