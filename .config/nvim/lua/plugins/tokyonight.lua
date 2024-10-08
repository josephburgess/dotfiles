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
        -- JavaScript and TypeScript parameters in yellow
        hl["@variable.javascript"] = { fg = c.fg } -- Default color
        hl["@variable.parameter.javascript"] = { fg = c.yellow, italic = true } -- Parameters in yellow
        hl["@variable.builtin.javascript"] = { fg = c.red, italic = true } -- Built-ins in red italic

        hl["@lsp.type.parameter.javascript"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style
        hl["@lsp.typemod.parameter.definition.javascript"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style

        -- JavaScript React parameters in yellow
        hl["@variable.javascriptreact"] = { fg = c.fg } -- Default color
        hl["@variable.parameter.javascriptreact"] = { fg = c.yellow, italic = true } -- Parameters in yellow
        hl["@variable.builtin.javascriptreact"] = { fg = c.red, italic = true } -- Built-ins in red italic

        hl["@lsp.type.parameter.javascriptreact"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style
        hl["@lsp.typemod.parameter.definition.javascriptreact"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style

        -- TypeScript parameters in yellow
        hl["@variable.typescript"] = { fg = c.fg } -- Default color
        hl["@variable.parameter.typescript"] = { fg = c.yellow, italic = true } -- Parameters in yellow
        hl["@variable.builtin.typescript"] = { fg = c.red, italic = true } -- Built-ins in red italic

        hl["@lsp.type.parameter.typescript"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style
        hl["@lsp.typemod.parameter.definition.typescript"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style

        -- TypeScript React parameters in yellow
        hl["@variable.typescriptreact"] = { fg = c.fg } -- Default color
        hl["@variable.parameter.typescriptreact"] = { fg = c.yellow, italic = true } -- Parameters in yellow
        hl["@variable.builtin.typescriptreact"] = { fg = c.red, italic = true } -- Built-ins in red italic

        hl["@lsp.type.parameter.typescriptreact"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style
        hl["@lsp.typemod.parameter.definition.typescriptreact"] = { fg = c.yellow, italic = true } -- Match Tree-sitter style
      end,
    },
  },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "tokyonight-moon",
  --   },
  -- },
}
