return {

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },

  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure opts is initialized if not provided
      opts = opts or {}
      opts.servers = opts.servers or {}
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

      opts.servers.basedpyright = {}
      -- opts.servers.pyright = {
      --   capabilities = vim.lsp.protocol.make_client_capabilities(),
      --   on_attach = function(client, bufnr)
      --     client.server_capabilities.documentFormattingProvider = false
      --     client.server_capabilities.documentRangeFormattingProvider = false
      --     client.server_capabilities.definitionProvider = false
      --     client.server_capabilities.typeDefinitionProvider = false
      --     client.server_capabilities.renameProvider = false
      --   end,
      -- }

      opts.servers.jedi_language_server = {
        cmd = { "jedi-language-server" },
        filetypes = { "python" },
        root_dir = vim.loop.cwd,
        settings = {
          jedi = {
            startupTimeout = 5000,
            completion = { disableSnippets = false },
            diagnostics = {
              enable = true,
              didOpen = true,
              didChange = true,
              didSave = true,
            },
            hover = { enable = true },
            jediSettings = {
              autoImportModules = {},
              caseInsensitiveCompletion = true,
              debug = false,
            },
            workspace = {
              extraPaths = {},
              environmentPath = vim.fn.expand("~/.virtualenvs/neovim/bin/python"),
              symbols = {
                ignoreFolders = { ".nox", ".tox", ".venv", "__pycache__", "venv" },
                maxSymbols = 20,
              },
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
}
