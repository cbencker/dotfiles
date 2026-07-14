local session = require("config.session")

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
            {
                "<leader>qc",
                function()
                    session.safe_restore("Config")
                end,
                desc = "Session: Config",
            },
            { "<leader>qd", "<cmd>AutoSession disable<CR>", desc = "Session disable autosave" },
            {
                "<leader>qh",
                function()
                    session.safe_restore("Home")
                end,
                desc = "Session: Home",
            },
            {
                "<leader>ql",
                function()
                    session.safe_search()
                end,
                desc = "Session load",
            },
            { "<leader>qt", "<cmd>AutoSession toggle<CR>", desc = "Session toggle autosave" },
        },
    },
}
