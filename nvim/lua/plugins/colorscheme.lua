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
  { "ficcdaf/ashen.nvim" },
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
        transparent = true, -- removes the background
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
      -- vim.cmd.colorscheme("gruber-darker")
    end,
  },
  {
    "wtfox/jellybeans.nvim",
    priority = 1000,
    -- config = function()
    --   require("jellybeans").setup()
    --   -- vim.cmd.colorscheme("jellybeans")
    -- end,
  },
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1001,
  },
  {
    "rjshkhr/shadow.nvim",
    priority = 1001,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("shadow")
    end,
  },
  {
    "alexxGmZ/e-ink.nvim",
    priority = 1000,
    config = function()
      -- require("e-ink").setup()
      -- vim.cmd.colorscheme("e-ink")

      -- choose light mode or dark mode
      -- vim.opt.background = "dark"
      -- vim.opt.background = "light"
      --
      -- or do
      -- :set background=dark
      -- :set background=light
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- transparent_mode = true,
      -- background = "#000000",
      -- colorscheme = "gruber-darker",
      -- colorscheme = "tokyonight",
      -- colorscheme = "mellifluous",
      -- colorscheme = "ashen",
      colorscheme = "shadow",
      -- colorscheme = "kanagawa-wave",
      -- colorscheme = "oldworld",
    },
  },
}
