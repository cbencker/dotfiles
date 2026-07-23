-- Disable Markdown linting
return {
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                markdown = {},
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
