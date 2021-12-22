-- keys.lua
-- Contains Global Keys
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")

-- Custom modules
local machi = require("module.layout-machi")
local bling = require("module.bling")
local kbdcfg = require("module.keyboard_layout.kbdcfg")

-- Client and Tabs Bindings
awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "Down", function()
		awful.client.focus.bydirection("down")
	end, {
		description = "focus down",
		group = "client",
	}),
	awful.key({ modkey }, "Up", function()
		awful.client.focus.bydirection("up")
	end, {
		description = "focus up",
		group = "client",
	}),
	awful.key({ modkey }, "Left", function()
		awful.client.focus.bydirection("left")
	end, {
		description = "focus left",
		group = "client",
	}),
	awful.key({ modkey }, "Right", function()
		awful.client.focus.bydirection("right")
	end, {
		description = "focus right",
		group = "client",
	}),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
		description = "jump to urgent client",
		group = "client",
	}),
	awful.key({ altkey }, "Tab", function()
		awesome.emit_signal("bling::window_switcher::turn_on")
	end, {
		description = "Window Switcher",
		group = "client",
	}),
})

-- Awesomewm
awful.keyboard.append_global_keybindings({
	-- Info
	awful.key({ modkey }, "i", function()
		awful.spawn.with_shell("notifetch")
	end, {
		description = "display system info",
		group = "system",
	}),

	-- Keyboard
	awful.key({ modkey }, "b", function()
		kbdcfg.switch_next()
	end, {
		description = "change keyboard layout",
		group = "keyboard",
	}),
	awful.key({ modkey }, "k", function()
		kbdcfg.switch_next()
	end, {
		description = "change keyboard layout",
		group = "keyboard",
	}),

	-- Volume control
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.easy_async_with_shell("pactl set-sink-mute @DEFAULT_SINK@ no && amixer -D pulse sset Master 5%+ && notify-bar.sh 'Volume' 100 (amixer get Master | awk '$0~/%/{print $5}' | tr -d '[]%' | tail -n 1) volume", function()
			awesome.emit_signal("volume_refresh")
		end)
	end, {
		description = "raise volume by 5%",
		group = "audio",
	}),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.easy_async_with_shell("pactl set-sink-mute @DEFAULT_SINK@ no && amixer -D pulse sset Master 5%- && notify-bar.sh 'Volume' 100 (amixer get Master | awk '$0~/%/{print $5}' | tr -d '[]%' | tail -n 1) volume", function()
			awesome.emit_signal("volume_refresh")
		end)
	end, {
		description = "lower volume by 5%",
		group = "audio",
	}),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn.easy_async_with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle && muted", function()
			awesome.emit_signal("volume_refresh")
		end)
	end, {
		description = "mute audio",
		group = "audio",
	}),

	-- Media Control
	awful.key({}, "XF86AudioPlay", function()
		awful.spawn("playerctl play-pause")
	end, {
		description = "toggle playerctl",
		group = "media",
	}),
	awful.key({}, "XF86AudioPrev", function()
		awful.spawn("playerctl previous")
	end, {
		description = "playerctl previous",
		group = "media",
	}),
	awful.key({}, "XF86AudioNext", function()
		awful.spawn("playerctl next")
	end, {
		description = "playerctl next",
		group = "media",
	}),

	-- Screen Shots/Vids
	awful.key({ modkey }, "s", function()
		awful.spawn.with_shell("scrot 0")
	end, {
		description = "take a screenshot",
		group = "system",
	}),
	awful.key({ modkey, shift }, "s", function()
		awful.spawn.with_shell("scrot 5")
	end, {
		description = "take a screenshot",
		group = "system",
	}),

	-- Brightness
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("bright-notify +5%")
	end, {
		description = "increase brightness",
		group = "system",
	}),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("bright-notify 5%-")
	end, {
		description = "decrease brightness",
		group = "system",
	}),

	-- Awesome stuff
	awful.key({ modkey }, "/", hotkeys_popup.show_help, {
		description = "show help",
		group = "awesome",
	}),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, {
		description = "go back",
		group = "tag",
	}),
	awful.key({ modkey }, "x", function()
		require("ui.pop.exitscreen").exit_screen_show()
	end, {
		description = "show exit screen",
		group = "awesome",
	}),
	awful.key({ modkey, "Shift" }, "r", awesome.restart, {
		description = "reload awesome",
		group = "awesome",
	}),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, {
		description = "quit awesome",
		group = "awesome",
	}),
})

