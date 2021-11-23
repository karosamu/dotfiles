local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set Autostart Applications
require("configuration.autostart")

-- Default Applications
terminal = "alacritty"
editor = "vim"
editor_cmd = terminal .. os.getenv("EDITOR")
browser = "firefox"
filemanager = "thunar"
discord = "discord"
launcher = "rofi -show drun"

-- Global Vars
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"
shift = "Shift"
ctrl = "Control"

-- Get Bling Config
require("configuration.bling")

-- Get Keybinds
require("configuration.keys")

-- Layouts and Window Stuff
require("configuration.window")

-- Animations
require("configuration.awestore")
