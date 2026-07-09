package.path = package.path .. ";/home/dalmatheo/dotfiles/.config/hypr/split-monitor-workspaces/lua/?.lua"
local smw = require("split-monitor-workspaces")

smw.setup({
    workspace_count = 5,
    keep_focused = true,
    enable_persistent_workspaces = true,
})
