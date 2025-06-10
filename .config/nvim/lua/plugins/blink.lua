return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- Add blink.compat as a dependency for Avante support
    {
      "saghen/blink.compat",
      opts = {},
      version = "*",
    },
  },

  -- use a release tag to download pre-built binaries
  version = "*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    enabled = function()
      return not vim.tbl_contains({ "nvumi" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    keymap = {
      preset = "default",
      ["<CR>"] = {},
      ["<Up>"] = {},
      ["<Down>"] = {},
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- Default list of enabled providers
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        -- Add Avante sources to the default list
        "avante_commands",
        "avante_mentions",
        "avante_files",
      },
      -- Configure providers for Avante
      providers = {
        avante_commands = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 90, -- show at a higher priority than lsp
          opts = {},
        },
        avante_files = {
          name = "avante_files",
          module = "blink.compat.source",
          score_offset = 100, -- show at a higher priority than lsp
          opts = {},
        },
        avante_mentions = {
          name = "avante_mentions",
          module = "blink.compat.source",
          score_offset = 1000, -- show at a higher priority than lsp
          opts = {},
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
-- return {
--   "saghen/blink.cmp",
--   version = not vim.g.lazyvim_blink_main and "*",
--   build = vim.g.lazyvim_blink_main and "cargo build --release",
--   opts_extend = {
--     "sources.completion.enabled_providers",
--     "sources.compat",
--     "sources.default",
--   },
--   dependencies = {
--     "rafamadriz/friendly-snippets",
--     -- add blink.compat to dependencies
--     {
--       "saghen/blink.compat",
--       optional = true, -- make optional so it's only enabled if any extras need it
--       opts = {},
--       version = not vim.g.lazyvim_blink_main and "*",
--     },
--   },
--   event = "InsertEnter",
--
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     snippets = {
--       expand = function(snippet, _)
--         return LazyVim.cmp.expand(snippet)
--       end,
--     },
--     appearance = {
--       -- sets the fallback highlight groups to nvim-cmp's highlight groups
--       -- useful for when your theme doesn't support blink.cmp
--       -- will be removed in a future release, assuming themes add support
--       use_nvim_cmp_as_default = false,
--       -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--       -- adjusts spacing to ensure icons are aligned
--       nerd_font_variant = "mono",
--     },
--     completion = {
--       accept = {
--         -- experimental auto-brackets support
--         auto_brackets = {
--           enabled = true,
--         },
--       },
--       menu = {
--         draw = {
--           treesitter = { "lsp" },
--         },
--       },
--       documentation = {
--         auto_show = true,
--         auto_show_delay_ms = 200,
--       },
--       ghost_text = {
--         enabled = vim.g.ai_cmp,
--       },
--     },
--
--     -- experimental signature help support
--     -- signature = { enabled = true },
--
--     sources = {
--       -- adding any nvim-cmp sources here will enable them
--       -- with blink.compat
--       compat = {},
--       default = { "lsp", "path", "snippets", "buffer" },
--     },
--
--     cmdline = {
--       enabled = false,
--     },
--
--     keymap = {
--       preset = "enter",
--       ["<C-y>"] = { "select_and_accept" },
--     },
--   },
--   ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
--   config = function(_, opts)
--     -- setup compat sources
--     local enabled = opts.sources.default
--     for _, source in ipairs(opts.sources.compat or {}) do
--       opts.sources.providers[source] = vim.tbl_deep_extend(
--         "force",
--         { name = source, module = "blink.compat.source" },
--         opts.sources.providers[source] or {}
--       )
--       if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
--         table.insert(enabled, source)
--       end
--     end
--
--     -- add ai_accept to <Tab> key
--     if not opts.keymap["<Tab>"] then
--       if opts.keymap.preset == "super-tab" then -- super-tab
--         opts.keymap["<Tab>"] = {
--           require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
--           LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
--           "fallback",
--         }
--       else -- other presets
--         opts.keymap["<Tab>"] = {
--           LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
--           "fallback",
--         }
--       end
--     end
--
--     -- Unset custom prop to pass blink.cmp validation
--     opts.sources.compat = nil
--
--     -- check if we need to override symbol kinds
--     for _, provider in pairs(opts.sources.providers or {}) do
--       ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
--       if provider.kind then
--         local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
--         local kind_idx = #CompletionItemKind + 1
--
--         CompletionItemKind[kind_idx] = provider.kind
--         ---@diagnostic disable-next-line: no-unknown
--         CompletionItemKind[provider.kind] = kind_idx
--
--         ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
--         local transform_items = provider.transform_items
--         ---@param ctx blink.cmp.Context
--         ---@param items blink.cmp.CompletionItem[]
--         provider.transform_items = function(ctx, items)
--           items = transform_items and transform_items(ctx, items) or items
--           for _, item in ipairs(items) do
--             item.kind = kind_idx or item.kind
--             item.kind_icon = LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
--           end
--           return items
--         end
--
--         -- Unset custom prop to pass blink.cmp validation
--         provider.kind = nil
--       end
--     end
--
--     require("blink.cmp").setup(opts)
--   end,
-- }
