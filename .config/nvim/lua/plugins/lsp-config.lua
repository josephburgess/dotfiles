return {
  -- Neoconf for project-specific LSP settings
  {
    "folke/neoconf.nvim",
    opts = {},
  },

  -- Lazydev for Lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "LazyVim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Main LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Disable autoformatting (you have conform.nvim for that)
      autoformat = false,

      -- Diagnostic configuration
      diagnostics = {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = "always",
          border = "rounded",
        },
      },

      -- Disable inlay hints (re-enable if you want them)
      inlay_hints = {
        enabled = false,
      },

      -- LSP Server configurations
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = true,
              },
            },
            python = {
              venvPath = vim.fn.expand(
                "~/.pyenv/versions/" .. vim.fn.system("pyenv version-name"):gsub("\n", "") .. "/envs"
              ),
              venv = vim.fn.system("pyenv version-name"):gsub("\n", ""),
            },
          },
        },

        -- ESLint: disabled for cerebro repo
        eslint = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            local root = util.root_pattern(
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.json",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts",
              "eslint.config.mts",
              "eslint.config.cts",
              "package.json"
            )(fname)

            -- Disable ESLint in cerebro repo
            if root and string.match(root, "Funnel/cerebro") then
              return nil
            end

            return root
          end,
        },

        -- TypeScript/JavaScript: vtsls
        vtsls = {
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },

        -- Lua: lua_ls (for Neovim config)
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },

        -- JSON with schema support
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        -- YAML with schema support
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        -- Tailwind CSS
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        },

        -- Biome (alternative to ESLint/Prettier)
        biome = {},
      },

      -- Setup handlers for servers
      setup = {
        -- Custom setup for eslint to conditionally disable in certain repos
        eslint = function()
          -- Use vim.api.nvim_create_autocmd instead of Snacks.util.lsp
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if not client then
                return
              end

              if client.name == "eslint" then
                client.server_capabilities.documentFormattingProvider = true
              elseif client.name == "tsserver" or client.name == "vtsls" then
                client.server_capabilities.documentFormattingProvider = false
              end
            end,
          })
        end,
      },
    },
  },

  -- Mason: LSP installer
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- TypeScript/JavaScript
        "vtsls",
        "eslint-lsp",
        "biome",

        -- Python
        "basedpyright",
        "ruff",

        -- Lua
        "lua-language-server",

        -- JSON/YAML
        "json-lsp",
        "yaml-language-server",

        -- CSS/Tailwind
        "tailwindcss-language-server",
        "css-lsp",
      },
    },
  },
}
