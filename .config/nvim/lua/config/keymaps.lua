M = {}

-- Helper function for keymaps
local function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- General keymaps
Map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
Map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
Map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
Map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Select all
Map("n", "<C-a>", "gg<S-v>G")

Map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
Map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
Map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
Map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

Map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
Map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

Map("n", "x", '"_x')
Map("n", "<Leader>P", '"0P')
Map("n", "<Leader>d", '"_d')
Map("n", "<Leader>D", '"_D')
Map("v", "<Leader>d", '"_d')
Map("v", "<Leader>D", '"_D')

-- clear search with esc
Map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

Map("i", "<M-backspace>", "<C-w>", { desc = "Delete previous word" })
Map("i", "<C-Del>", "<C-o>de", { desc = "Delete next word" })
Map("i", "<D-Del>", "<C-o>d$<C-o>h", { desc = "Delete to end of line" })
Map("i", "<D-BS>", "<C-o>d0", { desc = "Delete to beginning of line" })
Map("n", "<C-Del>", "de", { desc = "Delete next word" })
Map("n", "<M-BS>", "db", { desc = "Delete previous word" })

Map({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
Map({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
Map({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
Map({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
Map({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")

Map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})

Map("n", "<Leader>ry", ":PythonCopyReferenceDotted<CR>", { desc = "Copy python ref" })

Map("n", "<leader>oi", function()
  require("oil").open()
end, { desc = "Oil current dir" })
Map("n", "<leader>of", function()
  require("oil").open_float(".")
end, { desc = "Oil floating window" })

---@return table used in cmp.setup({})
M.setup_cmp = function()
  local snippy_ok, snippy = pcall(require, "snippy")
  local cmp = require("cmp")

  map("n", "<C-Space>", function()
    vim.cmd.startinsert({ bang = true })
    vim.schedule(cmp.complete)
  end, { desc = "In normal mode, `A`ppend and start completion" })

  local snippy_mappings = snippy_ok
      and {
        -- snippy: previous field
        ["<C-b>"] = cmp.mapping(function()
          if snippy.can_jump(-1) then
            snippy.previous()
          end
          -- DO NOT FALLBACK (i.e. do not insert ^B)
        end, { "i", "s" }),

        -- snippy: expand or next field
        ["<C-f>"] = cmp.mapping(function(fallback)
          -- If a snippet is highlighted in PUM, expand it
          if cmp.confirm({ select = false }) then
            return
          end
          -- If in a snippet, jump to next field
          if snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
            return
          end
          fallback()
        end, { "i", "s" }),
      }
    or {}

  return cmp.mapping.preset.insert(vim.tbl_extend("force", {
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  }, snippy_mappings))
end
return M
