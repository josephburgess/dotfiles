return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = { enabled = false },
      ts_ls = { enabled = false },
      vtsls = {
        enabled = true,
        root_dir = function(fname)
          return require("lspconfig.util").find_git_ancestor(fname)
            or require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
            or vim.fn.getcwd() -- Fallback to current working directory
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
