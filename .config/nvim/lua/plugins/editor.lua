-- ---------------------------------------------------------------------------
-- editor plugins: navigation, git, file management, search, motion
-- ---------------------------------------------------------------------------
return {
	-- kitty/tmux navigator
	{
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	},
	{ "knubie/vim-kitty-navigator", enabled = true },

	-- leap
	{
		"ggandor/leap.nvim",
		enabled = true,
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},

	-- git diffview
	{ "sindrets/diffview.nvim", opts = {} },

	-- gitlinker - copy permlinks
	{
		"ruifm/gitlinker.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {},
	},

	-- oil - file manager
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({ default_file_explorer = false })
		end,
	},

	-- find and replace
	{ "nvim-pack/nvim-spectre" },

	-- copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "BufRead",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = { position = "bottom", ratio = 0.4 },
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = "<M-w>",
						accept_line = "<M-e>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
			})
		end,
	},

	-- live renaming
	{ "smjonas/inc-rename.nvim", cmd = "IncRename", config = true },

	-- undo tree
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { { "<leader>U", "<cmd>lua require('undotree').toggle()<cr>", desc = "Undo Tree" } },
	},

	-- copy dotted ref for python files
	{
		"ranelpadon/python-copy-reference.vim",
		init = function()
			vim.g.python_copy_reference = { remove_prefixes = { "app" } }
		end,
	},

	-- lint
	{
		"mfussenegger/nvim-lint",
		opts = {
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {},
		},
	},

	-- dap for debugging/tests
	{ "mfussenegger/nvim-dap", config = function() end },

	-- Smart splits for kitty
	{ "mrjones2014/smart-splits.nvim", build = "./kitty/install-kittens.bash" },

	-- Kitty scrollback
	{
		"mikesmithgh/kitty-scrollback.nvim",
		lazy = true,
		cmd = {
			"KittyScrollbackGenerateKittens",
			"KittyScrollbackCheckHealth",
			"KittyScrollbackGenerateCommandLineEditing",
		},
		event = { "User KittyScrollbackLaunch" },
		config = function()
			require("kitty-scrollback").setup()
		end,
	},

	-- plenary - misc / dep
	{ "nvim-lua/plenary.nvim" },

	{
		"nvim-mini/mini.move",
		config = function()
			require("mini.move").setup()
		end,
	},
}
