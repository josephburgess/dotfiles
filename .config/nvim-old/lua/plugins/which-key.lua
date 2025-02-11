return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		-- init = function()
		--   vim.o.timeout = true
		--   vim.o.timeoutlen = 300
		-- end,
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300

			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below

			local opts = require("config.keymaps").setup_whichkey()
			require("which-key").register(opts)
		end,
	},
}
