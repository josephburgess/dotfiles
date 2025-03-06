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

vim.api.nvim_create_user_command("PackageReload", function(info)
  for _, pkg in ipairs(info.fargs) do
    package.loaded[pkg] = nil
    require(pkg) -- may want to comment this out depending on how you want to use the module
  end
end, {
  nargs = "+",
  complete = function(arg_lead, _, _)
    return vim.tbl_keys(package.loaded)
    -- return vim.tbl_filter(function(mod_name) return string.find(mod_name, arg_lead, 1, true) end, vim.tbl_keys(package.loaded)) -- use this instead if you don't have a command completion plugin like nvim-cmp
  end,
  desc = "Clear cached lua modules and re-require them",
})

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--   group = vim.api.nvim_create_augroup("ZendiagramHover", { clear = true }),
--   callback = function()
--     local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
--
--     if #diagnostics > 0 then
--       if not zendiagram_open then
--         require("zendiagram").open()
--         zendiagram_open = true
--       end
--     else
--       if zendiagram_open then
--         require("zendiagram").close()
--         zendiagram_open = false
--       end
--     end
--   end,
-- })
