return {}
-- return {
--     "Mofiqul/dracula.nvim",
--     config = function()
--       local dracula = require("dracula")
--       local colors = {
--         bg = "#1A1B26",
--         fg = "#F8F8F2",
--         selection = "#414D58",
--         comment = "#708CA9",
--         red = "#FF9580",
--         orange = "#FFCA80",
--         yellow = "#FFFF80",
--         green = "#8AFF80",
--         purple = "#9580FF",
--         cyan = "#80FFEA",
--         pink = "#FF80BF",
--         bright_red = "#FFBFB3",
--         bright_green = "#B9FFB3",
--         bright_yellow = "#FFFFB3",
--         bright_blue = "#BFB3FF",
--         bright_magenta = "#FFB3D9",
--         bright_cyan = "#B3FFF2",
--         bright_white = "#FFFFFF",
--         menu = "#0B0D0F",
--         visual = "#414D58",
--         gutter_fg = "#708CA9",
--         nontext = "#21222C",
--         white = "#F8F8F2",
--         black = "#0B0D0F",
--       }
--       dracula.setup({
--         colors = colors,
--         show_end_of_buffer = true,
--         transparent_bg = true, -- Assuming "transparent_bg" means no transparency in this context
--         lualine_bg_color = "#414D58", -- Assuming "status_bar.background" for "lualine_bg_color"
--         italic_comment = true,
--         overrides = {
--           -- Add any specific overrides you might need here
--           -- Example: To change the background color of the status line
--           StatusLine = { bg = "#0A0D10" },
--           ["@variable.parameter"] = { italic = true, fg = colors.orange },
--           ["@variable.builtin"] = { italic = true, fg = colors.purple },
--           ["@keyword.function.python"] = { fg = colors.pink },
--           ["@variable.member.python"] = { fg = colors.white },
--           ["@variable.javascript"] = { fg = colors.purple },
--           ["@type"] = { fg = colors.bright_cyan },
--           ["@attribute"] =  {fg = colors.bright_green }
--         },
--       }) -- Adjust the path if your file is in a subdirectory
--     end,
--     priority = 1000, -- Make sure to load this before all the other start plugins.
--     init = function()
--       -- Load the   scheme here.
--       -- Like many other themes, this one has different styles, and you could load
--       -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
--       vim.cmd.colorscheme 'dracula'
--
--       -- You can configure highlights by doing something like:
--       vim.cmd.hi 'Comment gui=none'
--     end,
--   }