return {
  {
    "nvim-neotest/neotest",
    dependencies = { "haydenmeade/neotest-jest" },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm run test -- --silent=false",
          jestConfigFile = "custom.jest.config.ts",
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
    end,
  },
}