return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.move").setup()
    require("mini.map").setup()
    local map = require("mini.map")
    map.setup({
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns({
          add = "GitSignsAdd",
          change = "GitSignsChange",
          delete = "GitSignsDelete",
        }),
        map.gen_integration.diagnostic({
          error = "DiagnosticFloatingError",
          warn = "DiagnosticFloatingWarn",
          info = "DiagnosticFloatingInfo",
          hint = "DiagnosticFloatingHint",
        }),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("4x2"),
        scroll_line = "➽",
        scroll_view = "┃",
      },
      window = {
        side = "right", -- Side to stick ('left' or 'right')
        width = 10, -- Total width
        winblend = 15, -- Value of 'winblend' option
        focusable = true, -- Whether window is focusable in normal way (with `wincmd` or mouse)
        show_integration_count = false, -- Whether to show count of multiple integration highlights
      },
    })
  end,
}
