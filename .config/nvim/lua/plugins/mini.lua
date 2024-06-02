return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup({
			mappings = {
				add = "sa",
				delete = "sd",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				replace = "sr",
				update_n_lines = "sn",
				suffix_last = "l",
				suffix_next = "n",
			},
		})
		require("mini.indentscope").setup({
			symbol = "» ",
		})
		require("mini.basics").setup()
		require("mini.bracketed").setup()
		require("mini.files").setup({
			mappings = {
				close = "\\",
			},
		})
		-- require("mini.jump").setup()
		require("mini.move").setup()
		require("mini.notify").setup()
		require("mini.map").setup()
		require("mini.clue").setup()
		local map = require("mini.map")
		map.setup({
			integrations = {
				map.gen_integration.builtin_search(),
				map.gen_integration.gitsigns({
					add = "GitSignsAdd",
					change = "GitSignsChange",
					delete = "GitSignsDelete",
				}),
				map.gen_integration.diagnostic({
					error = "DiagnosticFloatingError",
					warn = "DiagnosticFloatingWarn",
					info = "DiagnosticFloatingInfo",
					hint = "DiagnosticFloatingHint",
				}),
			},
			symbols = {
				encode = map.gen_encode_symbols.dot("4x2"),
				scroll_line = "➽",
				scroll_view = "┃",
			},
			window = {
				side = "right", -- Side to stick ('left' or 'right')
				width = 17, -- Total width
				winblend = 25, -- Value of 'winblend' option
				focusable = true, -- Whether window is focusable in normal way (with `wincmd` or mouse)
				show_integration_count = false, -- Whether to show count of multiple integration highlights
			},
		})
	end,
}
