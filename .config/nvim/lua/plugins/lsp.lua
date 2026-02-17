-- ---------------------------------------------------------------------------
-- lsp: lazydev + nvim-lspconfig + mason
-- ---------------------------------------------------------------------------
return {
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

	{
		"neovim/nvim-lspconfig",
		dependencies = { "b0o/schemastore.nvim" },
		opts = {
			autoformat = false,
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
				float = { source = "always", border = "rounded" },
			},
			inlay_hints = { enabled = false },

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
					},
				},

				vtsls = {
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								completion = { enableServerSideFuzzyMatch = true },
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = { completeFunctionCalls = true },
						},
						javascript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = { completeFunctionCalls = true },
						},
					},
				},

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
						if root and root:match("Funnel/cerebro") then
							return nil
						end
						return root
					end,
				},

				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							codeLens = { enable = true },
							completion = { callSnippet = "Replace" },
							doc = { privateName = { "^_" } },
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

				jsonls = {
					settings = {
						json = {
							schemas = function()
								return require("schemastore").json.schemas()
							end,
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = { enable = false, url = "" },
							schemas = function()
								return require("schemastore").yaml.schemas()
							end,
						},
					},
				},

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
				biome = {},
			},

			setup = {
				eslint = function()
					vim.api.nvim_create_autocmd("LspAttach", {
						callback = function(args)
							local client = vim.lsp.get_client_by_id(args.data.client_id)
							if not client then
								return
							end
							if client.name == "eslint" then
								client.server_capabilities.documentFormattingProvider = true
							elseif client.name == "vtsls" then
								client.server_capabilities.documentFormattingProvider = false
							end
						end,
					})
				end,
			},
		},
	},

	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"vtsls",
				"eslint-lsp",
				"biome",
				"basedpyright",
				"ruff",
				"lua-language-server",
				"json-lsp",
				"yaml-language-server",
				"tailwindcss-language-server",
				"css-lsp",
			},
		},
	},
}
