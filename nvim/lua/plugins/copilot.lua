return {
  import = "lazyvim.plugins.extras.coding.copilot",
  config = function(_, _)
    -- when the copilot plugin is loaded, default to disabled
    vim.cmd("Copilot disable")
  end,
  lazy = false,
}
