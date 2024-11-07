return {

  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = {
      inlay_hints = { enabled = false },
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
      config = function(_, opts)
        local lspconfig = require("lspconfig")
        for server, config in pairs(opts.servers) do
          config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end
      end,
      servers = {
        pyright = {
          mason = false,
          autostart = false,
        },
      },
    },
  },
}
-- return {
--   -- change nvim-lspconfig options
--   "neovim/nvim-lspconfig",
--   opts = {
--     servers = {
--       -- https://github.com/microsoft/pyright/discussions/5852#discussioncomment-6874502
--       pyright = {
--         capabilities = {
--           textDocument = {
--             publishDiagnostics = {
--               tagSupport = {
--                 valueSet = { 2 },
--               },
--             },
--           },
--         },
--       },
--       ruff_lsp = {},
--     },
--   },
-- }
-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = {
--     "hrsh7th/nvim-cmp",
--   },
--   config = function()
--     -- -- Chaos
--     -- -- https://www.reddit.com/r/neovim/comments/18teetv/one_day_you_will_wake_up_and_choose_the_chaos
--     -- -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
--     -- -- https://neovim.io/doc/user/diagnostic.html#diagnostic-highlights
--     -- local signs = {
--     --   Error = "🤬",
--     --   Warn = "😤",
--     --   Info = "🤔",
--     --   Hint = "🤯",
--     -- }
--     -- for type, icon in pairs(signs) do
--     --   local hl = "DiagnosticSign" .. type
--     --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
--     -- end
--     --
--     -- https://neovim.io/doc/user/diagnostic.html#diagnostic-api
--     vim.diagnostic.config({
--       underline = true,
--       virtual_text = true,
--     })
--   end,
-- }
