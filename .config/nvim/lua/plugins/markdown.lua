return {
    -- Disable Markdown linting
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                markdown = {},
            },
        },
    },
    -- Enable md-table-tidy.nvim
    {
        "timantipov/md-table-tidy.nvim",
        opts = {
            padding = 1,
            keymap = {
                table_tidy = "<leader>tt",
                table_tidy_all = "<leader>ta",
            },
        },
    },
}

-- Render-markdown.nvim is used for markdown rendering, but LazyVim ships
-- different (more toned down) defaults. Enabling it below with plugin
-- defaults will make things more visually busy.
--return {
--  {
--    "MeanderingProgrammer/render-markdown.nvim",
--    ft = { "markdown" },
--    dependencies = {
--      "nvim-treesitter/nvim-treesitter",
--      --"nvim-web-devicons",
--    },
--    opts = {},
--  },
--}
