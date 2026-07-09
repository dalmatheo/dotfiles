-- #############
-- ### INPUT ###
-- #############

hl.config({
    input = {
        kb_layout = "fr",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        
        numlock_by_default = true,
        follow_mouse = 2,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({
    name = "corne-keyboard",
    kb_layout = "us_qwerty-fr",
})
