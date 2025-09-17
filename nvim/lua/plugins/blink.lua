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
        function(cmp)
          if vim.b[vim.api.nvim_get_current_buf()].nes_state then
            cmp.hide()
            return (
              require("copilot-lsp.nes").apply_pending_nes()
              and require("copilot-lsp.nes").walk_cursor_end_edit()
            )
          end
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      -- show with a list of providers
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
