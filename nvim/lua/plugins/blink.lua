return {
  "saghen/blink.cmp",
  -- lazy = false, -- lazy loading handled internally
  event = { "LspAttach" },
  version = "v0.*",
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap. when defining your own, no keybinds will be assigned automatically.
    keymap = { preset = 'enter' },
    -- keymap = {
    --   ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    --   ["<C-i>"] = { "show", "show_documentation", "hide_documentation" },
    --   ["<C-e>"] = { "hide" },
    --   ["<C-y>"] = { "select_and_accept" },
    --   ["<Tab>"] = { "select_and_accept" },
    --
    --   ["<Up>"] = { "select_prev", "fallback" },
    --   ["<Down>"] = { "select_next", "fallback" },
    --   ["<C-p>"] = { "select_prev", "fallback" },
    --   ["<C-n>"] = { "select_next", "fallback" },
    --
    --   ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    --   ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    --
    --   -- ["<Tab>"] = { "snippet_forward", "fallback" },
    --   ["<S-Tab>"] = { "snippet_backward", "fallback" },
    -- },
    --
    highlight = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
    },
    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = "normal",

    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },

    -- experimental signature help support
    trigger = { signature_help = { enabled = true } },
  },
  windows = {
    autocomplete = {
      border = "double",
    },
  },
  documentation = {
    border = "padded",
  },
}
