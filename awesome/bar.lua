pcall(require, "luarocks.loader")
require("awful.autofocus")

local rubato = require("module.rubato")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local bling = require("module.bling")
local kbdcfg = require("module.keyboard_layout.kbdcfg")

-- Keyboard map indicator and changer
local kbdcfg = kbdcfg({ cmd = "setxkbmap", type = "tui" })

kbdcfg.add_primary_layout("English (UK)", "GB", "gb")
kbdcfg.add_primary_layout("English (US)", "US", "us")
kbdcfg.add_primary_layout("Lithuanian", "LT", "lt")

kbdcfg.bind()
kbdcfg.widget:buttons(awful.util.table.join(
	awful.button({}, 1, function()
		kbdcfg.switch_next()
	end),
	awful.button({}, 3, function()
		kbdcfg.menu:toggle()
	end)
))

-- Battery Bar Widget ---------------------------------------------------------
local battery_icon = wibox.widget({
	font = beautiful.font_medium,
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

local battery_prog = wibox.widget({
	max_value = 100,
	min_value = 0,
	value = 20,
	forced_height = 3,
	forced_width = 75,
	color = beautiful.red,
	background_color = beautiful.primary,
	shape = gears.shape.rounded_bar,
	widget = wibox.widget.progressbar,
})

awesome.connect_signal("signal::battery", function(percentage, state)
	local value = percentage

	local bat_icon = ""
	local bat_color = beautiful.green

	if value >= 0 and value <= 15 then
		bat_icon = ""
		bat_color = beautiful.red
	elseif value > 15 and value <= 20 then
		bat_icon = ""
		bat_color = beautiful.red
	elseif value > 20 and value <= 30 then
		bat_icon = ""
		bat_color = beautiful.red
	elseif value > 30 and value <= 40 then
		bat_icon = ""
		bat_color = beautiful.red
	elseif value > 40 and value <= 50 then
		bat_icon = ""
		bat_color = beautiful.yellow
	elseif value > 50 and value <= 60 then
		bat_icon = ""
		bat_color = beautiful.yellow
	elseif value > 60 and value <= 70 then
		bat_icon = ""
		bat_color = beautiful.yellow
	elseif value > 70 and value <= 80 then
		bat_icon = ""
		bat_color = beautiful.green
	elseif value > 80 and value <= 90 then
		bat_icon = ""
		bat_color = beautiful.green
	elseif value > 90 and value <= 100 then
		bat_icon = ""
		bat_color = beautiful.green
	end

	-- if charging
	if state == 1 then
		bat_icon = ""
		bat_color = beautiful.blue
	end

	battery_prog.value = percentage

	battery_icon.markup = "<span foreground='" .. bat_color .. "'>" .. bat_icon .. "</span>"
end)

-- Creates the textclock widget.
mytextclock = wibox.widget({
	{
		id = "clock",
		widget = wibox.widget.textclock("%m/%d %H:%M"),
	},
	widget = wibox.container.margin,
	left = 12,
	right = 12,
})

-- Creates the system tray.
tray = wibox.widget.systray()
tray:set_base_size(24)

local function interpolate(first_color, second_color, amount)
	return {
		r = second_color.r * amount + first_color.r * (1 - amount),
		g = second_color.g * amount + first_color.g * (1 - amount),
		b = second_color.b * amount + first_color.b * (1 - amount),
	}
end

local function parse_color(color)
	local color = { gears.color.parse_color(color) }
	return {
		r = color[1] * 255,
		g = color[2] * 255,
		b = color[3] * 255,
	}
end

local function get_color(name)
	return parse_color(beautiful[name])
end

-- Volume widget.
local function draw_volume(cr, height)
	local two_pi = math.pi * 2
	local half_pi = math.pi / 2

	local volume = helpers.get_volume()
	local muted = helpers.get_muted()

	local colors = {
		get_color("volume_color_normal"),
		get_color("volume_color_mid"),
		get_color("volume_color_high"),
		get_color("volume_color_max"),
	}
	local muted_color = get_color("volume_color_muted")

	progress = (volume % 100) / 100
	if not (volume == 0) and progress == 0 then
		progress = 1
	end

	local function draw_volume_arc(start, stop, color) -- start and stop are values in [0,1]
		cr:set_source_rgb(color.r / 255, color.g / 255, color.b / 255)
		cr:set_line_width(4)
		cr:arc(height / 2, height / 2, 6, start * two_pi - half_pi, stop * two_pi - half_pi)
		cr:stroke()
	end

	if volume <= 33 then
		local c
		if muted then
			c = muted_color
		else
			c = colors[1]
		end
		draw_volume_arc(0, progress, c)
	elseif volume <= 66 and volume >= 33 then
		local c
		if muted then
			c = muted_color
		else
			c = colors[2]
		end
		draw_volume_arc(0, progress, c)
	elseif volume <= 99 and volume >= 66 then
		local c
		if muted then
			c = muted_color
		else
			c = colors[3]
			draw_volume_arc(0, progress, c)
		end
		draw_volume_arc(0, progress, c)
	elseif volume <= 100 and volume >= 99 then
		local c
		if muted then
			c = muted_color
		else
			c = colors[4]
		end
		draw_volume_arc(0, 1, c)
	end
end

local function make_volume_widget()
	local widget = wibox.widget({
		fit = function(self, context, width, height)
			return height, height
		end,
		draw = function(self, context, cr, width, height)
			draw_volume(cr, height)
		end,
		layout = wibox.widget.base.make_widget,
	})

	awesome.connect_signal("volume_refresh", function()
		widget:emit_signal("widget::redraw_needed")
	end)

	return widget
end

local myvolumewidget = make_volume_widget()

local tray_popup = awful.popup({
	widget = wibox.widget({
		{
			id = "tray",
			widget = tray,
		},
		widget = wibox.container.margin,
		left = 12,
		margins = { left = 10, right = 10, bottom = 0, top = 7 },
		right = 12,
	}),
	x = 1570,
	y = 987,
	ontop = true,
	minimum_height = 38,
	visible = false,
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 10)
	end,
	bg = beautiful.primary,
})

local function toggle_tray()
	tray_popup.visible = not tray_popup.visible
end

awful.screen.connect_for_each_screen(function(s)
	mytextclock:buttons(gears.table.join(
		mytextclock:buttons(),
		awful.button({}, 1, nil, function()
			toggle_tray()
		end)
	))

	-- Tagtable for each screen.
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[3])

	local function draw_circle(cr, height)
		cr:arc(height / 2, height / 2, 5, 0, math.pi * 2)
		cr:fill()
	end

	local function make_circle_widget(color)
		return wibox.widget({
			fit = function(self, context, width, height)
				return height, height
			end,
			draw = function(self, context, cr, width, height)
				cr:set_source_rgb(color.r / 255, color.g / 255, color.b / 255)
				draw_circle(cr, height)
			end,
			layout = wibox.widget.base.make_widget,
		})
	end

	local function update_rgb(widget, rgb)
		widget.draw = function(self, context, cr, width, height)
			cr:set_source_rgb(rgb.r / 255, rgb.g / 255, rgb.b / 255)
			draw_circle(cr, height)
		end
		widget:emit_signal("widget::redraw_needed")
	end

	local function create_taglist_items(s)
		local widgets = { layout = wibox.layout.fixed.horizontal }

		local non_empty_color = get_color("tag_non_empty")
		local empty_color = get_color("tag_empty")
		local hover_color = get_color("tag_hover")

		for i, tag in pairs(s.tags) do
			local widget = make_circle_widget(color)
			widget.buttons = awful.button({}, 1, function()
				tag:view_only()
			end)

			local update_tags = function()
				if not (#tag:clients() == 0) then
					update_rgb(widget, non_empty_color)
				else
					update_rgb(widget, empty_color)
				end
			end
			client.connect_signal("tagged", update_tags)
			client.connect_signal("untagged", update_tags)

			local hover_timed = rubato.timed({
				intro = 0.075,
				duration = 0.2,
				awestore_compat = true,
			})

			hover_timed:subscribe(function(pos)
				local col
				if not (#tag:clients() == 0) then
					col = non_empty_color
				else
					col = empty_color
				end
				col = interpolate(col, hover_color, pos)
				update_rgb(widget, col)
			end)

			widget:connect_signal("mouse::enter", function()
				tag.is_being_hovered = true
				hover_timed:set(1)

				if #tag:clients() > 0 then
					awesome.emit_signal("bling::tag_preview::update", tag)
					awesome.emit_signal("bling::tag_preview::visibility", s, true)
				end
			end)
			widget:connect_signal("mouse::leave", function()
				tag.is_being_hovered = false
				hover_timed:set(0)

				awesome.emit_signal("bling::tag_preview::visibility", s, false)
			end)

			table.insert(widgets, widget)
		end

		return widgets
	end

	local function draw_tag_indicator(cr, height, xpos)
		cr:arc(xpos, height / 2, 12, 0, math.pi * 2)
		cr:fill()
	end

	local function update_tag_indicator(widget, pos, rgb)
		widget.draw = function(self, context, cr, width, height)
			cr:set_source_rgb(rgb.r / 255, rgb.g / 255, rgb.b / 255)
			draw_tag_indicator(cr, height, height / 2 + (pos - 1) * height)
		end
		widget:emit_signal("widget::redraw_needed")
	end

	local function create_tag_indicator(s)
		local col = get_color("tag_ind")

		local widget = wibox.widget({
			fit = function(self, context, width, height)
				return height, height
			end,

			draw = function(self, context, cr, width, height)
				cr:set_source_rgba(col.r / 255, col.g / 255, col.b / 255)
				draw_tag_indicator(cr, height, height / 2)
			end,

			layout = wibox.widget.base.make_widget,
		})

		local index = 1

		local tag_indices = {}
		for i, tag in ipairs(s.tags) do
			tag_indices[tag] = i
		end

		local pos

		local timed = rubato.timed({
			duration = 0.3,
			intro = 0.15,
			pos = index,
			easing = rubato.quadratic,
			awestore_compat = true,
		})

		timed:subscribe(function(_pos)
			pos = _pos
			update_tag_indicator(widget, pos, col)
		end)

		s:connect_signal("tag::history::update", function()
			if tag_indices[s.selected_tag] == widget.index then
				return
			end

			timed:set(tag_indices[s.selected_tag])
			index = tag_indices[s.selected_tag]
		end)

		return widget
	end

	s.test_taglist = wibox.widget({
		create_tag_indicator(s),
		create_taglist_items(s),
		layout = wibox.layout.stack,
	})

	-- Wibars.
	local sgeo = s.geometry
	local gap = beautiful.useless_gap

	local width = 190
	local height = 38

	local args = {
		x = sgeo.x + gap * 2,
		y = sgeo.y + sgeo.height - gap * 2 - height,
		screen = s,
		width = width,
		height = height,
		visible = true,
		border_width = beautiful.border_width,
		border_color = beautiful.secondary,
		shape = function(cr)
			gears.shape.rounded_rect(cr, width, height, beautiful.bar_corner_radius)
		end,
	}

	s.tagbar = wibox(args)

	s.tagbar:setup({
		{
			layout = wibox.layout.align.horizontal,
			expand = "none",
			nil,
			s.test_taglist,
		},
		bottom = beautiful.border_width * 2 + 2,
		top = 2,
		left = 2,
		right = beautiful.border_width * 2 + 2,
		color = beautiful.bg_normal,
		widget = wibox.container.margin,
	})

	width = 140
	args.width = width

	args.x = sgeo.x + sgeo.width - width - gap * 2

	s.clockbar = wibox(args)

	s.clockbar:setup({
		{
			layout = wibox.layout.align.horizontal,
			expand = "none",
			nil,
			mytextclock,
		},
		bottom = beautiful.border_width * 2 + 5,
		top = 5,
		left = 10,
		right = beautiful.border_width * 2 + 10,
		color = beautiful.bg_normal,
		widget = wibox.container.margin,
	})

	old_width = args.width
	width = 60
	args.width = width

	args.x = sgeo.x + sgeo.width - width - old_width - gap * 4

	s.volumebar = wibox(args)

	s.volumebar:setup({
		{
			layout = wibox.layout.align.horizontal,
			expand = "none",
			nil,
			myvolumewidget,
		},
		bottom = beautiful.border_width * 2 + 5,
		top = 5,
		left = 10,
		right = beautiful.border_width * 2 + 10,
		color = beautiful.bg_normal,
		widget = wibox.container.margin,
	})

	old_width = args.width
	width = 60
	args.width = width

	args.x = sgeo.x + sgeo.width - width - old_width - gap * 41

	s.batterybar = wibox(args)

	s.batterybar:setup({
		{
			layout = wibox.layout.align.horizontal,
			expand = "none",
			nil,
			battery_icon,
		},
		bottom = beautiful.border_width * 2 + 5,
		top = 5,
		left = 10,
		right = beautiful.border_width * 2 + 10,
		color = beautiful.bg_normal,
		widget = wibox.container.margin,
	})

	old_width = args.width
	width = 60
	args.width = width

	args.x = sgeo.x + sgeo.width - width - old_width - gap * 58

	s.langbar = wibox(args)

	s.langbar:setup({
		{
			layout = wibox.layout.align.horizontal,
			expand = "left",
			nil,
			kbdcfg,
		},
		bottom = beautiful.border_width * 2 + 5,
		top = 5,
		left = 13,
		right = beautiful.border_width * 2 + 10,
		color = beautiful.bg_normal,
		widget = wibox.container.margin,
	})

	s.padding = { left = 0, right = 0, bottom = height + gap * 2, top = 0 }
end)
