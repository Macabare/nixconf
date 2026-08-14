-- Ignore maximize requests from all apps
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "pip-window",
    match = { title = "^(Picture-in-Picture)$" },

    float    = true,
    pin      = true,
    no_shadow = true,
    size     = {600, 340},
    move     = {"100%-w-20", "100%-h-20"},
    no_initial_focus = true,
})

-- Satty (screenshot annotation)
hl.window_rule({
    name  = "satty-float",
    match = { class = "^(com\\.gabm\\.satty)$" },

    float  = true,
    center = true,
})

hl.window_rule({match = {title = "^(Open File)(.*)$" },                      center = true})
hl.window_rule({match = {title = "^(Open File)(.*)$" },                      float = true})
hl.window_rule({match = {title = "^(Open Folder)(.*)$" },                    center = true})
hl.window_rule({match = {title = "^(Open Folder)(.*)$" },                    float = true})
hl.window_rule({match = {title = "^(Save As)(.*)$" },                        center = true})
hl.window_rule({match = {title = "^(Save As)(.*)$" },                        float = true})

hl.window_rule({
    match = { class = "com.mitchellh.ghostty" },
    opacity = "0.9 override 0.9 override 1.0 override",
})

hl.window_rule({
    match = { class = "codium" },
    opacity = "0.9 override 0.9 override 1.0 override",
})