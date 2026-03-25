return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",
  opts = {
    win = {
      -- Window border style
      border = "single",
      -- Default window kind
      kind = "split_left",
    },
  },
   keys = {
    { "<leader>e", "<Cmd>Fyler kind=split_left_most<Cr>", desc = "Open Fyler View" },
  }
}
