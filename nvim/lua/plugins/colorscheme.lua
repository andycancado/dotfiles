return {
  {
    "LazyVim/LazyVim",
    opts = {
      transparent_mode = true,
      -- background = "#000000",
      -- colorscheme = "nightfox",
      -- colorscheme = "terafox",
      -- colorscheme = "gruber-darker",
      -- colorscheme = "tokyonight-moon",
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "rose-pine-moon",
      -- colorscheme = "gruvbox",
      -- colorscheme = "cyberdream",
      -- colorscheme = "nightfox",
      colorscheme = "kanagawa-wave",
    },
  },
  { "rebelot/kanagawa.nvim" },
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
  {
    "blazkowolf/gruber-darker.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
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
}
