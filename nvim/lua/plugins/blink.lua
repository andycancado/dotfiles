return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {},

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "super-tab",

      ["<Tab>"] = {
        "snippet_forward",
        function() -- sidekick next edit suggestion
          return require("sidekick").nes_jump_or_apply()
        end,
        function() -- if you are using Neovim's native inline completions
          return vim.lsp.inline_completion.get()
        end,
        "fallback",
      },
      ["<C-x>"] = {
        function(cmp)
          cmp.show({ providers = { "lsp" } })
        end,
      },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    completion = { documentation = { auto_show = false } },

    sources = {
      default = { "lsp", "path", "buffer" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}

--
--
-- return {
--   "saghen/blink.cmp",
--   version = "v0.*",
--   opts = {
--     -- providers = {
--     --   "lsp",
--     --   "buffer",
--     -- },
--     keymap = {
--       -- preset = "enter"
--       preset = "super-tab",
--       ["<Tab>"] = {
--         function() -- sidekick next edit suggestion
--           return require("sidekick").nes_jump_or_apply()
--         end,
--         function() -- if you are using Neovim's native inline completions
--           return vim.lsp.inline_completion.get()
--         end,
--         "fallback",
--       },
--       ["<C-x>"] = {
--         function(cmp)
--           cmp.show({ providers = { "lsp" } })
--         end,
--       },
--     },
--     appearance = {
--       use_nvim_cmp_as_default = false,
--       nerd_font_variant = "mono",
--     },
--     signature = {
--       enabled = true,
--     },
--     completion = {
--       ghost_text = {
--         enabled = true,
--         show_with_menu = false, -- only show when menu is closed
--       },
--
--       menu = {
--         auto_show = true,
--         border = "rounded",
--         winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
--       },
--       documentation = {
--         window = {
--           border = "rounded",
--         },
--       },
--     },
--   },
-- }
