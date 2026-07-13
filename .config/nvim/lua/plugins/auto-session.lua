return {
    {
        "folke/persistence.nvim",
        enabled = false,
    },
    {
        "rmagatti/auto-session",
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { "~/", "/", "~/Downloads" },
            bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
            -- log_level = 'debug',
        },
        keys = {
            -- Will use Telescope if installed or a vim.ui.select picker otherwise
            -- TODO: Set up custom icons for these
            { "<leader>qd", "<cmd>AutoSession disable<CR>", desc = "Session disable autosave" },
            { "<leader>qh", "<cmd>AutoSession restore Home<CR>", desc = "Session home" },
            { "<leader>ql", "<cmd>AutoSession search<CR>", desc = "Session load" },
            { "<leader>qt", "<cmd>AutoSession toggle<CR>", desc = "Session toggle autosave" },
        },
    },
}
