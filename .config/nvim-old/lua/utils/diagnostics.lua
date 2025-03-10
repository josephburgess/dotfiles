M = {}

function M.setup_diagnostics()
  local diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = require("utils.defaults").icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = require("utils.defaults").icons.diagnostics.Warn,
        [vim.diagnostic.severity.HINT] = require("utils.defaults").icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = require("utils.defaults").icons.diagnostics.Info,
      },
    },
  }

  -- set diagnostic icons
  for name, icon in pairs(require("utils.defaults").icons.diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  local version = require("utils.version")
  if type(diagnostics.virtual_text) == "table" and diagnostics.virtual_text.prefix == "icons" then
    diagnostics.virtual_text.prefix = version.is_neovim_0_10_0() == 0 and "●"
      or function(diagnostic)
        local icons = require("utils.defaults").icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end
  end

  vim.diagnostic.config(vim.deepcopy(diagnostics))

  require("config.keymaps").setup_diagnostics_keymaps()
end

return M
