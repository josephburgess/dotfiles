local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		{ import = "plugins" },
	},
	defaults = { lazy = false, version = false },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
		},
	},
})

-- ---------------------------------------------------------------------------
-- colorscheme: reads ~/.current_theme and switches light/dark accordingly
-- active colorscheme set in plugins/themes.lua
-- ---------------------------------------------------------------------------
function SetColorscheme()
	local theme_file = os.getenv("HOME") .. "/.current_theme"
	local theme = "dark"
	local file = io.open(theme_file, "r")
	if file then
		theme = file:read("*all")
		file:close()
	end
	vim.o.background = theme:match("light") and "light" or "dark"
end
