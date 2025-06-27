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
  -- {
  --   "rjshkhr/shadow.nvim",
  --   priority = 1001,
  --   config = function()
  --     vim.opt.termguicolors = true
  --     -- vim.cmd.colorscheme("shadow")
  --   end,
  -- },
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
  { "ayu-theme/ayu-vim" },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    -- vim.cmd.colorscheme("kanso-ink")
    config = function() end,
  },
  -- {
  --   "shaunsingh/nord.nvim",
  --   lazy = true,
  --   options = {
  --     bold = false,
  --   },
  -- },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  {
    "github-main-user/lytmode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("lytmode").setup()
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
      -- colorscheme = "lytmode",
      -- colorscheme = "kanso",
      colorscheme = "kanso-mist",
      -- colorscheme = "kanagawa-wave",
      -- colorscheme = "kanagawabones",
    },
  },
}
