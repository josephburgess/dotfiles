vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.o.termguicolors = true
vim.highlight.priorities.semantic_tokens = 75
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])
vim.b.autoformat = false
vim.opt.fillchars = { eob = "~" }
vim.diagnostic.config({ virtual_text = false })
vim.opt.completeopt = "noselect"
if vim.env.TERM == "xterm-256color" then
  vim.cmd([[autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif]])
  vim.cmd([[autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif]])
end
vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
