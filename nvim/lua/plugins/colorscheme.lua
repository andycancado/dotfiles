return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {},
  },
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
    "alexxGmZ/e-ink.nvim",
    config = function()
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
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      vim.cmd("colorscheme github_dark_default")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      transparent_mode = false,
      colorscheme = "github_dark_default",
    },
  },
}
