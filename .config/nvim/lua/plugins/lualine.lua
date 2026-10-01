return {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
        -- Show only the filename instead of the full path
        opts.sections.lualine_c[4] = {
            "filename",
            path = 0,
        }

        -- 12-hour clock
        opts.sections.lualine_z = {
            function()
                -- (e.g., 02:30 PM)
                return " " .. os.date("%I:%M %p")
            end,
        }
    end,
}
