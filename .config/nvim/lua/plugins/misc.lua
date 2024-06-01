return {
    "tpope/vim-sleuth",
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup({})
			require('keymaps')
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme github_dark_high_contrast")
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"numToStr/FTerm.nvim",
		config = function()
			require("FTerm").setup({
				dimensions = {
					height = 0.8,
					width = 0.8,
					x = 0.5,
					y = 0.5,
				},
				border = "double",
			})
		end,
	},
}
