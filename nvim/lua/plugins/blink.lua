return {
  "saghen/blink.cmp",
  version = "v0.*",
  opts = {
    -- providers = {
    --   "lsp",
    --   "buffer",
    -- },
    keymap = {
      -- preset = "enter"
      preset = "super-tab",
      ["<Tab>"] = {
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
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = true,
    },
    completion = {
      ghost_text = {
        enabled = true,
        show_with_menu = false, -- only show when menu is closed
      },

      menu = {
        auto_show = true,
        border = "rounded",
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
    },
  },
}
