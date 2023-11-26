data:extend({
    {
        type = "custom-input",
        name = "logistics_requests_sorted-hotkey",
        key_sequence = "",
        action = "lua",
        localised_name = {"logistics_requests_sorted.enabled_name"},
        localised_name = {"logistics_requests_sorted.enabled_desc"},
    },
    {
        type = "shortcut",
        name = "logistics_requests_sorted-enabled",
        action = "lua",
        toggleable = true,
        localised_name = {"logistics_requests_sorted.enabled_name"},
        localised_name = {"logistics_requests_sorted.enabled_desc"},
        icon = {
          filename = "__logistics_requests_sorted__/graphics/shortcut_32.png",
          size = 32,
          scale = 0.5,
          mipmap_count = 2,
          flags = {"gui-icon"},
        },
        disabled_icon = {
            filename = "__logistics_requests_sorted__/graphics/shortcut_32_white.png",
            size = 32,
            scale = 0.5,
            mipmap_count = 2,
            flags = {"gui-icon"},
        },
    },
})