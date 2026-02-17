-- disable unused providers to suppress healthcheck warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- ui
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.opt.fillchars = { eob = "~" }
vim.o.termguicolors = true
vim.hl.priorities.semantic_tokens = 75

-- completion
vim.opt.completeopt = "noselect"

-- diagnostics: floating by default, togglable via <leader>uH
vim.diagnostic.config({ virtual_text = false })

-- kitty: progressive enhancement key protocol
if vim.env.TERM == "xterm-256color" then
	vim.cmd([[autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif]])
	vim.cmd([[autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif]])
end

-- undercurl support
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- misc filetypes
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile  setf ruby]])

-- disable autoformat globally
vim.b.autoformat = false

-- :Cppath  — copy absolute path of current file to clipboard
vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to clipboard')
end, { desc = "Copy absolute file path to clipboard" })
