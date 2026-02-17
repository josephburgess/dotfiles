-- ---------------------------------------------------------------------------
-- themes
-- ---------------------------------------------------------------------------
return {
	-- Active theme -----------------------------------------------------------
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			dark_variant = "main",
			styles = { bold = true, italic = true, transparency = true },
		},
	},
	{
		"LazyVim/LazyVim",
		-- switch theme here
		opts = { colorscheme = "rose-pine" },
	},

	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
			styles = { sidebars = "transparent", floats = "transparent" },
			on_highlights = function(hl, c)
				-- Keep parameter highlights consistent across JS/TS/Python
				local langs = { "python", "javascript", "javascriptreact", "typescript", "typescriptreact" }
				for _, lang in ipairs(langs) do
					hl["@variable." .. lang] = { fg = c.fg }
					hl["@variable.parameter." .. lang] = { fg = c.yellow, italic = true }
					hl["@variable.builtin." .. lang] = { fg = c.red, italic = true }
					hl["@lsp.type.parameter." .. lang] = { fg = c.yellow, italic = true }
					hl["@lsp.typemod.parameter.definition." .. lang] = { fg = c.yellow, italic = true }
				end
			end,
		},
	},
	{ "catppuccin/nvim", name = "catppuccin", lazy = true, priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = true },
	{ "EdenEast/nightfox.nvim", lazy = true, opts = { options = { transparent = true } } },
	{
		"sainnhe/gruvbox-material",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_transparent_background = true
			vim.g.gruvbox_material_better_performance = 1
		end,
	},
	{ "eldritch-theme/eldritch.nvim", lazy = true, opts = { transparent = true } },
	{ "0xstepit/flow.nvim", lazy = true, opts = { transparent = true, fluo_color = "pink" } },
	{ "slugbyte/lackluster.nvim", lazy = true },
	{ "miikanissi/modus-themes.nvim", lazy = true, priority = 1000 },
	{ "AlexvZyl/nordic.nvim", lazy = true },
	{
		"shaunsingh/nord.nvim",
		lazy = true,
		config = function()
			vim.g.nord_contrast = true
			vim.g.nord_borders = true
			vim.g.nord_disable_background = true
			vim.g.nord_italic = true
		end,
	},
	{ "diegoulloao/neofusion.nvim", lazy = true, opts = { transparent_mode = true } },
	{ "tiagovla/tokyodark.nvim", lazy = true, opts = { transparent_background = true } },
	{ "aliqyan-21/darkvoid.nvim", lazy = true },
	{ "craftzdog/solarized-osaka.nvim", lazy = true },
	{ "fcancelinha/nordern.nvim", lazy = true, branch = "master" },
}
