return {
  "AckslD/swenv.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
  config = function()
    require("swenv").setup({
      get_venvs = function(venvs_path)
        return require("swenv.api").get_venvs(venvs_path)
      end,
      venvs_path = vim.fn.expand("/Users/josephburgess/.pyenv/versions/"),
      post_set_venv = function()
        vim.cmd.LspRestart()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python" },
      callback = function()
        require("swenv.api").auto_venv()
      end,
    })
  end,
}
