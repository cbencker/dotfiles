return {
  {
    "nvim-mini/mini.trailspace",
    event = "VeryLazy",
    config = function()
      require("mini.trailspace").setup()
    end,
  },
}
