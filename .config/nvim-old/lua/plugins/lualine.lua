-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = {
-- 		"nvim-tree/nvim-web-devicons",
-- 	},
-- 	event = "VeryLazy",
-- 	config = function()
-- 		-- Custom Lualine component to show attached language server
-- 		local clients_lsp = function()
-- 			local bufnr = vim.api.nvim_get_current_buf()
--
-- 			local clients = vim.lsp.buf_get_clients(bufnr) -- Don't change, breaks the function
-- 			if next(clients) == nil then
-- 				return ""
-- 			end
--
-- 			local c = {}
-- 			for _, client in pairs(clients) do
-- 				table.insert(c, client.name)
-- 			end
-- 			return " " .. table.concat(c, "|")
-- 		end
--
-- 		local custom_catppuccin = require("lualine.themes.catppuccin")
--
-- 		-- Custom colours
-- 		custom_catppuccin.normal.b.fg = "#cad3f5"
-- 		custom_catppuccin.insert.b.fg = "#cad3f5"
-- 		custom_catppuccin.visual.b.fg = "#cad3f5"
-- 		custom_catppuccin.replace.b.fg = "#cad3f5"
-- 		custom_catppuccin.command.b.fg = "#cad3f5"
-- 		custom_catppuccin.inactive.b.fg = "#cad3f5"
--
-- 		custom_catppuccin.normal.c.fg = "#6e738d"
-- 		custom_catppuccin.normal.c.bg = "#1e2030"
--
-- 		require("lualine").setup({
-- 			options = {
-- 				theme = custom_catppuccin,
-- 				component_separators = { left = "", right = "" },
-- 				section_separators = { left = "", right = "" },
-- 				disabled_filetypes = {},
-- 				always_divide_middle = true,
-- 			},
-- 			sections = {
-- 				lualine_a = {
-- 					{ "mode" },
-- 				},
-- 				lualine_b = {
-- 					{
-- 						"filetype",
-- 						icon_only = true,
-- 						padding = { left = 1, right = 0 },
-- 					},
-- 					"filename",
-- 				},
-- 				lualine_c = {
-- 					{
-- 						"branch",
-- 						icon = "",
-- 					},
-- 					{
-- 						"diff",
-- 						symbols = { added = " ", modified = " ", removed = " " },
-- 						colored = false,
-- 					},
-- 				},
-- 				lualine_x = {
-- 					{
-- 						"diagnostics",
-- 						symbols = { error = " ", warn = " ", info = " ", hint = "" },
-- 						update_in_insert = true,
-- 					},
-- 				},
-- 				lualine_y = { clients_lsp, "copilot" },
-- 				lualine_z = {
-- 					{ "location", separator = { left = "", right = " " }, icon = "" },
-- 				},
-- 			},
-- 			inactive_sections = {
-- 				lualine_a = { "filename" },
-- 				lualine_b = {},
-- 				lualine_c = {},
-- 				lualine_x = {},
-- 				lualine_y = {},
-- 				lualine_z = { "location" },
-- 			},
-- 			extensions = { "toggleterm", "trouble" },
-- 		})
-- 	end,
-- }
--
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {},
	opts = {

		-- see copilot.lua...
		-- copilot = {
		--   lualine_component = "filename",
		-- },
		--
		-- see debug.lua...
		-- dap_status = {
		--  lualine_component = "filename",
		--  },
		--
		-- see noice.lua...
		-- noice = {
		--   lualine_component = "filename",
		-- },

		options = {
			theme = "auto",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diagnostics" },
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
			lualine_x = { "encoding", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		extensions = { "neo-tree", "lazy", "mason", "man", "nvim-dap-ui", "trouble" },
	},
	config = function(_, opts)
		-- TODO: make more generic insertion function which can insert anywhere.
		if opts.copilot then
			table.insert(opts.sections.lualine_x, 1, opts.copilot.lualine_component)
		end

		if opts.dap_status then
			table.insert(opts.sections.lualine_x, 2, opts.dap_status.lualine_component)
		end

		if opts.noice then
			table.insert(opts.sections.lualine_x, 3, opts.noice.lualine_component)
		end

		require("lualine").setup(opts)
	end,
}
