return {
  "mg979/vim-visual-multi",
  config = function()
    -- vim.g.VM_default_mappings = 0
    -- vim.g.VM_maps = {
    --   ["Find Under"] = "<C-x>",
    --   ["Find Subword Under"] = "<C-x>",
    -- }
    vim.keymap.set("n", "<leader>j", "<Plug>(VM-Add-Cursor-Down)")
    vim.keymap.set("n", "<leader>k", "<Plug>(VM-Find-Up)")

    -- Tried these as well but they do not work.
    -- vim.g.VM_maps['Find Subword Under'] = "<C-x>"
    -- vim.g.VM_maps["Select Cursor Down"] = '<M-u>'
    -- vim.g.VM_maps["Select Cursor Up"]   = '<M-d>'
  end,
}
