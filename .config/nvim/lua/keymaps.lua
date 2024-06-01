local wk = require("which-key")

wk.register({
	["<leader>c"] = { name = "[C]ode" },
	["<leader>d"] = { name = "[D]ocument" },
	["<leader>r"] = { name = "[R]ename" },
	["<leader>s"] = { name = "[S]earch" },
	["<leader>w"] = { name = "[W]orkspace" },
	["<leader>t"] = { name = "[T]oggle" },
	["<leader>h"] = { name = "Git [H]unk" },
})

wk.register({
	["<leader>h"] = { "Git [H]unk" },
}, { mode = "v" })

vim.keymap.set("n", "<leader>sh", require('telescope.builtin').help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", require('telescope.builtin').keymaps, { desc = "[S]earch [K]eymaps" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>tt", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<Esc><Esc>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up" })
vim.keymap.set("n", "<S-Enter>", "O<Esc>", { noremap = true, silent = true, desc = "Insert newline above" })
vim.keymap.set("n", "<CR>", "o<Esc>", { noremap = true, silent = true, desc = "Insert newline below" })
vim.keymap.set("n", "<leader>p", '"_dP', { noremap = true, silent = true, desc = "Paste without yanking" })

vim.keymap.set("i", "<M-BS>", "<Esc>cvb", {})
