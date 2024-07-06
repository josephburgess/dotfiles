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

      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        float = {
          source = "always",
          border = "rounded",
        },
      })

      -- opts.servers.pylsp = {
      --   settings = {
      --     pylsp = {
      --       configurationSources = { "pycodestyle" },
      --       plugins = {
      --         pycodestyle = {
      --           ignore = { "E3", "I", "W291" },
      --           maxLineLength = 120,
      --         },
      --         pyflakes = { enabled = false },
      --       },
      --     },
      --   },
      -- }

      opts.servers.pyright = {
        settings = {
          python = {
            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "off",
            },
          },
        },
      }

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

      vim.schedule(function()
        vim.cmd("LspStart")
      end)
    end,
  },
  { "stevanmilic/nvim-lspimport" },
}
