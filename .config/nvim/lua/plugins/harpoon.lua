return {
	{
		"ThePrimeagen/harpoon",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup({
				global_settings = {
					save_on_toggle = false,
					save_on_change = true,
					enter_on_sendcmd = false,
					tmux_autoclose_windows = false,
					excluded_filetypes = { "harpoon" },
					mark_branch = false,
					tabline = false,
					tabline_prefix = "   ",
					tabline_suffix = "   ",
				},
				menu = {
					width = vim.api.nvim_win_get_width(0) - 4,
				},
			})
			vim.keymap.set(
				"n",
				"<leader>ga",
				require("harpoon.mark").add_file,
				{ silent = true, desc = "Add File to Harpoon" }
			)
			vim.keymap.set(
				"n",
				"<leader>gm",
				require("harpoon.ui").toggle_quick_menu,
				{ silent = true, desc = "Toggle Harpoon Menu" }
			)
			vim.keymap.set(
				"n",
				"<leader>gn",
				require("harpoon.ui").nav_next,
				{ silent = true, desc = "Next Harpoon Mark" }
			)
			vim.keymap.set(
				"n",
				"<leader>gp",
				require("harpoon.ui").nav_prev,
				{ silent = true, desc = "Previous Harpoon Mark" }
			)
			vim.keymap.set("n", "<leader>g1", function()
				require("harpoon.ui").nav_file(1)
			end, { silent = true, desc = "Go to Mark 1" })
			vim.keymap.set("n", "<leader>g2", function()
				require("harpoon.ui").nav_file(2)
			end, { silent = true, desc = "Go to Mark 2" })
			vim.keymap.set("n", "<leader>g3", function()
				require("harpoon.ui").nav_file(3)
			end, { silent = true, desc = "Go to Mark 3" })
			vim.keymap.set("n", "<leader>g4", function()
				require("harpoon.ui").nav_file(4)
			end, { silent = true, desc = "Go to Mark 4" })
		end,
	},
}

