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
Map("n", "<Esc>", "<cmd>nohlsearch<CR>")

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

Map("n", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Move selected line / block of text in visual mode
Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- buffers
Map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
Map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
Map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
Map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
Map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- clear search with esc
Map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Oil
Map("n", "<leader>oi", function()
	require("oil").open()
end, { desc = "Oil current dir" })
Map("n", "<leader>of", function()
	require("oil").open_float(".")
end, { desc = "Oil floating window" })

-- diagnostic
local function diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

Map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
Map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic", silent = true })
Map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic", silent = true })
Map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error", silent = true })
Map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error", silent = true })
Map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning", silent = true })
Map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning", silent = true })

-- lists
Map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
Map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
Map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
Map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- plugins
Map("n", "\\", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", { desc = "Open MiniFiles" })

Map("n", "<Leader>mc", ":MiniMap close<CR>", { desc = "Close minimap" })
Map("n", "<Leader>mf", ":MiniMap toggle_focus<CR>", { desc = "Toggle focus" })
Map("n", "<Leader>mo", ":MiniMap open<CR>", { desc = "Open minimap" })
Map("n", "<Leader>mr", ":MiniMap refresh<CR>", { desc = "Refresh minimap" })
Map("n", "<Leader>ms", ":MiniMap toggle_side<CR>", { desc = "Toggle side" })
Map("n", "<Leader>mt", ":MiniMap toggle<CR>", { desc = "Toggle" })

Map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
Map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
Map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
Map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

Map("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
Map("n", "<c-n>", "<Plug>(YankyNextEntry)")

Map("n", "<leader>fbb", ":GitBlameToggle<CR>", { desc = "Blame line (toggle)", silent = true })
Map("n", "<leader>Gbe", ":GitBlameEnable<CR>", { desc = "Blame line (enable)", silent = true })
Map("n", "<leader>Gbd", ":GitBlameDisable<CR>", { desc = "Blame line ({disable)", silent = true })
Map("n", "<leader>Gbs", ":GitBlameCopySHA<CR>", { desc = "Copy SHA", silent = true })
Map("n", "<leader>Gbc", ":GitBlameCopyCommitURL<CR>", { desc = "Copy commit URL", silent = true })
Map("n", "<leader>Gbf", ":GitBlameCopyFileURL<CR>", { desc = "Copy file URL", silent = true })

local function map_normal_mode(keys, func, desc)
	-- default values:
	-- noremap: false
	-- silent: false
	Map("n", keys, func, { desc = desc, noremap = false, silent = true })
end

function M.setup_trouble_keymaps()
	return {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	}
end

function M.setup_whichkey()
	return {
		{
			["<leader>c"] = { name = "[C]ode" },
			["<leader>d"] = { name = "[D]ocument" },
			["<leader>r"] = { name = "[R]ename" },
			["<leader>s"] = { name = "[S]earch" },
			["<leader>w"] = { name = "[W]orkspace" },
			["<leader>t"] = { name = "[T]oggle" },
			["<leader>h"] = { name = "Git [H]unk" },
			["<leader>g"] = { name = "To[G]gle comments" },
			["<leader>k"] = { name = "Harpoon Mar[k]" },
			["<leader>o"] = { name = "[O]il" },
			["<leader>m"] = { name = "[M]inimap" },
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
		},
		{ mode = "n" },
	}, {
		{
			["gb"] = "Togggle block comment",
			["gc"] = "Toggle line comment",
		},
		{ mode = "x" },
	}, {
		{
			["g>"] = "Comment region",
			["g<lt>"] = "Uncomment region",
		},
		{ mode = "x" },
	}, {
		{
			["<leader>h"] = { "Git [H]unk" },
		},
		{ mode = "v" },
	}
end
function M.setup_telescope_keymaps()
	map_normal_mode("<leader><leader>", require("telescope.builtin").find_files, "Find Files")

	-- git
	map_normal_mode("<leader>sc", "<cmd>Telescope git_commits<CR>", "[s]earch git [c]ommits")
	map_normal_mode("<leader>sg", "<cmd>Telescope git_status<CR>", "[s]earch git changes")

	-- search
	map_normal_mode("<leader>/", require("telescope").extensions.live_grep_args.live_grep_args, "[s]earch [g]rep")
	map_normal_mode('<leader>s"', "<cmd>Telescope registers<cr>", '[s]earch ["]registers')
	map_normal_mode("<leader>sa", "<cmd>Telescope autocommands<cr>", "[s]earch [a]utocommands")
	map_normal_mode("<leader>sb", "<cmd>Telescope buffers<CR>", "[s]earch opened [b]uffers")
	-- map_normal_mode("<leader>sc", "<cmd>Telescope command_history<cr>", "[s]earch [c]ommand history")

	map_normal_mode("<leader>sa", function()
		require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
	end, "[S]earch [A]ll Files")
	map_normal_mode("<leader>sw", require("telescope.builtin").grep_string, "[S]earch current [W]ord")
	map_normal_mode("<leader>sC", "<cmd>Telescope commands<cr>", "[s]earch [C]ommands")
	map_normal_mode("<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", "[s]earch [d]ocument diagnostics")
	map_normal_mode("<leader>sD", "<cmd>Telescope diagnostics<cr>", "[s]earch [D]iagnostics")
	map_normal_mode("<leader>sh", "<cmd>Telescope help_tags<cr>", "[s]earch [h]elp pages")
	map_normal_mode("<leader>sH", "<cmd>Telescope highlights<cr>", "[s]earch [H]ighlight groups")
	map_normal_mode("<leader>sk", "<cmd>Telescope keymaps<cr>", "[s]earch [k]ey maps")
	map_normal_mode("<leader>sM", "<cmd>Telescope man_pages<CR>", "[s]earch [M]an pages")
	map_normal_mode("<leader>sm", "<cmd>Telescope marks<cr>", "[s]earch [m]arks")
	map_normal_mode("<leader>so", "<cmd>Telescope vim_options<cr>", "[s]earch [o]ptions")
	map_normal_mode("<leader>sR", "<cmd>Telescope resume<cr>", "[s]earch [R]esume")
end
return M
