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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent = false,
    },
  },
  { "EdenEast/nightfox.nvim" },
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
  {
    "thimc/gruber-darker.nvim",
    config = function()
      require("gruber-darker").setup({
        transparent = false, -- removes the background
        underline = true, -- disables underline fonts
        bold = false, -- disables bold fonts
      })
      vim.cmd.colorscheme("gruber-darker")
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = false,
        italic_comments = true,
        hide_fillchars = false,
        borderless_telescope = true,
        terminal_colors = true,
      })
      -- vim.cmd("colorscheme cyberdream") -- set the colorscheme
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      transparent_mode = true,
      -- background = "#000000",
      -- colorscheme = "nightfox",
      -- colorscheme = "terafox",
      colorscheme = "gruber-darker",
      -- colorscheme = "tokyonight-moon",
      -- colorscheme = "catppuccin",
      -- colorscheme = "rose-pine-moon",
      -- colorscheme = "gruvbox",
      -- colorscheme = "cyberdream",
      -- colorscheme = "nightfox",
      -- colorscheme = "kanagawa-wave",
      -- colorscheme = "darcula-dark",
    },
  },
}
