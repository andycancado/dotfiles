return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", "<Cmd>lua require('dap').continue()<CR>", desc = "Debug Start/Continue" },
      { "<F6>", "<Cmd>lua require('dap').step_over()<CR>", desc = "Debug Step Over" },
      { "<F7>", "<Cmd>lua require('dap').step_into()<CR>", desc = "Debug Step Into" },
      { "<F8>", "<Cmd>lua require('dap').step_out()<CR>", desc = "Debug Step Out" },
      { "<F9>", "<Cmd>DapTerminate<CR>", desc = "Debug Terminate DAP" },
      { "<leader>db", "<Cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
      {
        "<leader>dB",
        "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        desc = "Breakpoint Condition",
      },
      {
        "<leader>dl",
        "<Cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
        desc = "Log Point Message",
      },
      { "<m-r>", "<Cmd>lua require('dap').repl.open()<CR>", desc = "Debug Repl Open" },
      { "<m-l>", "<Cmd>lua require('dap').run_last()<CR>", desc = "Debug Run Last" },
    },
    config = function()
      -- local path = require("mason-registry").get_package("debugpy"):get_install_path()
      -- require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },
  {
    "miroshQa/debugmaster.nvim",
    config = function()
      local dm = require("debugmaster")
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
      vim.keymap.set({ "n", "v" }, "<leader>dm", dm.mode.toggle, { nowait = true })
      -- If you want to disable debug mode in addition to leader+d using the Escape key:
      -- vim.keymap.set("n", "<Esc>", dm.mode.disable)
      -- This might be unwanted if you already use Esc for ":noh"
      vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
  },
}
