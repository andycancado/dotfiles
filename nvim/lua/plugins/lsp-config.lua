return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      rust_analyzer = function()
        return true
      end,
      pyrigth = function()
        return false
      end,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
  },
}
