return {
  "ggandor/flit.nvim",
  enabled = false,
  keys = function()
    ---@type LazyKeysSpec[]
    local ret = {}
    for _, key in ipairs({ "f", "F", "t", "T" }) do
      ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
    end
    return ret
  end,
  opts = { labeled_modes = "nx" },
}
