return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufReadPost" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({
          range = { start = vim.api.nvim_buf_get_mark(0, "<"), ["end"] = vim.api.nvim_buf_get_mark(0, ">") },
        })
      end,
      mode = "v",
      desc = "Format Selection",
    },
    {
      "<leader>cF",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format Buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua" },
      ["*"] = { "trim_whitespace" },
      python = { "autopep8" },
    },
  },
}