-- Launcher and screen
awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "d", function()
		awful.util.spawn("rofi -show drun")
	end, {
		description = "run rofi",
		group = "launcher",
	}),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, {
		description = "focus the next screen",
		group = "screen",
	}),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, {
		description = "focus the previous screen",
		group = "screen",
	}),
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, {
		description = "open a terminal",
		group = "launcher",
	}),
	awful.key({ modkey }, "e", function()
		awful.spawn(filemanager)
	end, {
		description = "open file browser",
		group = "launcher",
	}),
	awful.key({ modkey }, "w", function()
		awful.spawn.with_shell(browser)
	end, {
		description = "open firefox",
		group = "launcher",
	}),
	awful.key({ modkey, "Shift" }, "Left", function()
		awful.tag.incmwfact(0.05)
	end, {
		description = "increase master width factor",
		group = "layout",
	}),
	awful.key({ modkey, "Shift" }, "Right", function()
		awful.tag.incmwfact(-0.05)
	end, {
		description = "decrease master width factor",
		group = "layout",
	}),
	awful.key({ modkey }, "l", function()
		awful.spawn.easy_async_with_shell("powermenu", function()
			kbdcfg.switch_by_name("English (UK)")
		end)
	end, {
		description = "power menu",
		group = "system",
	}),
	-- awful.key({modkey}, "h",
	--           function() awful.tag.incnmaster(1, nil, true) end, {
	--     description = "increase the number of master clients",
	--     group = "layout"
	-- }),
	-- awful.key({modkey}, "l",
	--               function() awful.tag.incnmaster(-1, nil, true) end, {
	--     description = "decrease the number of master clients",
	--     group = "layout"
	-- }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, {
		description = "increase the number of columns",
		group = "layout",
	}),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, {
		description = "decrease the number of columns",
		group = "layout",
	}),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, {
		description = "select next",
		group = "layout",
	}),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, {
		description = "select previous",
		group = "layout",
	}),
	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", {
				raise = true,
			})
		end
	end, {
		description = "restore minimized",
		group = "client",
	}),
})

-- Client management keybinds
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ modkey }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, {
			description = "toggle fullscreen",
			group = "client",
		}),
		awful.key({ modkey }, "q", function(c)
			c:kill()
		end, {
			description = "close",
			group = "client",
		}),
		awful.key({ modkey }, "a", awful.client.floating.toggle, {
			description = "toggle floating",
			group = "client",
		}),
		awful.key({ modkey, "Control" }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end, {
			description = "move to master",
			group = "client",
		}),
		awful.key({ modkey }, "o", function(c)
			c:move_to_screen()
		end, {
			description = "move to screen",
			group = "client",
		}),
		awful.key({ modkey, shift }, "b", function(c)
			c.floating = not c.floating
			c.width = 400
			c.height = 200
			awful.placement.bottom_right(c)
			c.sticky = not c.sticky
		end, {
			description = "toggle keep on top",
			group = "client",
		}),
		awful.key({ modkey }, "n", function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end, {
			description = "minimize",
			group = "client",
		}),
		awful.key({ modkey }, "f", function(c)
			c.maximized = not c.maximized
			c:raise()
		end, {
			description = "(un)maximize",
			group = "client",
		}),
		awful.key({ modkey, "Control" }, "f", function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end, {
			description = "(un)maximize vertically",
			group = "client",
		}),
		awful.key({ modkey, "Shift" }, "f", function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end, {
			description = "(un)maximize horizontally",
			group = "client",
		}),

		-- On the fly padding change
		awful.key({ modkey, shift }, "=", function()
			helpers.resize_padding(5)
		end, {
			description = "add padding",
			group = "screen",
		}),
		awful.key({ modkey, shift }, "-", function()
			helpers.resize_padding(-5)
		end, {
			description = "subtract padding",
			group = "screen",
		}),

		-- On the fly useless gaps change
		awful.key({ modkey }, "=", function()
			helpers.resize_gaps(5)
		end, {
			description = "add gaps",
			group = "screen",
		}),
		awful.key({ modkey }, "-", function()
			helpers.resize_gaps(-5)
		end, {
			description = "subtract gaps",
			group = "screen",
		}),

		-- Single tap: Center client
		-- Double tap: Center client + Floating + Resize
		awful.key({ modkey }, "c", function(c)
			awful.placement.centered(c, {
				honor_workarea = true,
				honor_padding = true,
			})
			helpers.single_double_tap(nil, function()
				helpers.float_and_resize(c, screen_width * 0.25, screen_height * 0.28)
			end)
		end),
	})
end)

-- Num row keybinds
awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { modkey },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { modkey, "Control" },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),
	awful.key({
		modifiers = { modkey, "Shift" },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
	awful.key({
		modifiers = { modkey, "Control", "Shift" },
		keygroup = "numrow",
		description = "toggle focused client on tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}),
})

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({
				context = "mouse_click",
			})
		end),
		awful.button({ modkey }, 1, function(c)
			c:activate({
				context = "mouse_click",
				action = "mouse_move",
			})
		end),
		awful.button({ modkey }, 3, function(c)
			c:activate({
				context = "mouse_click",
				action = "mouse_resize",
			})
		end),
	})
end)

-- EOF ------------------------------------------------------------------------
