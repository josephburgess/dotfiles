return {
  "stevearc/conform.nvim",
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
      python = { "isort", "yapf" },
    },
    formatters = {
      yapf = {
        command = "yapf",
        args = { "--style='{based_on_style: google, column_limit: 100, indent_width: 4}'" },
        stdin = true,
      },
      isort = {
        command = "isort",
        args = { "--profile", "google", "$FILENAME" },
        stdin = false,
      },
      stylua = {
        command = "stylua",
        args = { "-" },
        stdin = true,
      },
    },
  },
}
