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
vim.opt.relativenumber = true
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
vim.opt.clipboard = "unnamedplus"
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
--
--
-- if vim.fn.has("nvim-0.8") == 1 then
--   vim.opt.cmdheight = 0
-- end

-- vim.o.listchars = "eol:↵,lead:·"
vim.diagnostic.config({ virtual_text = false, signs = true })

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

vim.api.nvim_exec(
  [[
      function! CustomTelescopeHighlights() abort
        " Fetching colors from core Neovim highlight groups
        let fg = synIDattr(hlID('Normal'), 'fg')
        let bg0 = synIDattr(hlID('Normal'), 'bg')
        let bg1 = synIDattr(hlID('NormalFloat'), 'bg')
        let orange = synIDattr(hlID('WarningMsg'), 'fg')
        let purple = synIDattr(hlID('Statement'), 'fg')
        let green = synIDattr(hlID('String'), 'fg')
        let red = synIDattr(hlID('ErrorMsg'), 'fg')

        " Setting custom highlights for Telescope
        call nvim_set_hl(0, 'TelescopeMatching', {'fg': orange})
        call nvim_set_hl(0, 'TelescopeSelection', {'fg': fg, 'bg': bg1, 'bold': v:true})
        call nvim_set_hl(0, 'TelescopePromptPrefix', {'bg': bg1})
        call nvim_set_hl(0, 'TelescopePromptNormal', {'bg': bg1})
        call nvim_set_hl(0, 'TelescopeResultsNormal', {'bg': bg0})
        call nvim_set_hl(0, 'TelescopePreviewNormal', {'bg': bg0})
        call nvim_set_hl(0, 'TelescopePromptBorder', {'bg': bg1, 'fg': bg1})
        call nvim_set_hl(0, 'TelescopeResultsBorder', {'bg': bg0, 'fg': bg0})
        call nvim_set_hl(0, 'TelescopePreviewBorder', {'bg': bg0, 'fg': bg0})
        call nvim_set_hl(0, 'TelescopePromptTitle', {'bg': purple, 'fg': bg0})
        call nvim_set_hl(0, 'TelescopeResultsTitle', {'fg': bg0})
        call nvim_set_hl(0, 'TelescopePreviewTitle', {'bg': green, 'fg': bg0})
        call nvim_set_hl(0, 'CmpItemKindField', {'bg': red, 'fg': bg0})

        " Make cmp menu transparent
        call nvim_set_hl(0, 'PMenu', {'bg': 'NONE'})
      endfunction

      " Call the function to apply the custom highlights
      call CustomTelescopeHighlights()
    ]],
  false
)
