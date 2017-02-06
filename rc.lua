-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

local assault = require('assault')

local xdg_menu = require("archmenu")

local alttab = require("alttab")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors***REMOVED***)
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err***REMOVED***)
        in_error = false
    end)
end
--***REMOVED******REMOVED******REMOVED***

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/aidan/.config/awesome/themes/default/theme.lua")

-- myassault = assault({
--     battery = "BAT0", -- battery ID to get data from
--     adapter = "AC", -- ID of the AC adapter to get data from
--     critical_color = "#dc322f",
--     charging_color = "#859900",
--     width = 50,
--     height = 30,
--     bolt_width = 19,
--     bolt_height = 11,
--     stroke_width = 2,
--     peg_top = (calculated),
--     peg_height = (15 / 3),
--     peg_width = 2,
--     font = beautiful.font,
--     critical_level = 0.10,
--     normal_color = beautiful.fg_normal
--***REMOVED***)

-- This is used later as the default terminal and editor to run.
-- terminal = "xterm -fa 'Hack' -fs 12"
terminal = "run-in-terminator"
-- editor = os.getenv("EDITOR") or "vi"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
***REMOVED***
--***REMOVED******REMOVED******REMOVED***

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
--***REMOVED******REMOVED******REMOVED***

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {***REMOVED***
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9***REMOVED***, s, layouts[1])
end
--***REMOVED******REMOVED******REMOVED***

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome"***REMOVED***,
   { "edit config", editor_cmd .. " " .. awesome.conffile***REMOVED***,
   { "restart", awesome.restart***REMOVED***,
   { "quit", terminal .. " -e pkill -u " .. os.getenv('USER')***REMOVED***
   -- { "quit", awesome.quit***REMOVED***
***REMOVED***

variety = "variety"
varietymenu = {
  { "Next", variety .. " -n"***REMOVED***,
  { "Previous", variety .. " -p"***REMOVED***,
  { "Favourite", variety .. " -f"***REMOVED***,
  { "Trash", variety .. " -t"***REMOVED***
***REMOVED***

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon***REMOVED***,
                                    { "Apps", xdgmenu***REMOVED***,
                                    { "Variety", varietymenu***REMOVED***,
                                    { "Terminal", terminal***REMOVED***
                                 ***REMOVED***
                       ***REMOVED***)

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu***REMOVED***)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
--***REMOVED******REMOVED******REMOVED***

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {***REMOVED***
mypromptbox = {***REMOVED***
mylayoutbox = {***REMOVED***
mytaglist = {***REMOVED***
mytaglist.buttons = awful.util.table.join(
                    awful.button({***REMOVED***, 1, awful.tag.viewonly),
                    awful.button({ modkey***REMOVED***, 1, awful.client.movetotag),
                    awful.button({***REMOVED***, 3, awful.tag.viewtoggle),
                    awful.button({ modkey***REMOVED***, 3, awful.client.toggletag),
                    awful.button({***REMOVED***, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({***REMOVED***, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {***REMOVED***
mytasklist.buttons = awful.util.table.join(
                     awful.button({***REMOVED***, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({***REMOVED***, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250***REMOVED***
                                                 ***REMOVED***)
                                              end
                                          end),
                     awful.button({***REMOVED***, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({***REMOVED***, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({***REMOVED***, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({***REMOVED***, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({***REMOVED***, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({***REMOVED***, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s***REMOVED***)

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    -- right_layout:add(myassault)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
--***REMOVED******REMOVED******REMOVED***

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({***REMOVED***, 3, function () mymainmenu:toggle() end),
    awful.button({***REMOVED***, 4, awful.tag.viewnext),
    awful.button({***REMOVED***, 5, awful.tag.viewprev)
))
--***REMOVED******REMOVED******REMOVED***

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,          ***REMOVED***, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,          ***REMOVED***, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,          ***REMOVED***, "Escape", awful.tag.history.restore),

    awful.key({ modkey,          ***REMOVED***, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,          ***REMOVED***, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,          ***REMOVED***, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"  ***REMOVED***, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"  ***REMOVED***, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control"***REMOVED***, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control"***REMOVED***, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,          ***REMOVED***, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,          ***REMOVED***, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,          ***REMOVED***, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control"***REMOVED***, "r", awesome.restart),
    awful.key({ modkey, "Shift"  ***REMOVED***, "q", awesome.quit),

    awful.key({ modkey,          ***REMOVED***, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,          ***REMOVED***, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"  ***REMOVED***, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"  ***REMOVED***, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control"***REMOVED***, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control"***REMOVED***, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,          ***REMOVED***, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"  ***REMOVED***, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control"***REMOVED***, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey***REMOVED***,            "r",     function () mypromptbox[mouse.screen.index]:run() end),

    awful.key({ modkey***REMOVED***, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: "***REMOVED***,
                  mypromptbox[mouse.screen.index].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey***REMOVED***, "p", function() menubar.show() end),


    -- Volume Keys
  awful.key({***REMOVED***, "#122", function ()
    awful.util.spawn("amixer -q -D pulse sset Master 5%-")
    awful.util.spawn("/usr/local/bin/volume_percentage_notification.sh")
  end),

  awful.key({***REMOVED***, "#123", function ()
    awful.util.spawn("amixer -q -D pulse sset Master 5%+")
    awful.util.spawn("/usr/local/bin/volume_percentage_notification.sh")
  end),

    awful.key({***REMOVED***, "XF86AudioMute", function ()
    awful.util.spawn("amixer -D pulse set Master 1+ toggle")
  end),

  -- Media Keys
  awful.key({***REMOVED***, "XF86AudioPlay", function()
    awful.util.spawn("playerctl play-pause")
  end),

  awful.key({***REMOVED***, "XF86AudioNext", function()
    awful.util.spawn("playerctl next")
  end),

  awful.key({***REMOVED***, "XF86AudioPrev", function()
    awful.util.spawn("playerctl previous")
  end),

  awful.key({***REMOVED***, "XF86MonBrightnessDown", function ()
  awful.util.spawn_with_shell("curl -q -s http://localhost:5600/decrease | xargs -I '{***REMOVED***' python -c \"print(int({***REMOVED*** / $(cat /sys/class/backlight/gmux_backlight/max_brightness) * 100))\" | xargs -I '{***REMOVED***' flock -n /tmp/brightnessNotify.lock notify-send -u low -t 700 'Brightness' '{***REMOVED***%' && rm -f /tmp/brightnessNotify.lock") end),
  awful.key({***REMOVED***, "XF86MonBrightnessUp", function ()
      awful.util.spawn_with_shell("curl -q -s http://localhost:5600/increase | xargs -I '{***REMOVED***' python -c \"print(int({***REMOVED*** / $(cat /sys/class/backlight/gmux_backlight/max_brightness) * 100))\" | xargs -I '{***REMOVED***' flock -n /tmp/brightnessNotify.lock notify-send -u low -t 700 'Brightness' '{***REMOVED***%' && rm -f /tmp/brightnessNotify.lock") end),
  awful.key({***REMOVED***, "XF86KbdBrightnessDown", function ()
      awful.util.spawn("curl -q -s http://localhost:5600/decreasekbd &> /dev/null 2>&1") end),
  awful.key({***REMOVED***, "XF86KbdBrightnessUp", function ()
      awful.util.spawn("curl -q -s http://localhost:5600/increasekbd &> /dev/null 2>&1") end)
--   awful.key({ "Mod1"***REMOVED***, "Tab",
--       function ()
--          alttab.switch(1, "Alt_L", "Tab", "ISO_Left_Tab")
--       end
--   ),
--   awful.key({ "Mod1", "Shift"  ***REMOVED***, "Tab",
--       function ()
--          alttab.switch(-1, "Alt_L", "Tab", "ISO_Left_Tab")
--       end
--   )

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,          ***REMOVED***, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"  ***REMOVED***, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control"***REMOVED***, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control"***REMOVED***, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,          ***REMOVED***, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,          ***REMOVED***, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,          ***REMOVED***, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,          ***REMOVED***, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey***REMOVED***, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control"***REMOVED***, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift"***REMOVED***, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift"***REMOVED***, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({***REMOVED***, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey***REMOVED***, 1, awful.mouse.client.move),
    awful.button({ modkey***REMOVED***, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
--***REMOVED******REMOVED******REMOVED***

do
    local conky = nil

    function get_conky(default)
        if conky and conky.valid then
            return conky
        end

        conky = awful.client.iterate(function(c) return c.class == "Conky" end)()
        return conky or default
    end

    function raise_conky()
        get_conky({***REMOVED***).ontop = true
    end

    function lower_conky()
        get_conky({***REMOVED***).ontop = false
    end

    --local t = gears.timer()
    --t:connect_signal("timeout", function()
    --    t:stop()
    --    lower_conky()
    --end)
    --function lower_conky_delayed()
    --    t:again()
    --end

    function toggle_conky()
        local conky = get_conky({***REMOVED***)
        conky.ontop = not conky.ontop
    end
end


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = {***REMOVED***,
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons***REMOVED******REMOVED***,
    { rule = { class = "MPlayer"***REMOVED***,
      properties = { floating = true***REMOVED******REMOVED***,
    { rule = { class = "pinentry"***REMOVED***,
      properties = { floating = true***REMOVED******REMOVED***,
    { rule = { class = "gimp"***REMOVED***,
      properties = { floating = true***REMOVED******REMOVED***,
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox"***REMOVED***,
    --   properties = { tag = tags[1][2]***REMOVED******REMOVED***,
***REMOVED***
--***REMOVED******REMOVED******REMOVED***

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({***REMOVED***, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({***REMOVED***, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
--***REMOVED******REMOVED******REMOVED***
--

os.execute("/usr/bin/xrdb -merge /home/aidan/.Xresources")
os.execute("/usr/bin/setxkbmap -option ctrl:nocaps")
os.execute("/home/aidan/.startup")
