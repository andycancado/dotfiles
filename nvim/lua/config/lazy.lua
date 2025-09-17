local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- vim.api.nvim_exec(
--   [[
-- autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
-- ]],
--   false
-- )

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.json" },
    -- import/override with your plugins
    --

    { import = "plugins" },
    {
      "nvim-tree/nvim-web-devicons",
    },
    {
      "Davidyz/VectorCode",
      version = "*", -- optional, depending on whether you're on nightly or release
      build = "uv tool upgrade vectorcode",
      -- build = "pipx upgrade vectorcode", -- optional but recommended if you set `version = "*"`
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "A7Lavinraj/fyler.nvim",
      dependencies = { "nvim-mini/mini.icons" },
      opts = {
        views = {
          file_tree = {
            width = 0.2,
            height = 0.8,
            kind = "split:left",
            border = "single",
          },
        },
      },
    },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that suiport semver
  },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

