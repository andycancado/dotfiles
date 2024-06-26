-- local set = vim.opt_local
--
-- -- Set local settings for terminal buffers
-- vim.api.nvim_create_autocmd("TermOpen", {
--   group = vim.api.nvim_create_augroup("custom-term-open", {}),
--   callback = function()
--     set.number = false
--     set.relativenumber = false
--     set.scrolloff = 0
--   end,
-- })
--
-- -- Easily hit escape in terminal mode.
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
--
-- -- Open a terminal at the bottom of the screen with a fixed height.
-- vim.keymap.set("n", ",st", function()
--   vim.cmd.new()
--   vim.cmd.wincmd("J")
--   vim.api.nvim_win_set_height(0, 12)
--   vim.wo.winfixheight = true
--   vim.cmd.term()
-- end)
-- return {}
return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    cmd = "ToggleTerm",
    keys = { { "<F4>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" } },
    opts = {
      open_mapping = [[<F4>]],
      direction = "horizontal",
      shade_filetypes = {},
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
    },
  },
}
