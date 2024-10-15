return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function(_, opts)
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					if vim.g.auto_format then
						require("conform").format({
							bufnr = args.buf,
							timeout_ms = 5000,
							lsp_fallback = true,
						})
					else
					end
				end,
			})

			vim.g.auto_format = true

			-- Auto-formatting disabled, so that it can instead be handled by the autocmd. To enable, uncomment the below.
			-- opts.format_on_save = {
			--   -- These options will be passed to conform.format()
			--   timeout_ms = 500,
			--   lsp_fallback = true,
			-- }
			require("conform").setup(opts)
			require("config.keymaps").setup_conform_keymaps()
		end,
	},
}
