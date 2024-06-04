local function prefer_bin_from_pyenv_or_venv(executable_name)
	-- Check if using pyenv
	if vim.env.PYENV_VERSION then
		local pyenv_root = vim.fn.system("pyenv root"):gsub("%s+", "")
		local pyenv_path = pyenv_root .. "/versions/" .. vim.env.PYENV_VERSION .. "/bin/" .. executable_name
		if vim.fn.executable(pyenv_path) == 1 then
			return pyenv_path
		end
	end

	return nil
end

local function find_python_executable()
	if vim.env.PYENV_VERSION then
		local pyenv_root = vim.fn.system("pyenv root"):gsub("%s+", "")
		local pyenv_path = pyenv_root .. "/versions/" .. vim.env.PYENV_VERSION .. "/bin/python"
		if vim.fn.executable(pyenv_path) == 1 then
			return pyenv_path
		end
	end

	if vim.fn.filereadable(".venv/bin/python") == 1 then
		return vim.fn.expand(".venv/bin/python")
	else
		return vim.fn.exepath("python3")
	end

	return nil
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.py" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.colorcolumn = "88"
		if not vim.g.python3_host_prog then
			vim.g.python3_host_prog = find_python_executable()
		end
	end,
})

return {
	{
		"neovim/nvim-lspconfig",
		ft = { "python" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			servers = {
				pylsp = {
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = {
									ignore = { "W391", "BLK100", "E1", "E2", "E3", "E5", "I", "W291" },
									maxLineLength = 120,
								},
								rope_autoimport = { enabled = true },
							},
						},
					},
				},
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		ft = { "python" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = function(_, opts)
			opts.linters = opts.linters or {}
			local mypy_path = prefer_bin_from_pyenv_or_venv("mypy")
			opts.linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft["python"] = { "mypy" }
			if mypy_path then
				opts.linters["mypy"] = {
					cmd = mypy_path,
				}
			end
		end,
	},
}
