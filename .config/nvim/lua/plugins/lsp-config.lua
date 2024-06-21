return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = function(_, opts)
      -- Ensure opts is initialized if not provided
      opts = opts or {}
      opts.servers = opts.servers or {}
      opts.autoformat = opts.autoformat or {}
      opts.autoformat = false
      -- Configure pylsp server

      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        virtual_text = false, -- Disable inline virtual text
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        float = {
          source = "always",
          border = "rounded",
        },
      })

      opts.servers.pylsp = {
        settings = {
          pylsp = {
            configurationSources = { "pycodestyle" },
            plugins = {
              pycodestyle = {
                ignore = { "E3", "I", "W291" },
                maxLineLength = 120,
              },
              pyflakes = { enabled = false },
            },
          },
        },
      }

      -- Configure pyright server
      opts.servers.pyright = {
        settings = {
          pyright = {
            disableLanguageServices = false,
            disableOrganizeImports = false,
            disableTaggedHints = false,
          },
          python = {
            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "off",
              useLibraryCodeForTypes = true,
              diagnosticSeverityOverrides = {
                reportMissingModuleSource = "warning",
                reportMissingImports = "warning",
                reportUndefinedVariable = "none",
                reportIncompatibleMethodOverride = false,
                reportIncompatibleVariableOverride = false,
              },
            },
          },
        },
      }

      -- Configure ruff_lsp server
      opts.servers.ruff_lsp = {
        on_attach = function(client, _)
          client.server_capabilities.hoverProvider = false
        end,
        init_options = {
          settings = {},
        },
      }

      -- Setup autocommands for floating diagnostics
      vim.o.updatetime = 250
      vim.api.nvim_create_autocmd("CursorHold", {
        group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          }
          vim.diagnostic.open_float(nil, opts)
        end,
      })

      -- Schedule LspStart command to run
      vim.schedule(function()
        vim.cmd("LspStart")
      end)
    end,
  },
  { "stevanmilic/nvim-lspimport" },
}
