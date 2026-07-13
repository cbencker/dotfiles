return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- opts = {
  --   icons = {
  --     rules = {
  --       { pattern = "Session disable autosave", icon = "󱙃 " },
  --       { pattern = "Session home", icon = " " },
  --       { pattern = "Session load", icon = " " },
  --       { pattern = "Session toggle autosave", icon = "󱑛 " },
  --     },
  --   },
  -- },
  -- TODO: These don't currently work
  opts = function(_, opts)
    opts.icons = opts.icons or {}
    opts.icons.rules = opts.icons.rules or {}

    local rules = {
      { pattern = "Session disable autosave", icon = "󱙃 " },
      { pattern = "Session home", icon = " " },
      { pattern = "Session load", icon = " " },
      { pattern = "Session toggle autosave", icon = "󱑛 " },
    }

    for i = #rules, 1, -1 do
      table.insert(opts.icons.rules, 1, rules[i])
    end
  end,
}
