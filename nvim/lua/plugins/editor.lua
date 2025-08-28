local file_ignore_patterns = {
  "yarn%.lock",
  "node_modules/",
  "raycast/",
  "dist/",
  "%.next",
  "%.git/",
  "%.gitlab/",
  "build/",
  "target/",
  "package%-lock%.json",
  "venv/**/*",
}

return {
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
}
