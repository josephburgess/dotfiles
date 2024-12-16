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
      opts.discovery = {
        enabled = false,
        concurrent = 1,
      }
      opts.running = {
        concurrent = true,
      }
      opts.summary = {
        animated = false,
      }
    end,
  },
}
