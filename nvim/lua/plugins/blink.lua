return {
  "saghen/blink.cmp",
  depends = { "rafamadriz/friendly-snippets" },
  version = "v0.*",
  opts = {
    keymap = { preset = "enter" },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = true,
    },
    completion = {
      ghost_text = { enabled = true },
      menu = { auto_show = true },
    },
  },
}

-- return {
--   "saghen/blink.cmp",
--   depends = {
--     "rafamadriz/friendly-snippets",
--     "milanglacier/minuet-ai.nvim",
--   },
--   version = "v0.*",
--   opts = {
--     keymap = {
--       preset = "enter",
--       -- ["<A-y>"] = require("minuet").make_blink_map(),
--     },
--     appearance = {
--       use_nvim_cmp_as_default = false,
--       nerd_font_variant = "mono",
--     },
--     signature = {
--       enabled = true,
--     },
--     -- sources = {
--     --   -- Enable minuet for autocomplete
--     --   default = { "lsp", "path", "buffer", "snippets", "minuet" },
--     --   -- For manual completion only, remove 'minuet' from default
--     --   providers = {
--     --     minuet = {
--     --       name = "minuet",
--     --       module = "minuet.blink",
--     --       score_offset = 8, -- Gives minuet higher priority among suggestions
--     --     },
--     --   },
--     -- },
--     completion = {
--       trigger = { prefetch_on_insert = false },
--       ghost_text = { enabled = true },
--       menu = { auto_show = true },
--     },
--   },
-- }

-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua

-- completion plugin with support for LSPs and external sources that updates
-- on every keystroke with minimal overhead

-- https://www.lazyvim.org/extras/coding/blink
-- https://github.com/saghen/blink.cmp
-- Documentation site: https://cmp.saghen.dev/

--
-- return {
--   "saghen/blink.cmp",
--   enabled = true,
--   opts = function(_, opts)
--     opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
--       default = { "lsp", "path", "snippets", "buffer", "copilot" },
--       providers = {
--         lsp = {
--           name = "lsp",
--           enabled = true,
--           module = "blink.cmp.sources.lsp",
--           kind = "LSP",
--           score_offset = 90, -- the higher the number, the higher the priority
--         },
--         path = {
--           name = "Path",
--           module = "blink.cmp.sources.path",
--           score_offset = 3,
--           fallbacks = { "luasnip", "buffer" },
--           opts = {
--             trailing_slash = false,
--             label_trailing_slash = true,
--             get_cwd = function(context)
--               return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
--             end,
--             show_hidden_files_by_default = true,
--           },
--         },
--         buffer = {
--           name = "Buffer",
--           enabled = true,
--           max_items = 3,
--           module = "blink.cmp.sources.buffer",
--           min_keyword_length = 4,
--         },
--         snippets = {
--           name = "snippets",
--           enabled = true,
--           max_items = 3,
--           module = "blink.cmp.sources.snippets",
--           min_keyword_length = 4,
--           score_offset = 80, -- the higher the number, the higher the priority
--         },
--         copilot = {
--           name = "copilot",
--           enabled = true,
--           module = "blink-cmp-copilot",
--           kind = "Copilot",
--           min_keyword_length = 3,
--           score_offset = 100, -- the higher the number, the higher the priority
--           async = true,
--         },
--       },
--       -- command line completion, thanks to dpetka2001 in reddit
--       -- https://www.reddit.com/r/neovim/comments/1hjjf21/comment/m37fe4d/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
--       cmdline = function()
--         local type = vim.fn.getcmdtype()
--         if type == "/" or type == "?" then
--           return { "buffer" }
--         end
--         if type == ":" then
--           return { "cmdline" }
--         end
--         return {}
--       end,
--     })
--
--     return opts
--   end,
-- }
