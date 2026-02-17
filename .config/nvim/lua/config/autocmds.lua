vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.b.autoformat = false
	end,
})

-- ---------------------------------------------------------------------------
-- clear python variable highlight after every colorscheme change so that
-- treesitter doesnt paint every identifier the same colour
-- ---------------------------------------------------------------------------
local function clear_python_variable_highlight()
	vim.api.nvim_set_hl(0, "@variable.python", {})
end

vim.api.nvim_create_autocmd({ "ColorScheme", "BufEnter" }, {
	pattern = "*",
	callback = clear_python_variable_highlight,
})

-- ---------------------------------------------------------------------------
-- apply colorscheme once lazyvim is fully started
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	callback = SetColorscheme,
})

-- ---------------------------------------------------------------------------
-- watch ~/.current_theme and hot reload
-- ---------------------------------------------------------------------------
local theme_file = os.getenv("HOME") .. "/.current_theme"
local watcher = vim.loop.new_fs_event()
watcher:start(theme_file, {}, vim.schedule_wrap(SetColorscheme))

-- ---------------------------------------------------------------------------
-- strip trailing whitespace on save
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local pos = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", pos)
	end,
})

-- ---------------------------------------------------------------------------
-- diagnostics: floating window on cursor, allow for toggling
-- ---------------------------------------------------------------------------
local diag_augroup = nil

local function setup_float_diagnostics()
	diag_augroup = vim.api.nvim_create_augroup("FloatDiagnostic", { clear = true })
	vim.api.nvim_create_autocmd("CursorHold", {
		group = diag_augroup,
		callback = function()
			vim.diagnostic.open_float(nil, {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = "●",
				scope = "cursor",
			})
		end,
	})
end

setup_float_diagnostics()

local function toggle_diagnostic_display()
	if vim.diagnostic.config().virtual_text then
		vim.diagnostic.config({ virtual_text = false })
		setup_float_diagnostics()
		vim.notify("Diagnostics: floating (on hover)", vim.log.levels.INFO)
	else
		vim.diagnostic.config({ virtual_text = { prefix = "●", spacing = 4 } })
		if diag_augroup then
			vim.api.nvim_del_augroup_by_id(diag_augroup)
			diag_augroup = nil
		end
		vim.notify("Diagnostics: inline (virtual text)", vim.log.levels.INFO)
	end
end

vim.api.nvim_create_user_command("ToggleDiagnosticDisplay", toggle_diagnostic_display, {
	desc = "Toggle between floating and inline diagnostics",
})

-- ---------------------------------------------------------------------------
-- :PackageReload <module> to clear and re require lua modules during dev
-- ---------------------------------------------------------------------------
vim.api.nvim_create_user_command("PackageReload", function(info)
	for _, pkg in ipairs(info.fargs) do
		package.loaded[pkg] = nil
		require(pkg)
	end
end, {
	nargs = "+",
	complete = function()
		return vim.tbl_keys(package.loaded)
	end,
	desc = "Clear cached lua modules and re-require them",
})
