return {
    {
        "nvim-mini/mini.surround",
        version = false,
        opts = {
            mappings = {
                add = "gsa", -- Add surrounding in Normal and Visual modes
                delete = "gsd", -- Delete surrounding
                find = "gsf", -- Find surrounding (to the right)
                find_left = "gsF", -- Find surrounding (to the left)
                highlight = "gsh", -- Highlight surrounding
                replace = "gsr", -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)

            require("which-key").add({
                { "gs", group = "surround" },
            })
        end,
    },
    {
        "nvim-mini/mini.trailspace",
        event = "VeryLazy",
        config = function()
            require("mini.trailspace").setup()
        end,
    },
}
