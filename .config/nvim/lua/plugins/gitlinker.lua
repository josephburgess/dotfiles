return {
  "ruifm/gitlinker.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("gitlinker").setup()
  end,
}
