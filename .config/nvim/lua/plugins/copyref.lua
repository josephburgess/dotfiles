return {
  "ranelpadon/python-copy-reference.vim",
  init = function()
    vim.g.python_copy_reference = {
      remove_prefixes = { "app" }, -- or "apps"
    }
  end,
}
