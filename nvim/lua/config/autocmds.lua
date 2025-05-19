-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   -- group = augroup("VimEnter"),
--   callback = function()
--     if os.getenv("TMUX") then
--       vim.api.nvim_command(":silent !tmux set-option -g pane-border-status off")
--       vim.api.nvim_command(":silent !tmux set status off")
--     end
--     -- if vim.o.buftype ~= 'nofile' then
--     --   vim.cmd('checktime')
--     -- end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "VimLeave" }, {
--   -- group = augroup("VimEnter"),
--   callback = function()
--     if os.getenv("TMUX") then
--       vim.api.nvim_command(":silent !tmux set-option -g pane-border-status off")
--       vim.api.nvim_command(":silent !tmux set status on")
--     end
--     -- if vim.o.buftype ~= 'nofile' then
--     --   vim.cmd('checktime')
--     -- end
--   end,
-- })

-- vim.api.nvim_create_autocmd("VimEnter", {
--   desc = "Disable Copilot by default on startup",
--   command = "Copilot disable",
-- })
-- -- Disable spell check in terminal
-- vim.api.nvim_create_autocmd("TermOpen", {
--   callback = function()
--     vim.o.spell = false
--   end,
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "qf",
--   callback = function(event)
--     local opts = { buffer = event.buf, silent = true }
--     vim.keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
--     vim.keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
--   end,
-- })
-- Move QuickFix window to the bottom

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.cmd([[ wincmd J | setl nobuflisted ]])
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.cmd([[ wincmd J | setl nobuflisted ]])
  end,
})
-- Hide diagnostics when entering insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.diagnostic.hide(nil, 0)
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.diagnostic.show(nil, 0)
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-ter-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- diff colorscheme
local function set_diff_highlights()
  local is_dark = vim.opt.background:get() == "dark"

  if is_dark then
    vim.api.nvim_set_hl(0, "DiffAdd", { bold = true, bg = "#2e4b2e" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bold = true, bg = "#4c1e15" })
    vim.api.nvim_set_hl(0, "DiffChange", { bold = true, bg = "#45565c" })
    vim.api.nvim_set_hl(0, "DiffText", { bold = true, bg = "#996d74" })
  else
    vim.api.nvim_set_hl(0, "DiffAdd", { bold = true, bg = "palegreen" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bold = true, bg = "tomato" })
    vim.api.nvim_set_hl(0, "DiffChange", { bold = true, bg = "lightblue" })
    vim.api.nvim_set_hl(0, "DiffText", { bold = true, bg = "lightpink" })
  end
end

-- Create an autocmd group
local diff_colors_group = vim.api.nvim_create_augroup("DiffColors", { clear = true })

-- Register the autocmd for colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  group = diff_colors_group,
  callback = set_diff_highlights,
})

-- Disable newline comments
-- https://github.com/scottmckendry/Windots/blob/main/nvim/lua/core/autocmds.lua
local augroup = vim.api.nvim_create_augroup("autocmds/disable-new-line-comments", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Call initially to set highlights
-- set_diff_highlights()
-- local group = vim.api.nvim_create_augroup('OoO', {})
--
-- local function au(typ, pattern, cmdOrFn)
-- 	if type(cmdOrFn) == 'function' then
-- 		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
-- 	else
-- 		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
-- 	end
-- end
--
-- au({ 'CursorHold', 'InsertLeave' }, nil, function()
-- 	local opts = {
-- 		focusable = false,
-- 		scope = 'cursor',
-- 		close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
-- 	}
-- 	vim.diagnostic.open_float(nil, opts)
-- end)
--
-- au('InsertEnter', nil, function()
-- 	vim.diagnostic.enable(false)
-- end)
--
-- au('InsertLeave', nil, function()
-- 	vim.diagnostic.enable(true)
-- end)
--
