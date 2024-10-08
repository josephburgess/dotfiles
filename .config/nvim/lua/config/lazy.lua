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
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

function SetColorscheme()
  local theme_file = os.getenv("HOME") .. "/.current_theme"
  local theme = "dark" -- Default to dark theme
  local file = io.open(theme_file, "r")
  if file then
    theme = file:read("*all")
    file:close()
  end

  if string.match(theme, "light") then
    vim.o.background = "light"
    vim.cmd("colorscheme rose-pine-dawn")
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme rose-pine-main")
    -- if string.match(theme, "light") then
    --   vim.o.background = "light"
    --   vim.cmd("colorscheme tokyonight-day")
    -- else
    --   vim.o.background = "dark"
    --   vim.cmd("colorscheme tokyonight-moon")
  end
end
