return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      plugins = { auto = true },
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        hl["@variable.python"] = { fg = c.fg } -- Default color
        hl["@variable.parameter.python"] = { fg = c.yellow, italic = true } -- Parameters in yellow italic
        hl["@variable.builtin.python"] = { fg = c.red, italic = true } -- Built-ins in red italic

        hl["@lsp.type.parameter.python"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style
        hl["@lsp.typemod.parameter.definition.python"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
