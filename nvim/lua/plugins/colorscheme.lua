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
  { "santhosh-tekuri/silence.nvim" },
  {
    "shadowy-pycoder/vscode-gruber.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    name = "vscode-gruber",
    branch = "main",
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme vscode-gruber")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      transparent_mode = false,
      -- colorscheme = "kanso-zen",
      colorscheme = "silence",
    },
  },
}
