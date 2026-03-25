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
    opts = {},
    -- vim.cmd.colorscheme("kanso-ink")
  },
  {
    "shadowy-pycoder/vscode-gruber.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    name = "vscode-gruber",
    branch = "main",
    priority = 1000,
    -- config = function()
    --   vim.cmd("colorscheme vscode-gruber")
    -- end,
  },
  {
    "whizikxd/naysayer-colors.nvim",
    lazy = false,
    -- config = function()
    --   vim.cmd.colorscheme("naysayer")
    -- end,
  },
  {
    "filipjanevski/0x96f.nvim",
    priority = 1000,
    config = function()
      require("0x96f").setup()
      vim.cmd.colorscheme("0x96f")
    end,
  },
  { "suvasanket/fleet.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      transparent_mode = false,
      colorscheme = "fleet",
    },
  },
}
