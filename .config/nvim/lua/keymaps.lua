local wk = require("which-key")

wk.register({
	["<leader>c"] = { name = "[C]ode" },
	["<leader>d"] = { name = "[D]ocument" },
	["<leader>r"] = { name = "[R]ename" },
	["<leader>s"] = { name = "[S]earch" },
	["<leader>w"] = { name = "[W]orkspace" },
	["<leader>t"] = { name = "[T]oggle" },
	["<leader>h"] = { name = "Git [H]unk" },
	["<leader>g"] = { name = "To[G]gle comments" },
	["<leader>p"] = { name = "Har[P]oon" },
	["<leader>o"] = { name = "[O]il" },
	["<leader>gb"] = "Togggle block comment",
	["<leader>gbc"] = "Toggle block comment",
	["<leader>gc"] = "Toggle line comment",
	["<leader>gcc"] = "Toggle line comment",
	["<leader>gco"] = "Comment next line",
	["<leader>gcO"] = "Comment prev line",
	["<leader>gcA"] = "Comment end of line",
	["<leader>g>"] = "Comment region",
	["<leader>g>c"] = "Add line comment",
	["<leader>g>b"] = "Add block comment",
	["<leader>g<lt>"] = "Uncomment region",
	["<leader>g<lt>c"] = "Remove line comment",
	["<leader>g<lt>b"] = "Remove block comment",
}, { mode = "n" })

wk.register({
	["gb"] = "Togggle block comment",
	["gc"] = "Toggle line comment",
}, { mode = "x" })

wk.register({
	["g>"] = "Comment region",
	["g<lt>"] = "Uncomment region",
}, { mode = "x" })

wk.register({
	["<leader>h"] = { "Git [H]unk" },
}, { mode = "v" })

-- Helper function for keymaps
local function Map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- General keymaps
Map("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
Map("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })
Map("n", "<Esc>", "<cmd>nohlsearch<CR>")
Map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
Map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
Map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
Map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
Map("n", "<leader>tt", '<CMD>lua require("FTerm").toggle()<CR>')
Map("t", "<Esc><Esc>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
Map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
Map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
Map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
Map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
Map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
Map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
Map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
Map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
Map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
Map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
Map("n", "<S-Enter>", "O<Esc>", { desc = "Insert newline above" })
Map("n", "<CR>", "o<Esc>", { desc = "Insert newline below" })
Map("n", "<leader>p", '"_dP', { desc = "Paste without yanking" })
Map("i", "<M-BS>", "<Esc>cvb")
Map("n", "<leader>oi", function()
	require("oil").open()
end, { desc = "Oil current dir" })
Map("n", "<leader>of", function()
	require("oil").open_float(".")
end, { desc = "Oil floating window" })
Map("v", "<", "<gv")
Map("v", ">", ">gv")
Map("n", "\\", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open MiniFiles" })
Map("n", "<Leader>mc", MiniMap.close)
Map("n", "<Leader>mf", MiniMap.toggle_focus)
Map("n", "<Leader>mo", MiniMap.open)
Map("n", "<Leader>mr", MiniMap.refresh)
Map("n", "<Leader>ms", MiniMap.toggle_side)
Map("n", "<Leader>mt", MiniMap.toggle)
