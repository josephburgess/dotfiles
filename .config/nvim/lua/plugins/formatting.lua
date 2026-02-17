-- ---------------------------------------------------------------------------
-- formatting: conform.nvim
-- js/ts/json uses biome in cerebro (work proj) prettier elsewhere
-- ---------------------------------------------------------------------------
local function js_formatter()
	return vim.fn.getcwd():match("Funnel/cerebro") and { "biome" } or { "prettier" }
end

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufReadPost" },
	keys = {
		{
			"cf",
			function()
				require("conform").format({
					range = {
						start = vim.api.nvim_buf_get_mark(0, "<"),
						["end"] = vim.api.nvim_buf_get_mark(0, ">"),
					},
				})
			end,
			mode = "v",
			desc = "Format selection",
		},
		{
			"cF",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			javascript = js_formatter,
			typescript = js_formatter,
			javascriptreact = js_formatter,
			typescriptreact = js_formatter,
			json = js_formatter,
			jsonc = js_formatter,
			css = { "prettier" },
			html = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			graphql = { "prettier" },
			svelte = { "prettier" },
			lua = { "stylua" },
			python = { "autopep8" },
			["*"] = { "trim_whitespace" },
		},
	},
}
