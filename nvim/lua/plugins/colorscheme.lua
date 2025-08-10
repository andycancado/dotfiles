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
  { "RRethy/base16-nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      transparent_mode = false,
      colorscheme = "base16-gruber",
    },
  },
}
