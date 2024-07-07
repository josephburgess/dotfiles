return {
  "sainnhe/gruvbox-material",
  lazy = true,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_transparent_background = true
  end,
}
