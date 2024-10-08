-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.b.autoformat = false
    vim.opt_local.colorcolumn = "140"
  end,
})
local function clear_python_variable_highlight()
  vim.api.nvim_set_hl(0, "@variable.python", {})
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = clear_python_variable_highlight,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = clear_python_variable_highlight,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    SetColorscheme()
  end,
})

local theme_file = os.getenv("HOME") .. "/.current_theme"
local watch_theme_file = vim.loop.new_fs_event()
watch_theme_file:start(
  theme_file,
  {},
  vim.schedule_wrap(function()
    SetColorscheme()
  end)
)
