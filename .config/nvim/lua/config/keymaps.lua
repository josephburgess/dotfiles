M = {}

-- Helper function for keymaps
local function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- General keymaps
Map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
Map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
Map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
Map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Select all
Map("n", "<C-a>", "gg<S-v>G")

Map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
Map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
Map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
Map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

Map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
Map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

Map("n", "x", '"_x')
Map("n", "<Leader>p", '"0p')
Map("n", "<Leader>P", '"0P')
Map("v", "<Leader>p", '"0p')
Map("n", "<Leader>d", '"_d')
Map("n", "<Leader>D", '"_D')
Map("v", "<Leader>d", '"_d')
Map("v", "<Leader>D", '"_D')

-- clear search with esc
Map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

Map("i", "<M-backspace>", "<C-w>", { desc = "Delete previous word" })
Map("i", "<C-Del>", "<C-o>de", { desc = "Delete next word" })
Map("i", "<D-Del>", "<C-o>d$<C-o>h", { desc = "Delete to end of line" })
Map("i", "<D-BS>", "<C-o>d0", { desc = "Delete to beginning of line" })
Map("n", "<C-Del>", "de", { desc = "Delete next word" })
Map("n", "<M-BS>", "db", { desc = "Delete previous word" })

Map({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
Map({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
Map({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
Map({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
Map({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")

Map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})
