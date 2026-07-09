-- ###################
-- ### KEYBINDINGS ###
-- ###################

local smw = require("split-monitor-workspaces")

local mainMod = "SUPER"

-- Applications

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(apps.fileManager))

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(apps.menu))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | " .. apps.menu .. " --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(apps.locker))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('hyprshot -m region --output-folder "$HOME/Pictures/Screenshots"'))
hl.bind("Print", hl.dsp.exec_cmd('hyprshot -m output --output-folder "$HOME/Pictures/Screenshots"'))

-- Window modifiers

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + RETURN", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.close())

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch workspaces

hl.bind(mainMod .. " + ampersand", smw.workspace("1"))
hl.bind(mainMod .. " + eacute", smw.workspace("2"))
hl.bind(mainMod .. " + quotedbl", smw.workspace("3"))
hl.bind(mainMod .. " + apostrophe", smw.workspace("4"))
hl.bind(mainMod .. " + parenleft", smw.workspace("5"))

-- Move window to workspace
hl.bind(mainMod .. " + SHIFT + ampersand", smw.move_to_workspace("1"))
hl.bind(mainMod .. " + SHIFT + eacute", smw.move_to_workspace("2"))
hl.bind(mainMod .. " + SHIFT + quotedbl", smw.move_to_workspace("3"))
hl.bind(mainMod .. " + SHIFT + apostrophe", smw.move_to_workspace("4"))
hl.bind(mainMod .. " + SHIFT + parenleft", smw.move_to_workspace("5"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
