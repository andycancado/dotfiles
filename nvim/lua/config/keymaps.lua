-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")

vim.api.nvim_set_keymap("n", "<C-j>", "}", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "{", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<C-j>", "}", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-k>", "{", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Rename" })

vim.keymap.set("n", "<space>dd", "<cmd>Telescope diagnostics<cr>")
local options = { noremap = true }
vim.keymap.set("i", "kj", "<Esc>", options)

vim.keymap.set("n", "<silent><A-j>", ":move .+1<CR>")
vim.keymap.set("n", "<silent><A-k>", ":move .-2<CR>")

vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-d>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-u>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "jk", "<Right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-x>", ":bd<CR>", { noremap = true, silent = true })

-- Indent while remaining in visual mode.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- allow deleting to void register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- allow for pasting over without losing buffer
vim.keymap.set("x", "<leader>p", '"_dP')

-- Tab navigation.
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab page" })
vim.keymap.set("n", "<leader>tn", "<cmd>tab split<cr>", { desc = "New tab page" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tab pages" })

-- Execute macro over a visual region.
vim.keymap.set("x", "@", function()
  return ":norm @" .. vim.fn.getcharstr() .. "<cr>"
end, { expr = true })
-- --------------------------------------------------
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- don't ask
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- for fast repalce
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

local copilot_on = false
vim.api.nvim_create_user_command("CopilotToggle", function()
  if copilot_on then
    vim.cmd("Copilot disable")
    print("Copilot OFF")
  else
    vim.cmd("Copilot enable")
    print("Copilot ON")
  end
  copilot_on = not copilot_on
end, { nargs = 0 })
vim.keymap.set("n", "<leader>ch", ":CopilotToggle<CR>", { noremap = true, silent = true })

-- toggle inlays
vim.keymap.set("n", "<leader>h", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hint" })

local function visual_cursors_with_delay()
  -- Execute the vm-visual-cursors command.
  vim.cmd('silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"')
  -- Introduce delay via VimScript's 'sleep' (set to 500 milliseconds here).
  vim.cmd("sleep 200m")
  -- Press 'A' in normal mode after the delay.
  vim.cmd('silent! execute "normal! A"')
end

wk.register({
  m = {
    name = "Visual Multi",
    a = { "<Plug>(VM-Select-All)<Tab>", "Select All", mode = { "n" } },
    r = { "<Plug>(VM-Start-Regex-Search)", "Start Regex Search", mode = { "n" } },
    p = { "<Plug>(VM-Add-Cursor-At-Pos)", "Add Cursor At Pos", mode = { "n" } },
    v = { visual_cursors_with_delay, "Visual Cursors", mode = { "v" } },
    o = { "<Plug>(VM-Toggle-Mappings)", "Toggle Mapping", mode = { "n" } },
  },
}, { prefix = "<leader>" })

--
-- -- don't be a pussy, just use hjkl
-- vim.keymap.set("i", "<Up>", '<C-o>:echom "--> k <-- "<CR>')
-- vim.keymap.set("i", "<Down>", '<C-o>:echom "--> j <-- "<CR>')
-- vim.keymap.set("i", "<Right>", '<C-o>:echom "--> l <-- "<CR>')
-- vim.keymap.set("i", "<Left>", '<C-o>:echom "--> h <-- "<CR>')
-- vim.keymap.set("n", "<Down>", ':echom "--> j <-- "<CR>')
-- vim.keymap.set("n", "<Right>", ':echom "--> l <-- "<CR>')
-- vim.keymap.set("n", "<Left>", ':echom "--> h <-- "<CR>')
-- vim.keymap.set("n", "<Up>", ':echom "--> k <-- "<CR>')
