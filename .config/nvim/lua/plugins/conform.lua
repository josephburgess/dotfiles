return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufReadPost" },
  keys = {
    {
      "cf",
      function()
        require("conform").format({
          range = { start = vim.api.nvim_buf_get_mark(0, "<"), ["end"] = vim.api.nvim_buf_get_mark(0, ">") },
        })
      end,
      mode = "v",
      desc = "Format Selection",
    },
    {
      "cF",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format Buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = function(bufnr)
        local cwd = vim.fn.getcwd()
        if string.match(cwd, "Funnel/cerebro") then
          return { "biome" }
        else
          return { "prettier" }
        end
      end,
      typescript = function(bufnr)
        local cwd = vim.fn.getcwd()
        if string.match(cwd, "Funnel/cerebro") then
          return { "biome" }
        else
          return { "prettier" }
        end
      end,
      javascriptreact = function(bufnr)
        local cwd = vim.fn.getcwd()
        if string.match(cwd, "Funnel/cerebro") then
          return { "biome" }
        else
          return { "prettier" }
        end
      end,
      typescriptreact = function(bufnr)
        local cwd = vim.fn.getcwd()
        if string.match(cwd, "Funnel/cerebro") then
          return { "biome" }
        else
          return { "prettier" }
        end
      end,
      json = function(bufnr)
        local cwd = vim.fn.getcwd()
        if string.match(cwd, "Funnel/cerebro") then
          return { "biome" }
        else
          return { "prettier" }
        end
      end,
      jsonc = function(bufnr)
        local cwd = vim.fn.getcwd()
        if string.match(cwd, "Funnel/cerebro") then
          return { "biome" }
        else
          return { "prettier" }
        end
      end,

      -- These remain prettier for all projects
      css = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      svelte = { "prettier" },

      -- Other formatters remain the same
      lua = { "stylua" },
      python = { "autopep8" },
      ["*"] = { "trim_whitespace" },
    },
    -- Optional: configure biome formatter settings
    formatters = {
      biome = {
        -- Biome will automatically find biome.json in your project root
        -- You can add custom args if needed
        -- append_args = { "--indent-style", "space" },
      },
    },
  },
}
