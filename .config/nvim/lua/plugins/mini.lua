return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.move").setup()
    require("mini.test").setup()
  end,
}
