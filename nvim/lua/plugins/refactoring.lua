return {
  "ThePrimeagen/refactoring.nvim", -- Refactor code like Martin Fowler
  lazy = true,
  keys = {
    {
      "<Leader>rr",
      function()
        require("refactoring").select_refactor()
      end,
      desc = "Refactoring.nvim: Open",
      mode = { "n", "v", "x" },
    },
    {
      "<Leader>rd",
      function()
        require("refactoring").debug.printf({ below = false })
      end,
      desc = "Refactoring.nvim: Insert Printf statement for debugging",
    },
    {
      "<Leader>rv",
      function()
        require("refactoring").debug.print_var({})
      end,
      mode = { "v" },
      desc = "Refactoring.nvim: Insert Print_Var statement for debugging",
    },
    {
      "<Leader>rv",
      function()
        require("refactoring").debug.print_var({ normal = true })
      end,
      desc = "Refactoring.nvim: Insert Print_Var statement for debugging",
    },
    {
      "<Leader>rc",
      function()
        require("refactoring").debug.cleanup()
      end,
      desc = "Refactoring.nvim: Cleanup debug statements",
    },
  },
  config = true,
}

