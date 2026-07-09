-- #############
-- ### RULES ###
-- #############

hl.window_rule({
    name = "pwvucontrol-float",
    match = {
        class = "com.saivert.pwvucontrol"
    },
    float = true,
    size = { 400, 600 }
})

hl.window_rule({
    name = "blueman-float",
    match = {
        class = "blueman-manager"
    },
    float = true,
    size = { 400, 600 }
})

hl.window_rule({
    name = "nm-editor-float",
    match = {
        class = "nm-connection-editor"
    },
    float = true,
    size = { 400, 600 }
})

for i = 1, 5 do
    hl.workspace_rule({
        workspace = tostring(i),
        persistent = true,
    })
end
