vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.o.termguicolors = true
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])
vim.b.autoformat = false

-- vim.opt.spell = true
-- vim.opt.spelllang = { "en_us" }
--
vim.diagnostic.config({
  virtual_text = false,
})
