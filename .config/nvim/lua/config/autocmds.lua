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
  end,
  desc = "Clear cached lua modules and re-require them",
})

local float_diagnostic_group_id = nil

vim.diagnostic.config({
  virtual_text = false,
})

local function setup_float_diagnostics()
  float_diagnostic_group_id = vim.api.nvim_create_augroup("float_diagnostic", { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    group = float_diagnostic_group_id,
    callback = function()
      local options = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = "●",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, options)
    end,
  })
end

setup_float_diagnostics()

local function toggle_diagnostic_display()
  local current = vim.diagnostic.config().virtual_text

  if current then
    vim.diagnostic.config({ virtual_text = false })
    setup_float_diagnostics()
    vim.notify("Diagnostics: floating (on hover)", vim.log.levels.INFO)
  else
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        spacing = 4,
      },
    })

    if float_diagnostic_group_id then
      vim.api.nvim_del_augroup_by_id(float_diagnostic_group_id)
      float_diagnostic_group_id = nil
    end
    vim.notify("Diagnostics: inline (virtual text)", vim.log.levels.INFO)
  end
end

-- toggle func
vim.api.nvim_create_user_command("ToggleDiagnosticDisplay", function()
  toggle_diagnostic_display()
end, { desc = "Toggle between floating and inline diagnostics" })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})
