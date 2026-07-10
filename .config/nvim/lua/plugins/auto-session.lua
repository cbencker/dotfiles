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
      -- TODO: Make these more like the snacks dashboard with <leader>q
      { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
      { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
      { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    },
  },
}
