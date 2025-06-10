return {
  { "folke/neoconf.nvim", opts = {} },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- Only load on Lua files
    opts = {
      library = {
        -- Include LazyVim types
        "LazyVim",
        -- Include Neovim runtime files for proper API completion
        vim.env.VIMRUNTIME,
        vim.fn.stdpath("config"),
        vim.fn.stdpath("data") .. "/site/pack/packer/start/",
      },
      enabled = function(root_dir)
        -- Disable if a `.luarc.json` is present
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      opts.servers = opts.servers or {}
      opts.autoformat = false

      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
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
      opts.servers.lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
            diagnostics = {
              globals = { "vim" },
              disable = {
                "lowercase-global",
                "undefined-field",
                "undefined-global",
                "assign-type-mismatch",
                "missing-fields",
              },
            },
          },
        },
      }

      opts.inlay_hints = { enabled = false }

      -- Ensure LSP starts
      vim.schedule(function()
        vim.cmd("LspStart")
      end)
    end,
  },
}
