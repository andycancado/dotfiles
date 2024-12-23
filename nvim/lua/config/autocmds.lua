-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--
-- autocmd({ "VimEnter" }, {
--   -- group = augroup("VimEnter"),
--   callback = function()
--     if os.getenv("TMUX") then
--       vim.api.nvim_command(":silent !tmux set status off")
--     end
--     -- if vim.o.buftype ~= 'nofile' then
--     --   vim.cmd('checktime')
--     -- end
--   end,
-- })
--
-- autocmd({ "VimLeave" }, {
--   -- group = augroup("VimEnter"),
--   callback = function()
--     if os.getenv("TMUX") then
--       vim.api.nvim_command(":! tmux set status on")
--     end
--     -- if vim.o.buftype ~= 'nofile' then
--     --   vim.cmd('checktime')
--     -- end
--   end,
-- })
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Disable Copilot by default on startup",
  command = "Copilot disable",
})
-- Disable spell check in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.o.spell = false
  end,
})
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
    vim.cmd([[
      wincmd J | setl nobuflisted
    ]])
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
