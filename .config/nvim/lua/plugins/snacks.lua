return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 10, total = 100 },
        easing = "linear",
      },
    },
    picker = {
      -- Show hidden files in file search pickers
      hidden = true,
    },
    explorer = {
      files = {
        -- Show hidden files by default in the explorer
        hidden = true,
      },
    },
  },
}
