return {
  "sainnhe/gruvbox-material",
  lazy = true,
  priority = 1000,
  config = function()
    if vim.fn.has("termguicolors") == 1 then
      vim.opt.termguicolors = true
    end

    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_transparent_background = true
    vim.g.gruvbox_material_better_performance = 1
  end,
}
