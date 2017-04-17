---------------------------------------------------------------------------
--- TMUX hotkeys for awful.hotkeys_widget
--
-- @author Yauheni Kirylau &lt;yawghen@gmail.com&gt;
-- @copyright 2014-2015 Yauheni Kirylau
-- @module awful.hotkeys_popup.keys.tmux
---------------------------------------------------------------------------

local hotkeys_popup = require("awful.hotkeys_popup.widget")

local tmux_rule_any = {name={"tmux", "TMUX"}}
for group_name, group_data in pairs({
    ["TMUX: sessions"] =             { color="#009F00", rule_any=tmux_rule_any },
    ["TMUX: windows"] =            { color="#aFaF00", rule_any=tmux_rule_any },
    ["TMUX: panes"] =   { color="#cF4F40", rule_any=tmux_rule_any },
    ["TMUX: copy mode"] =           { color="#aF6F00", rule_any=tmux_rule_any },
    ["TMUX: misc"] =               { color="#65cF9F", rule_any=tmux_rule_any },
    ["TMUX: help"] =             { color="#659FdF", rule_any=tmux_rule_any },
}) do
    hotkeys_popup.group_rules[group_name] = group_data
end

local tmux_leader_key = 'b'
local tmux_leader = tmux_leader_key .. '+'

local tmux_keys = {

    ["TMUX: sessions"] = {{
        modifiers = {},
        keys = {
            [':new [-s session-name]']="start a new session",
        }
    }, {
        modifiers = {"Ctrl"},
        keys = {
            [tmux_leader .. '$']="rename session",
            [tmux_leader .. 'd']='detatch from session',
            [tmux_leader .. 's']='show all sessions',
            [tmux_leader .. '(']='move to previous session',
            [tmux_leader .. ')']='move to next session',
        }
    }},

    ["TMUX: windows"] = {{
        modifiers = {"Ctrl"},
        keys = {
            [tmux_leader .. 'c']="create window",
            [tmux_leader .. ',']='rename current window',
            [tmux_leader .. '&amp;']='close current window',
            [tmux_leader .. 'p']='previous window',
            [tmux_leader .. 'n']='next window',
            [tmux_leader .. '0...9']='switch / select window be number',
      }
    }},

    ["TMUX: panes"] = {{
        modifiers = {"Ctrl"},
        keys = {
            [tmux_leader .. ';']="toggle last active pane",
            [tmux_leader .. '%']='split pane vertically',
            [tmux_leader .. '"']='split pane horizontally',
            [tmux_leader .. '{']='move the current pane left',
            [tmux_leader .. '}']='move the current pane right',
            [tmux_leader .. '[↑][↓][→][←]']='switch to pane to the direction',
        }
    }, {
        modifiers = {},
        keys = {
            [':setw syncronize-panes']='Toggle synchronize-panes(send command to all panes)'
        }
    }, {
        modifiers = {"Ctrl"},
        keys = {
            [tmux_leader .. 'Spacebar']="toggle pane layouts",
            [tmux_leader .. 'o']="switch to next pane",
            [tmux_leader .. 'q']="show pane numbers",
            [tmux_leader .. 'q [0...9]']="switch / select pane by number",
            [tmux_leader .. 'z']="toggle pane zoom",
            [tmux_leader .. '!']="convert pane into a window",
            [tmux_leader .. 'x']="close current pane",
       }
    }},

    ["TMUX: Copy Mode"] = {{
        modifiers = {},
        keys = {
            [':setw -g mode-keys vi']='use vi keys in buffer'
        }
    }, {
        modifiers = {"Ctrl"},
        keys = {
            [tmux_leader .. '[']="enter copy mode",
            [tmux_leader .. 'PgUp']="enter copy mode and scroll one page up",
            q="quit mode",
            g="go to top line",
            G='Go to bottom line',
        }
    }, {
        modifiers = {},
        keys = {
          ['↑']='scroll up',
          ['↓']='scroll down',
          h='move cursor left',
          j='move cursor down',
          k='move cursor up',
          l='move cursor right',
          w='move cursor forward one word at a time',
          b='move cursor backward one word at a time',
          ['/']='search forward',
          ['?']='search backward',
          n='next word occurance',
          N='previous keyword occurance',
          ['Spacebar']='start selection',
          ['Esc']='clear selection',
          ['Enter']='copy selection',
        }
    }, {
        modifiers = {"Ctrl"},
        keys = {
          [tmux_leader .. ']']='paste contents of buffer_0'
        }
    }, {
        modifiers = {},
        keys = {
          [':show-buffer']='display buffer_0 contents',
          [':capture-pane']='copy entire visible contents of pane to a buffer',
          [':list-buffers']='show all buffers',
          [':choose-buffer']='show all buffers and paste selected',
          [':save-buffer [filename]']='save buffer contents to file',
          [':delete-buffer [-b 1]']='delete buffer_1',
        }
    }},

    ["TMUX: misc"] = {{
        modifiers = {"Ctrl"},
        keys = {
            [tmux_leader .. ':']='enter command mode',
        }
    }, {
        modifiers = {},
        keys = {
            [':set -g [OPTION]']='set [OPTION] for all sessions',
            [':setw -g [OPTION]']='set [OPTION] for all windows'
        }
    }},

    ["TMUX: help"] = {{
        modifiers = {"Ctrl"},
        keys = {
            [tmux_leader .. '?']="show shortcuts",
        }
    },{
        modifiers = {},
        keys = {
            ['tmux info']="show every session, window, pane, etc",
        }
    }},
}

hotkeys_popup.add_hotkeys(tmux_keys)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
