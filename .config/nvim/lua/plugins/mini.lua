return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup({ n_lines = 500 })
        require("mini.surround").setup({
            mappings = {
                add = "sa",
                delete = "sd",
                find = "sf",
                find_left = "sF",
                highlight = "sh",
                replace = "sr",
                update_n_lines = "sn",

                suffix_last = "l",
                suffix_next = "n",
            },
        })
    end,
}
