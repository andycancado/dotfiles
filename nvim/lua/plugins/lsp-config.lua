return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      rust_analyzer = function()
        return false
      end,
    },
    diagnostics = {
      virtual_text = true,
    },
  },
}
