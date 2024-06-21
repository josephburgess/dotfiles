return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "b0o/SchemaStore.nvim", version = false },
			{ "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
			"hrsh7th/nvim-cmp",
		},
		opts = {
			servers = {}, -- Keep this as is or with specific configurations
		},
		config = function(_, opts)
			-- Setup LSP and diagnostics configuration
			require("utils.diagnostics").setup_diagnostics()

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(cmp_capabilities),
				}, opts.servers[server] or {})

				require("lspconfig")[server].setup(server_opts)
			end

			local mason_lspconfig = require("mason-lspconfig")
			local all_mason_servers = vim.tbl_keys(mason_lspconfig.get_installed_servers())

			for server, server_opts in pairs(opts.servers) do
				if not vim.tbl_contains(all_mason_servers, server) then
					setup(server)
				else
					mason_lspconfig.setup({ ensure_installed = { server }, handlers = { setup } })
				end
			end

			require("config.keymaps").setup_lsp_keymaps()

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
				callback = function(event)
					require("config.keymaps").setup_lsp_autocmd_keymaps(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})
		end,
	},
}
