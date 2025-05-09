-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.g.mapleader = " "
--
-- vim.scriptencoding = "utf-8"
-- vim.opt.encoding = "utf-8"
-- vim.opt.fileencoding = "utf-8"
--
-- vim.opt.number = true
--
vim.opt.shell = "/bin/zsh"
vim.opt.relativenumber = false
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 999
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

vim.opt.clipboard = "unnamedplus"
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.g.autoformat = false

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- vim.o.listchars = "eol:↵,lead:·"

-- Abbreviations for common typos
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_blink_main = true
-- vim.diagnostic.config({
--   -- Use the default configuration
--   virtual_lines = true,
--
--   -- Alternatively, customize specific options
--   -- virtual_lines = {
--   --  -- Only show virtual line diagnostics for the current cursor line
--   --  current_line = true,
--   -- },
-- })
