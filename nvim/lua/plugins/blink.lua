return {
  "saghen/blink.cmp",
  depends = { "rafamadriz/friendly-snippets" },
  version = "v0.*",
  opts = {
    keymap = { preset = "enter" },
    appearance = {
      use_nvim_cmp_as_default = true,
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
