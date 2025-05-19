return {
  "saghen/blink.cmp",
  depends = { "rafamadriz/friendly-snippets" },
  version = "v0.*",
  opts = {
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
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = false,
    },
    completion = {
      ghost_text = { enabled = true },
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
