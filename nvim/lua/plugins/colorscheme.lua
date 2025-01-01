return {
  {
    "xiantang/darcula-dark.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000, opts = {} },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- {
  --   "blazkowolf/gruber-darker.nvim",
  --   opts = {
  --     bold = true,
  --     invert = {
  --       signs = false,
  --       tabline = false,
  --       visual = false,
  --     },
  --     italic = {
  --       strings = true,
  --       comments = true,
  --       operators = false,
  --       folds = true,
  --     },
  --     undercurl = true,
  --     underline = true,
  --   },
  -- },
  -- {
  --   "thimc/gruber-darker.nvim",
  --   config = function()
  --     require("gruber-darker").setup({
  --       transparent = false, -- removes the background
  --       underline = true, -- disables underline fonts
  --       bold = false, -- disables bold fonts
  --     })
  --     vim.cmd.colorscheme("gruber-darker")
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      transparent_mode = true,
      background = "#000000",
      -- colorscheme = "gruber-darker",
      -- colorscheme = "tokyonight",
      colorscheme = "kanagawa-wave",
      -- colorscheme = "darcula-dark",
    },
  },
}
