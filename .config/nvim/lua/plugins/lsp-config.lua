return {
  { "folke/neoconf.nvim", opts = {} },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure opts is initialized if not provided
      opts = opts or {}
      opts.servers = opts.servers or {}
      opts.autoformat = false

      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
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
      --       configurationSources = { "flake8" },
      --       plugins = {
      --         pycodestyle = { enabled = false },
      --         mccabe = { enabled = false },
      --         pyflakes = { enabled = false },
      --         flake8 = { enabled = true, maxLineLength = 120 },
      --       },
      --     },
      --   },
      -- }

      opts.servers.zls = {}
      opts.servers.basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      }
      opts.inlay_hints = { enabled = false }

      vim.api.nvim_create_autocmd("CursorHold", {
        group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
        callback = function()
          local options = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          }
          vim.diagnostic.open_float(nil, options)
        end,
      })

      vim.schedule(function()
        vim.cmd("LspStart")
      end)
    end,
  },
}
