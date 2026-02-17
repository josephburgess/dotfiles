return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.nvim",
  },
  ft = { "markdown" }, -- Load only for markdown files
  opts = {
    -- Making sure the plugin is properly initialized
    enabled = true,
    debounce = 150, -- Slightly higher than default to prevent issues
    anti_conceal = {
      enabled = true,
      ignore = {
        code_background = true,
        sign = true,
      },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
  end,
}
