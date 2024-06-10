return {
  {
    "LazyVim/LazyVim",
    opts = {
      transparent_mode = true,
      -- background = "#000000",
      -- colorscheme = "nightfox",
      -- colorscheme = "terafox",
      colorscheme = "gruber-darker",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "catppuccin-macchiato",
      -- colorscheme = "rose-pine-moon",
      -- colorscheme = "gruvbox",
    },
  },
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
      transparent = true,
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
  { "ellisonleao/gruvbox.nvim" },
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard" -- soft, medium, hard
      vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = "bright" -- Background of floating windows
      vim.g.gruvbox_material_statusline_style = "material"
      vim.g.gruvbox_material_cursor = "auto"

      -- vim.g.gruvbox_material_colors_override = { bg0 = '#000000' } -- #0e1010
      -- vim.g.gruvbox_material_colors_override = { bg0 = "#121212" }
      -- vim.g.gruvbox_material_better_performance = 1

      -- vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      })
      -- vim.cmd("colorscheme cyberdream") -- set the colorscheme
    end,
  },
}
