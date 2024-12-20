-- Fix conceallevel for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("markdown_conceal", { clear = true }),
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})

-- Function to toggle wrapping
local function toggle_wrap()
	if vim.wo.wrap then
		vim.wo.wrap = false
		print("Word wrap disabled")
	else
		vim.wo.wrap = true
		print("Word wrap enabled")
	end
end

-- Create a command to toggle wrapping
vim.api.nvim_create_user_command("ToggleWrap", toggle_wrap, {})

return {
	{
		"stevearc/conform.nvim",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "prettier", "mdformat" })
				end,
			},
		},
		ft = { "markdown" },
		opts = {
			formatters_by_ft = {
				markdown = { "prettier" },
			},
			formatters = {
				prettier = {
					-- https://prettier.io/docs/en/options.html
					prepend_args = { "--prose-wrap", "never" },
				},
				mdformat = {
					-- https://github.com/einride/sage/blob/master/tools/sgmdformat/tools.go
					prepend_args = { "--number", "--wrap", "no" },
				},
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "markdownlint" })
				end,
			},
		},
		ft = { "markdown" },
		opts = {
			linters_by_ft = {
				markdown = { "markdownlint" },
			},
		},
	},
}
