return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = { enabled = false },
      ts_ls = { enabled = false },
      vtsls = {
        enabled = true,
        root_dir = function(fname)
          local util = require("lspconfig.util")
          local root = util.root_pattern("jsconfig.json", "tsconfig.json", "package.json")(fname)
          return root or util.find_git_ancestor(fname) or vim.fn.getcwd()
        end,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      },
    },
  },
}
