-- #############################################################################
-- ###################                STYLE                  ###################
-- #############################################################################

hl.config({
    -- General Layout & Borders
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 1,

        ["col.active_border"] = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
        ["col.inactive_border"] = "rgba(ffffff10)",

        resize_on_border = true,
        allow_tearing = true,
        layout = "dwindle",
    },

    -- Window Aesthetic Decorations
    decoration = {
        rounding = 8,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.92,

        shadow = {
            enabled = true,
            range = 12,
            render_power = 2,
            color = "rgba(0000001a)",
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            vibrancy = 0.2,
            new_optimizations = true,
            xray = false,
        },
    },

    -- Window & Workspace Animations
    animations = {
        enabled = true,

        beziers = {
            { "snappy",   0.25, 1,    0.5,  1    },
            { "smooth",   0.45, 0.05, 0.55, 1    },
            { "linear",   0,    0,    1,    1    },
            { "overshoot",0.34, 1.26, 0.64, 1    },
            { "quick",    0.15, 0,    0.1,  1    },
        },

        animation = {
            { "global",        1,  4,    "snappy"   },
            { "border",        1,  2,    "snappy"   },
            { "windows",       1,  2,    "snappy"   },
            { "windowsIn",     1,  2,    "overshoot", "popin 80%" },
            { "windowsOut",    1,  0.8,  "quick",     "popin 80%" },
            { "fadeIn",        1,  1.5,  "smooth"   },
            { "fadeOut",       1,  0.8,  "quick"    },
            { "fade",          1,  1.5,  "smooth"   },
            { "layers",        1,  2,    "snappy"   },
            { "layersIn",      1,  2,    "snappy",    "fade" },
            { "layersOut",     1,  0.8,  "quick",     "fade" },
            { "fadeLayersIn",  1,  1.5,  "smooth"   },
            { "fadeLayersOut", 1,  0.8,  "quick"    },
            { "workspaces",    1,  1.8,  "snappy"   },
        },

    },
})
