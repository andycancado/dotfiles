return {
  {
    "thimc/gruber-darker.nvim",
    config = function()
      require("gruber-darker").setup({
        transparent = false, -- removes the background
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        undercurl = false,
        underline = false,
        bold = false,
        invert = {
          signs = false,
          tabline = false,
          visual = false,
        },
      })
    end,
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    opts = {},
    -- vim.cmd.colorscheme("kanso-ink")
    config = function() end,
  },
  {
    "mcauley-penney/techbase.nvim",
    config = function(_, opts)
      -- vim.cmd.colorscheme("techbase")
    end,
    priority = 1000,
  },
  {
    "kyza0d/xeno.nvim",
    lazy = false,
    priority = 1000, -- Load colorscheme early
    config = function()
      local xeno = require("xeno")
      xeno.new_theme('xeno-lilypad', {
        base = '#181818',
        -- accent = '#565f73',
        accent = '#8CBEFF',
        contrast = 0.3,
      })
      -- vim.cmd("colorscheme xeno-lilypad")
      -- vim.cmd("colorscheme xeno-golden-hour")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- transparent_mode = false,
      -- colorscheme = "base16-gruber",
      -- colorscheme = "base16-0x96f",
      -- colorscheme = "base16-ashes",
      -- colorscheme = "techbase",
      colorscheme = "default",
      -- colorscheme = "naysayer",
    },
  },
}
