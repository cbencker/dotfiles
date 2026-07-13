return {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
        -- Look for the section where the clock is located (typically lualine_z)
        -- and override the clock function with your custom format.
        opts.sections.lualine_z = {
            function()
                -- 12-hour format (e.g., 2:30 PM)
                return " " .. os.date("%I:%M %p")
            end,
        }
    end,
}
