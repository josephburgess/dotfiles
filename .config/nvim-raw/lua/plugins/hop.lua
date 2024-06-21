return {
	"smoka7/hop.nvim",
	opts = {
		multi_windows = true,
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function(_, opts)
		local hop = require("hop")
		hop.setup(opts)

		local directions = require("hop.hint").HintDirection
		vim.keymap.set("", "f", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR })
		end, { remap = true })
		vim.keymap.set("", "F", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR })
		end, { remap = true })
		vim.keymap.set("", "t", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
		end, { remap = true })
		vim.keymap.set("", "T", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
		end, { remap = true })
	end,
}
