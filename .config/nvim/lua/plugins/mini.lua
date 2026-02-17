return {
  "nvim-mini/mini.icons",
  config = function()
    require("mini.move").setup()
    require("mini.test").setup()
  end,
}
