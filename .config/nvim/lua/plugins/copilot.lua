return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "BufRead",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom",
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true, -- Enable automatic ghost text
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>", -- Alt+L to accept suggestion
          accept_word = "<M-w>", -- Alt+W to accept word
          accept_line = "<M-e>", -- Alt+E to accept line
          next = "<M-]>", -- Alt+] for next suggestion
          prev = "<M-[>", -- Alt+[ for previous suggestion
          dismiss = "<C-]>", -- Ctrl+] to dismiss
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = "node",
      server_opts_overrides = {},
    })
  end,
}
