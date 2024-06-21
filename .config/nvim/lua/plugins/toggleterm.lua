return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup()
    vim.keymap.set(
      "n",
      "<leader>td",
      "<cmd>ToggleTerm size=15 direction =horizontal<cr>",
      { desc = "Open Horizontal Terminal" }
    )
  end,
}
