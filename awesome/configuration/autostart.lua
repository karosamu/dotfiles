-- autostart.lua
-- Autostart Stuff Here
local awful = require("awful")

-- Add apps to autostart here
local autostart_apps = {
	"blueman-applet", -- Bluetooth Systray Applet
	"nm-applet", -- Network Systray Applet
	"picom --experimental-backend", -- Picom compositor
}

for app = 1, #autostart_apps do
	awful.spawn.single_instance(autostart_apps[app], awful.rules.rules)
end

-- EOF ------------------------------------------------------------------------
