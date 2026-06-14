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

-- Nicer Markdown renderer
-- (but more visually busy)
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
