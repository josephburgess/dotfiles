local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

-- ---------------------------------------------------------------------------
-- window navigation
-- ---------------------------------------------------------------------------
map({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
map({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
map({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
map({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
map({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")

-- ---------------------------------------------------------------------------
-- scroll and keep cursor centred
-- ---------------------------------------------------------------------------
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- ---------------------------------------------------------------------------
-- registers: black-hole deletes, yank-register paste
-- ---------------------------------------------------------------------------
map("n", "x", '"_x')
map("n", "<Leader>P", '"0P')
map({ "n", "v" }, "<Leader>d", '"_d')
map({ "n", "v" }, "<Leader>D", '"_D')

-- ---------------------------------------------------------------------------
-- clear search highlight on escape
-- ---------------------------------------------------------------------------
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- ---------------------------------------------------------------------------
-- insert-mode word/line delete (muscle-memory friendly)
-- ---------------------------------------------------------------------------
map("i", "<M-BS>", "<C-w>", { desc = "Delete previous word" })
map("i", "<C-Del>", "<C-o>de", { desc = "Delete next word" })
map("i", "<D-Del>", "<C-o>d$<C-o>h", { desc = "Delete to end of line" })
map("i", "<D-BS>", "<C-o>d0", { desc = "Delete to start of line" })
map("n", "<C-Del>", "de", { desc = "Delete next word" })
map("n", "<M-BS>", "db", { desc = "Delete previous word" })

-- ---------------------------------------------------------------------------
-- lsp
-- ---------------------------------------------------------------------------
map("n", "<leader>cL", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
map("n", "<leader>cd", function()
	require("zendiagram").open()
end, { desc = "Open diagnostics float" })

-- ---------------------------------------------------------------------------
-- Diagnostics display toggle
-- ---------------------------------------------------------------------------
map("n", "<leader>uH", "<cmd>ToggleDiagnosticDisplay<cr>", { desc = "Toggle Diagnostic Display" })

-- ---------------------------------------------------------------------------
-- git: diffview helpers
-- ---------------------------------------------------------------------------
local function primary_branch()
	local h = io.popen("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null")
	if not h then
		return "master"
	end
	local out = h:read("*a")
	h:close()
	return out:match("refs/remotes/origin/([%w%-]+)") or "master"
end

map("n", "<leader>ge", function()
	vim.cmd("DiffviewOpen origin/" .. primary_branch() .. "...HEAD")
end, { desc = "Diff branch vs origin/main" })
map("n", "<leader>gD", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })

-- ---------------------------------------------------------------------------
-- oil file explorer
-- ---------------------------------------------------------------------------
map("n", "<leader>oi", function()
	require("oil").open()
end, { desc = "Oil (current dir)" })
map("n", "<leader>of", function()
	require("oil").open_float(".")
end, { desc = "Oil (float)" })

-- ---------------------------------------------------------------------------
-- spectre
-- ---------------------------------------------------------------------------
map("n", "<leader>sp", function()
	require("spectre").open_file_search({ select_word = true })
end, { desc = "Spectre: search current file" })

-- ---------------------------------------------------------------------------
-- misc
-- ---------------------------------------------------------------------------
map("n", "<Leader>ry", ":PythonCopyReferenceDotted<CR>", { desc = "Copy Python dotted ref" })
map("n", "<leader>on", "<CMD>Nvumi<CR>", { desc = "Open Nvumi" })
