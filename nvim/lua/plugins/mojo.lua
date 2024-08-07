-- require("nvim-web-devicons").set_icon({
--   mojo = {
--     icon = "󰈸",
--     color = "#d75f00",
--     cterm_color = "166",
--     name = "Mojo",
--   },
-- })

return {
  -- XXX: does not work...
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        mojo = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    ft = { "mojo" },
    opts = function(_, opts)
      vim.treesitter.language.register("python", "mojo")
      opts.indent = true
      opts.highlight.additional_vim_regex_highlighting = true

      return opts
    end,
  },
  {
    "igorgue/mojo.vim",
    -- dir = "~/Code/mojo.vim",
    ft = { "mojo" },
    init = function()
      local util = require("lazyvim.util")

      local function format_mojo()
        if util.format.enabled() then
          vim.cmd("noa silent! !mojo format --quiet " .. vim.fn.expand("%:p"))
        end
      end

      -- TODO: Fix this, runs on buf write pre and that shows an error
      -- this also sets it up for all type of files which is not good
      require("lazyvim.util").on_very_lazy(function()
        util.custom_format = function(_)
          format_mojo()
          return true
        end
      end)

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "*.🔥", "*.mojo" },
        nested = true,
        callback = format_mojo,
      })

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local ns = vim.api.nvim_create_namespace("mojo")

          vim.api.nvim_set_hl_ns(ns)

          vim.api.nvim_set_hl(ns, "@variable.python", {})
          vim.api.nvim_set_hl(ns, "@error.python", {})
          vim.api.nvim_set_hl(ns, "@repeat.python", {})
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "mojo",
        callback = function()
          vim.bo.expandtab = true
          vim.bo.shiftwidth = 4
          vim.bo.softtabstop = 4
          vim.bo.tabstop = 4
          vim.bo.commentstring = "# %s"

          -- vim.lsp.start({
          --   name = "mojo",
          --   cmd = { "mojo-lsp-server" },
          --   root_dir = util.root.get(),
          -- }, {
          --   bufnr = vim.api.nvim_get_current_buf(),
          -- })
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "igorgue/mojo.vim" },
    opts = function()
      local dap = require("dap")

      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
      }

      dap.configurations["mojo"] = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            ---@diagnostic disable-next-line: redundant-parameter
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
    end,
  },
}
