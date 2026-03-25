return {
  {
    "olimorris/codecompanion.nvim", 
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      "j-hui/fidget.nvim", -- Display status
      -- { "echasnovski/mini.pick", config = true },
      -- { "ibhagwan/fzf-lua", config = true },
    },
    opts = {
      ---@module "codecompanion"
      ---@type CodeCompanion.Config
      adapters = {
        acp = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              env = {
                GEMINI_API_KEY = "cmd:op read op://personal/Gemini_API/credential --no-newline",
              },
            })
          end,
        },
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:op read op://personal/Anthropic_API/credential --no-newline",
            },
            schema = {
              extended_thinking = {
                default = true,
              },
            },
          })
        end,
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = "cmd:op read op://personal/DeepSeek_API/credential --no-newline",
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "cmd:op read op://personal/Gemini_API/credential --no-newline",
            },
          })
        end,
        mistral = function()
          return require("codecompanion.adapters").extend("mistral", {
            env = {
              api_key = "cmd:op read op://personal/Mistral_API/credential --no-newline",
            },
          })
        end,
        novita = function()
          return require("codecompanion.adapters").extend("novita", {
            env = {
              api_key = "cmd:op read op://personal/Novita_API/credential --no-newline",
            },
            schema = {
              model = {
                default = function()
                  return "qwen/qwen3-coder-480b-a35b-instruct"
                end,
              },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "qwen3:latest",
              },
              num_ctx = {
                default = 20000,
              },
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            opts = {
              stream = true,
            },
            env = {
              api_key = "cmd:op read op://personal/OpenAI_API/credential --no-newline",
            },
            schema = {
              model = {
                default = function()
                  return "gpt-5-mini"
                end,
              },
            },
          })
        end,
        xai = function()
          return require("codecompanion.adapters").extend("xai", {
            env = {
              api_key = "cmd:op read op://personal/xAI_API/credential --no-newline",
            },
          })
        end,
        tavily = function()
          return require("codecompanion.adapters").extend("tavily", {
            env = {
              api_key = "cmd:op read op://personal/Tavily_API/credential --no-newline",
            },
          })
        end,
      },
      prompt_library = {
        ["Test workflow"] = {
          strategy = "workflow",
          description = "Use a workflow to test the plugin",
          opts = {
            index = 4,
          },
          prompts = {
            {
              {
                role = "user",
                content = "Generate a Python class for managing a book library with methods for adding, removing, and searching books",
                opts = {
                  auto_submit = false,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write unit tests for the library class you just created",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create a TypeScript interface for a complex e-commerce shopping cart system",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a recursive algorithm to balance a binary search tree in Java",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Generate a comprehensive regex pattern to validate email addresses with explanations",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create a Rust struct and implementation for a thread-safe message queue",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a GitHub Actions workflow file for CI/CD with multiple stages",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create SQL queries for a complex database schema with joins across 4 tables",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a Lua configuration for Neovim with custom keybindings and plugins",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Generate documentation in JSDoc format for a complex JavaScript API client",
                opts = {
                  auto_submit = true,
                },
              },
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "gpt-5-mini",
          },
          roles = {
            user = "Andy",
          },
          keymaps = {
            send = {
              modes = {
                i = { "<C-CR>", "<C-s>" },
              },
            },
            completion = {
              modes = {
                i = "<C-x>",
              },
            },
          },
          slash_commands = {
            ["buffer"] = {
              keymaps = {
                modes = {
                  i = "<C-b>",
                },
              },
            },
            ["fetch"] = {
              keymaps = {
                modes = {
                  i = "<C-f>",
                },
              },
            },
            ["help"] = {
              opts = {
                max_lines = 1000,
              },
            },
            ["image"] = {
              keymaps = {
                modes = {
                  i = "<C-i>",
                },
              },
              opts = {
                dirs = { "~/Documents/Screenshots" },
              },
            },
          },
        },
        inline = {
          adapter = {
            name = "copilot",
            model = "gpt-5-mini",
          },
        },
      },
      display = {
        action_palette = {
          provider = "default",
        },
        chat = {
          -- show_references = true,
          -- show_header_separator = false,
          -- show_settings = false,
          icons = {
            tool_success = "󰸞 ",
          },
          fold_context = true,
        },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
    keys = {
      {
        "<C-a>",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Open the action palette",
        mode = { "n", "v" },
      },
      {
        "<Leader>a",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Toggle a chat buffer",
        mode = { "n", "v" },
      },
      {
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add code to a chat buffer",
        mode = { "v" },
      },
    },
    init = function()
      vim.cmd([[cab cc CodeCompanion]])
      require("plugins.custom.spinner"):init()
    end,
  },
  {
    "zbirenbaum/copilot.lua", -- AI programming
    event = "InsertEnter",
    keys = {
      {
        "<C-a>",
        function()
          require("copilot.suggestion").accept()
        end,
        desc = "Copilot: Accept suggestion",
        mode = { "i" },
      },
      {
        "<C-x>",
        function()
          require("copilot.suggestion").dismiss()
        end,
        desc = "Copilot: Dismiss suggestion",
        mode = { "i" },
      },
      {
        "<C-\\>",
        function()
          require("copilot.panel").open()
        end,
        desc = "Copilot: Show panel",
        mode = { "n", "i" },
      },
    },
    init = function()
      -- om.create_user_command("Copilot", "Toggle Copilot suggestions", function()
      --   require("copilot.suggestion").toggle_auto_trigger()
      -- end)
    end,
    opts = {
      panel = { enabled = false },
      suggestion = {
        auto_trigger = true, -- Suggest as we start typing
        keymap = {
          accept_word = "<C-l>",
          accept_line = "<C-j>",
        },
      },
    },
  },
}
