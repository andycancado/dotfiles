return {
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

      -- lspconfig["ruff"].setup()
    end,
    servers = {
      pyright = {
        mason = false,
        autostart = false,
      },
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "all",
              diagnosticSeverityOverrides = {
                reportAny = false,
                reportMissingTypeArgument = false,
                reportMissingTypeStubs = false,
                reportUnknownArgumentType = false,
                reportUnknownMemberType = false,
                reportUnknownParameterType = false,
                reportUnknownVariableType = false,
                reportUnusedCallResult = false,
              },
            },
            -- python = {
            --   venvPath = "/path/to/venv",
            --   venv = "venv",
            -- },
          },
        },
      },
      -- basedpyright = {},
      ruff = {
        mason = false,
        enabled = false,
      },
      gopls = {
        mason = true,
        autostart = true,
        settings = {
          gopls = {
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
          },
        },
      },
      -- harper_ls = {
      --   settings = {
      --     ["harper-ls"] = {
      --       diagnosticSeverity = "information", -- Can also be "information", "warning", or "error"
      --
      --     },
      --   },
      -- },
    },
  },
}
