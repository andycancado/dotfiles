local mapping_key_prefix = vim.g.ai_prefix_key or "<leader>a"
local user = vim.env.USER or "User"

-- Base on https://github.com/olimorris/codecompanion.nvim/blob/e7d931ae027f9fdca2bd7c53aa0a8d3f8d620256/lua/codecompanion/config.lua#L639 and https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/d42fab67c328946fbf8e24fdcadfdb5410517e1f/lua/CopilotChat/prompts.lua#L5
local SYSTEM_PROMPT = string.format(
  [[You are an AI programming assistant named "codeassis".
You are currently plugged in to the Neovim text editor on a user's machine.

Your tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Ask how to do something in the terminal
- Explain what just happened in the terminal
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
- The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
- The user is working on a %s machine. Please respond with system specific commands if applicable.

When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
2. Output the code in a single code block.
3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
4. You can only give one reply for each conversation turn.
5. The active document is the source code the user is looking at right now.
]],

  vim.uv.os_uname().sysname
)
local COPILOT_EXPLAIN = string.format(
  [[You are a world-class coding tutor. Your code explanations perfectly balance high-level concepts and granular details. Your approach ensures that students not only understand how to write code, but also grasp the underlying principles that guide effective programming.
When asked for your name, you must respond with "codeassis".
Follow the user's requirements carefully & to the letter.
Your expertise is strictly limited to software development topics.
Follow Microsoft content policies.
Avoid content that violates copyrights.
For questions not related to software development, simply give a reminder that you are an AI programming assistant.
Keep your answers short and impersonal.
Use Markdown formatting in your answers.
Make sure to include the programming language name at the start of the Markdown code blocks.
Avoid wrapping the whole response in triple backticks.
The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
The active document is the source code the user is looking at right now.
You can only give one reply for each conversation turn.

Additional Rules
Think step by step:
1. Examine the provided code selection and any other context like user question, related errors, project details, class definitions, etc.
2. If you are unsure about the code, concepts, or the user's question, ask clarifying questions.
3. If the user provided a specific question or error, answer it based on the selected code and additional provided context. Otherwise focus on explaining the selected code.
4. Provide suggestions if you see opportunities to improve code readability, performance, etc.

Focus on being clear, helpful, and thorough without assuming extensive prior knowledge.
Use developer-friendly terms and analogies in your explanations.
Identify 'gotchas' or less obvious parts of the code that might trip up someone new.
Provide clear and relevant examples aligned with any provided context.
]]
)
local COPILOT_REVIEW = string.format(
  [[Your task is to review the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Your feedback must be concise, directly addressing each identified issue with:
- A clear description of the problem.
- A concrete suggestion for how to improve or correct the issue.

Format your feedback as follows:
- Explain the high-level issue or problem briefly.
- Provide a specific suggestion for improvement.

If the code snippet has no readability issues, simply confirm that the code is clear and well-written as is.
]]
)
local COPILOT_REFACTOR = string.format(
  [[Your task is to refactor the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.
]]
)

local anthropic_fn = function()
  local anthropic_config = {
    env = { api_key = "ANTHROPIC_API_KEY" },
  }
  return require("codecompanion.adapters").extend("anthropic", anthropic_config)
end

local gemini_fn = function()
  local gemini_config = {
    -- env = { api_key = "GEMINI_API_KEY" },
  }
  return require("codecompanion.adapters").extend("gemini", gemini_config)
end

local ollama_fn = function()
  return require("codecompanion.adapters").extend("ollama", {
    env = {

      url = "http://100.82.159.62:11434",
    },
    schema = {
      model = {
        default = "phi4:latest",
      },
      num_ctx = {
        default = 16384,
      },
      num_predict = {
        default = -1,
      },
    },
  })
end

local openai_fn = function()
  local openai_config = {
    env = {
      api_key = "OPENAI_API_KEY",
      model = "o1-mini-2024-09-12",
    },
    schema = {
      model = {
        default = "o1-mini-2024-09-12",
      },
    },
  }
  return require("codecompanion.adapters").extend("openai", openai_config)
end

local copilot_fn = function()
  local copilot_config = {}
  return require("codecompanion.adapters").extend("copilot", copilot_config)
end

local openrouter_fn = function()
  -- local default_model = "google/gemini-2.0-flash-001"
  -- local current_model = default_model
  local openrouter_config = {
    env = {
      url = "https://openrouter.ai/api",
      api_key = "OPENROUTER_API_KEY",
      chat_url = "/v1/chat/completions",
      model = "nousresearch/deephermes-3-mistral-24b-preview:free", --current_model,
    },
    schema = {
      model = {
        default = "nousresearch/deephermes-3-mistral-24b-preview:free", --current_model,
      },
    },
  }
  return require("codecompanion.adapters").extend("openai_compatible", openrouter_config)
end

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = vim.g.which_key_preset or "helix", -- default is "classic"
      spec = {
        { mapping_key_prefix, group = "AI Code Companion", mode = { "n", "v" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "yaml", "markdown" } },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ibhagwan/fzf-lua", -- For fzf provider, file or buffer picker
      "jellydn/spinner.nvim", -- Show loading spinner when request is started
      "nvim-telescope/telescope.nvim",
      -- "ravitemer/codecompanion-history.nvim",
      "j-hui/fidget.nvim",
      {
        "Davidyz/VectorCode", -- Index and search code in your repositories
        version = "*",
        build = "uv tool upgrade vectorcode",
        -- build = "pipx upgrade vectorcode",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
      {
        "ravitemer/mcphub.nvim", -- Manage MCP servers
        cmd = "MCPHub",
        build = "npm install -g mcp-hub@latest",
        config = true,
      },
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
    },
    opts = {
      extensions = {
        -- history = {
        --   enabled = true,
        --   opts = {
        --     -- Keymap to open history from chat buffer (default: gh)
        --     keymap = "gh",
        --     -- Keymap to save the current chat manually (when auto_save is disabled)
        --     save_chat_keymap = "sc",
        --     -- Save all chats by default (disable to save only manually using 'sc')
        --     auto_save = true,
        --     -- Number of days after which chats are automatically deleted (0 to disable)
        --     expiration_days = 0,
        --     -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
        --     picker = "telescope",
        --     -- Automatically generate titles for new chats
        --     auto_generate_title = true,
        --     ---On exiting and entering neovim, loads the last chat on opening chat
        --     continue_last_chat = false,
        --     ---When chat is cleared with `gx` delete the chat from history
        --     delete_on_clearing_chat = false,
        --     ---Directory path to save the chats
        --     dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        --     ---Enable detailed logging for history extension
        --     enable_logging = false,
        --   },
        -- },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        vectorcode = {
          opts = {
            add_tool = true,
          },
        },
      },
      adapters = {
        anthropic = anthropic_fn,
        ollama = ollama_fn,
        openai = openai_fn,
        copilot = copilot_fn,
        gemini = gemini_fn,
        openrouter = openrouter_fn,
      },
      acp = {
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            commands = {
              flash = {
                "gemini",
                "--experimental-acp",
                "-m",
                "gemini-2.5-flash",
              },
              pro = {
                "gemini",
                "--experimental-acp",
                "-m",
                "gemini-2.5-pro",
              },
            },
            defaults = {
              -- auth_method = "gemini-api-key", -- "oauth-personal" | "gemini-api-key" | "vertex-ai"
              auth_method = "oauth-personal",
              -- auth_method = "vertex-ai",
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "gemini",
          roles = {
            llm = "  CodeCompanion",
            user = " " .. user:sub(1, 1):upper() .. user:sub(2),
          },
          tools = {
            opts = {
              auto_submit_success = false,
              auto_submit_errors = false,
            },
          },
          -- slash_commands = {
          --   ["buffer"] = {
          --     callback = "helpers.slash_commands.buffer",
          --     description = "Insert open buffers",
          --     opts = {
          --       contains_code = true,
          --       provider = "fzf_lua", -- default|telescope|mini_pick|fzf_lua
          --     },
          --   },
          --   ["file"] = {
          --     callback = "helpers.slash_commands.file",
          --     description = "Insert a file",
          --     opts = {
          --       contains_code = true,
          --       max_lines = 1000,
          --       provider = "fzf_lua", -- telescope|mini_pick|fzf_lua
          --     },
          --   },
          -- },
          keymaps = {
            send = {
              modes = {
                n = "<CR>",
                i = "<C-CR>",
              },
              index = 1,
              callback = "keymaps.send",
              description = "Send",
            },
            close = {
              modes = {
                n = "q",
              },
              index = 3,
              callback = "keymaps.close",
              description = "Close Chat",
            },
            stop = {
              modes = {
                n = "<C-c>",
              },
              index = 4,
              callback = "keymaps.stop",
              description = "Stop Request",
            },
          },
        },
        inline = { adapter = "gemini" },
        agent = { adapter = "gemini" },
      },
      inline = {
        layout = "buffer", -- vertical|horizontal|buffer
      },
      display = {
        chat = {
          -- Change to true to show the current model
          show_settings = false,
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
          },
        },
      },
      opts = {
        log_level = "DEBUG",
        system_prompt = SYSTEM_PROMPT,
      },
      prompt_library = {
        -- Custom the default prompt
        ["Generate a Commit Message"] = {
          prompts = {
            {
              role = "user",
              content = function()
                return "Write commit message with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
                  .. "\n\n```\n"
                  .. vim.fn.system("git diff")
                  .. "\n```"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ["Explain"] = {
          strategy = "chat",
          description = "Explain how code in a buffer works",
          opts = {
            index = 4,
            default_prompt = true,
            modes = { "v" },
            short_name = "explain",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = COPILOT_EXPLAIN,
              opts = {
                visible = false,
              },
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "Please explain how the following code works:\n\n```"
                  .. context.filetype
                  .. "\n"
                  .. code
                  .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        -- Add custom prompts
        ["Generate a Commit Message for Staged"] = {
          strategy = "chat",
          description = "Generate a commit message for staged change",
          opts = {
            index = 9,
            short_name = "staged-commit",
            auto_submit = true,
          },
          prompts = {
            {
              role = "user",
              content = function()
                return "Write commit message for the change with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
                  .. "\n\n```\n"
                  .. vim.fn.system("git diff --staged")
                  .. "\n```"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ["Inline-Document"] = {
          strategy = "inline",
          description = "Add documentation for code.",
          opts = {
            modes = { "v" },
            short_name = "inline-doc",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.\n\n```"
                  .. context.filetype
                  .. "\n"
                  .. code
                  .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ["Document"] = {
          strategy = "chat",
          description = "Write documentation for code.",
          opts = {
            modes = { "v" },
            short_name = "doc",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.\n\n```"
                  .. context.filetype
                  .. "\n"
                  .. code
                  .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ["Review"] = {
          strategy = "chat",
          description = "Review the provided code snippet.",
          opts = {
            index = 11,
            modes = { "v" },
            short_name = "review",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = COPILOT_REVIEW,
              opts = {
                visible = false,
              },
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```"
                  .. context.filetype
                  .. "\n"
                  .. code
                  .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ["Refactor"] = {
          strategy = "inline",
          description = "Refactor the provided code snippet.",
          opts = {
            index = 11,
            modes = { "v" },
            short_name = "refactor",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = COPILOT_REFACTOR,
              opts = {
                visible = false,
              },
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "Please refactor the following code to improve its clarity and readability:\n\n```"
                  .. context.filetype
                  .. "\n"
                  .. code
                  .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ["Naming"] = {
          strategy = "inline",
          description = "Give betting naming for the provided code snippet.",
          opts = {
            index = 12,
            modes = { "v" },
            short_name = "naming",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "Please provide better names for the following variables and functions:\n\n```"
                  .. context.filetype
                  .. "\n"
                  .. code
                  .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
    },
    config = function(_, options)
      require("codecompanion").setup(options)

      -- Show loading spinner when request is started
      local spinner = require("spinner")
      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequest*",
        group = group,
        callback = function(request)
          if request.match == "CodeCompanionRequestStarted" then
            spinner.show()
          end
          if request.match == "CodeCompanionRequestFinished" then
            spinner.hide()
          end
        end,
      })
    end,
    keys = {
      -- Recommend setup
      {
        mapping_key_prefix .. "a",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Code Companion - Actions",
      },
      {
        mapping_key_prefix .. "v",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Code Companion - Toggle",
        mode = { "n", "v" },
      },
      -- Some common usages with visual mode
      {
        mapping_key_prefix .. "e",
        "<cmd>CodeCompanion /explain<cr>",
        desc = "Code Companion - Explain code",
        mode = "v",
      },
      {
        mapping_key_prefix .. "f",
        "<cmd>CodeCompanion /fix<cr>",
        desc = "Code Companion - Fix code",
        mode = "v",
      },
      {
        mapping_key_prefix .. "l",
        "<cmd>CodeCompanion /lsp<cr>",
        desc = "Code Companion - Explain LSP diagnostic",
        mode = { "n", "v" },
      },
      {
        mapping_key_prefix .. "t",
        "<cmd>CodeCompanion /tests<cr>",
        desc = "Code Companion - Generate unit test",
        mode = "v",
      },
      {
        mapping_key_prefix .. "m",
        "<cmd>CodeCompanion /commit<cr>",
        desc = "Code Companion - Git commit message",
      },
      -- Custom prompts
      {
        mapping_key_prefix .. "M",
        "<cmd>CodeCompanion /staged-commit<cr>",
        desc = "Code Companion - Git commit message (staged)",
      },
      {
        mapping_key_prefix .. "d",
        "<cmd>CodeCompanion /inline-doc<cr>",
        desc = "Code Companion - Inline document code",
        mode = "v",
      },
      { mapping_key_prefix .. "D", "<cmd>CodeCompanion /doc<cr>", desc = "Code Companion - Document code", mode = "v" },
      {
        mapping_key_prefix .. "r",
        "<cmd>CodeCompanion /refactor<cr>",
        desc = "Code Companion - Refactor code",
        mode = "v",
      },
      {
        mapping_key_prefix .. "R",
        "<cmd>CodeCompanion /review<cr>",
        desc = "Code Companion - Review code",
        mode = "v",
      },
      {
        mapping_key_prefix .. "n",
        "<cmd>CodeCompanion /naming<cr>",
        desc = "Code Companion - Better naming",
        mode = "v",
      },
      -- Quick chat
      {
        mapping_key_prefix .. "q",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CodeCompanion " .. input)
          end
        end,
        desc = "Code Companion - Quick chat",
        mode = { "n", "v" },
      },
    },
  },
}
--
--
-- return {
--   "tpope/vim-sleuth", -- Automatically detects which indents should be used in the current buffer
--   {
--     "olimorris/codecompanion.nvim", -- The KING of AI programming
--     dependencies = {
--       "j-hui/fidget.nvim",
--       {
--         "ravitemer/mcphub.nvim", -- Manage MCP servers
--         cmd = "MCPHub",
--         build = "npm install -g mcp-hub@latest",
--         config = true,
--       },
--       {
--         "Davidyz/VectorCode", -- Index and search code in your repositories
--         version = "*",
--         build = "pipx upgrade vectorcode",
--         dependencies = { "nvim-lua/plenary.nvim" },
--       },
--       -- { "echasnovski/mini.pick", config = true },
--       -- { "ibhagwan/fzf-lua", config = true },
--     },
--     opts = {
--       extensions = {
--         mcphub = {
--           callback = "mcphub.extensions.codecompanion",
--           opts = {
--             make_vars = true,
--             make_slash_commands = true,
--             show_result_in_chat = true,
--           },
--         },
--         vectorcode = {
--           opts = {
--             add_tool = true,
--           },
--         },
--       },
--       adapters = {
--         anthropic = function()
--           return require("codecompanion.adapters").extend("anthropic", {
--             env = {
--               api_key = "cmd:op read op://personal/Anthropic_API/credential --no-newline",
--             },
--           })
--         end,
--         copilot = function()
--           return require("codecompanion.adapters").extend("copilot", {
--             schema = {
--               model = {
--                 default = "gemini-2.5-pro",
--               },
--             },
--           })
--         end,
--         deepseek = function()
--           return require("codecompanion.adapters").extend("deepseek", {
--             env = {
--               api_key = "cmd:op read op://personal/DeepSeek_API/credential --no-newline",
--             },
--           })
--         end,
--         gemini = function()
--           return require("codecompanion.adapters").extend("gemini", {
--             env = {
--               api_key = "cmd:op read op://personal/Gemini_API/credential --no-newline",
--             },
--           })
--         end,
--         mistral = function()
--           return require("codecompanion.adapters").extend("mistral", {
--             env = {
--               api_key = "cmd:op read op://personal/Mistral_API/credential --no-newline",
--             },
--           })
--         end,
--         novita = function()
--           return require("codecompanion.adapters").extend("novita", {
--             env = {
--               api_key = "cmd:op read op://personal/Novita_API/credential --no-newline",
--             },
--             schema = {
--               model = {
--                 default = function()
--                   return "meta-llama/llama-3.1-8b-instruct"
--                 end,
--               },
--             },
--           })
--         end,
--         ollama = function()
--           return require("codecompanion.adapters").extend("ollama", {
--             schema = {
--               model = {
--                 default = "llama3.1:latest",
--               },
--               num_ctx = {
--                 default = 20000,
--               },
--             },
--           })
--         end,
--         openai = function()
--           return require("codecompanion.adapters").extend("openai", {
--             opts = {
--               stream = true,
--             },
--             env = {
--               api_key = "cmd:op read op://personal/OpenAI_API/credential --no-newline",
--             },
--             schema = {
--               model = {
--                 default = function()
--                   return "gpt-4.1"
--                 end,
--               },
--             },
--           })
--         end,
--         xai = function()
--           return require("codecompanion.adapters").extend("xai", {
--             env = {
--               api_key = "cmd:op read op://personal/xAI_API/credential --no-newline",
--             },
--           })
--         end,
--       },
--       prompt_library = {
--         ["Test workflow"] = {
--           strategy = "workflow",
--           description = "Use a workflow to test the plugin",
--           opts = {
--             index = 4,
--           },
--           prompts = {
--             {
--               {
--                 role = "user",
--                 content = "Generate a Python class for managing a book library with methods for adding, removing, and searching books",
--                 opts = {
--                   auto_submit = false,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Write unit tests for the library class you just created",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Create a TypeScript interface for a complex e-commerce shopping cart system",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Write a recursive algorithm to balance a binary search tree in Java",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Generate a comprehensive regex pattern to validate email addresses with explanations",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Create a Rust struct and implementation for a thread-safe message queue",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Write a GitHub Actions workflow file for CI/CD with multiple stages",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Create SQL queries for a complex database schema with joins across 4 tables",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Write a Lua configuration for Neovim with custom keybindings and plugins",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = "user",
--                 content = "Generate documentation in JSDoc format for a complex JavaScript API client",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--           },
--         },
--       },
--       strategies = {
--         chat = {
--           adapter = "copilot",
--           roles = {
--             user = "olimorris",
--           },
--           keymaps = {
--             send = {
--               modes = {
--                 i = { "<C-CR>", "<C-s>" },
--               },
--             },
--             completion = {
--               modes = {
--                 i = "<C-x>",
--               },
--             },
--           },
--           slash_commands = {
--             ["buffer"] = {
--               opts = {
--                 keymaps = {
--                   modes = {
--                     i = "<C-b>",
--                   },
--                 },
--               },
--             },
--             ["help"] = {
--               opts = {
--                 max_lines = 1000,
--               },
--             },
--           },
--           tools = {
--             opts = {
--               auto_submit_success = false,
--               auto_submit_errors = false,
--             },
--           },
--         },
--         inline = { adapter = "copilot" },
--       },
--       display = {
--         action_palette = {
--           provider = "default",
--         },
--         chat = {
--           -- show_references = true,
--           -- show_header_separator = false,
--           -- show_settings = false,
--         },
--         diff = {
--           provider = "mini_diff",
--         },
--       },
--       opts = {
--         log_level = "DEBUG",
--       },
--     },
--     -- init = function()
--     --   vim.cmd([[cab cc CodeCompanion]])
--     --   -- require("legendary").keymaps({
--     --   --   {
--     --   --     itemgroup = "CodeCompanion",
--     --   --     icon = "",
--     --   --     description = "Use the power of AI...",
--     --   --     keymaps = {
--     --   --       {
--     --   --         "<C-a>",
--     --   --         "<cmd>CodeCompanionActions<CR>",
--     --   --         description = "Open the action palette",
--     --   --         mode = { "n", "v" },
--     --   --       },
--     --   --       {
--     --   --         "<Leader>a",
--     --   --         "<cmd>CodeCompanionChat Toggle<CR>",
--     --   --         description = "Toggle a chat buffer",
--     --   --         mode = { "n", "v" },
--     --   --       },
--     --   --       {
--     --   --         "<LocalLeader>a",
--     --   --         "<cmd>CodeCompanionChat Add<CR>",
--     --   --         description = "Add code to a chat buffer",
--     --   --         mode = { "v" },
--     --   --       },
--     --   --     },
--     --   --   },
--     --   -- })
--     --   require("plugins.custom.spinner"):init()
--     -- end,
--   },
--   {
--     "echasnovski/mini.test", -- Testing framework for Neovim
--     config = true,
--   },
--   {
--     "echasnovski/mini.diff", -- Inline and better diff over the default
--     config = function()
--       local diff = require("mini.diff")
--       diff.setup({
--         -- Disabled by default
--         source = diff.gen_source.none(),
--       })
--     end,
--   },
--
--   {
--     "folke/ts-comments.nvim", -- Enhance Neovim's native comments
--     opts = {},
--     event = "VeryLazy",
--   },
--   {
--     "kylechui/nvim-surround", -- Use vim commands to surround text, tags with brackets, parenthesis etc
--     config = true,
--   },
--   {
--     "ThePrimeagen/refactoring.nvim", -- Refactor code like Martin Fowler
--     lazy = true,
--     keys = {
--       {
--         "<LocalLeader>rr",
--         function()
--           require("refactoring").select_refactor()
--         end,
--         desc = "Refactoring.nvim: Open",
--         mode = { "n", "v", "x" },
--       },
--       {
--         "<LocalLeader>rd",
--         function()
--           require("refactoring").debug.printf({ below = false })
--         end,
--         desc = "Refactoring.nvim: Insert Printf statement for debugging",
--       },
--       {
--         "<LocalLeader>rv",
--         function()
--           require("refactoring").debug.print_var({})
--         end,
--         mode = { "v" },
--         desc = "Refactoring.nvim: Insert Print_Var statement for debugging",
--       },
--       {
--         "<LocalLeader>rv",
--         function()
--           require("refactoring").debug.print_var({ normal = true })
--         end,
--         desc = "Refactoring.nvim: Insert Print_Var statement for debugging",
--       },
--       {
--         "<LocalLeader>rc",
--         function()
--           require("refactoring").debug.cleanup()
--         end,
--         desc = "Refactoring.nvim: Cleanup debug statements",
--       },
--     },
--     config = true,
--   },
--   {
--     "zbirenbaum/copilot.lua", -- AI programming
--     event = "InsertEnter",
--     keys = {
--       {
--         "<C-a>",
--         function()
--           require("copilot.suggestion").accept()
--         end,
--         desc = "Copilot: Accept suggestion",
--         mode = { "i" },
--       },
--       {
--         "<C-x>",
--         function()
--           require("copilot.suggestion").dismiss()
--         end,
--         desc = "Copilot: Dismiss suggestion",
--         mode = { "i" },
--       },
--       {
--         "<C-\\>",
--         function()
--           require("copilot.panel").open()
--         end,
--         desc = "Copilot: Show panel",
--         mode = { "n", "i" },
--       },
--     },
--     -- init = function()
--     --   require("legendary").commands({
--     --     itemgroup = "Copilot",
--     --     commands = {
--     --       {
--     --         ":CopilotToggle",
--     --         function()
--     --           require("copilot.suggestion").toggle_auto_trigger()
--     --         end,
--     --         description = "Toggle on/off for buffer",
--     --       },
--     --     },
--     --   })
--     -- end,
--     opts = {
--       panel = { enabled = false },
--       suggestion = {
--         auto_trigger = true, -- Suggest as we start typing
--         keymap = {
--           accept_word = "<C-l>",
--           accept_line = "<C-j>",
--         },
--       },
--     },
--   },
--   {
--     "mfussenegger/nvim-dap", -- Debug Adapter Protocol for Neovim
--     lazy = true,
--     dependencies = {
--       "theHamsta/nvim-dap-virtual-text", -- help to find variable definitions in debug mode
--       "rcarriga/nvim-dap-ui", -- Nice UI for nvim-dap
--       "suketa/nvim-dap-ruby", -- Debug Ruby
--       "mfussenegger/nvim-dap-python", -- Debug Python
--     },
--     keys = {
--       {
--         "<F1>",
--         "<cmd>lua require('dap').toggle_breakpoint()<CR>",
--         desc = "Debug: Set breakpoint",
--       },
--       { "<F2>", "<cmd>lua require('dap').continue()<CR>", desc = "Debug: Continue" },
--       { "<F3>", "<cmd>lua require('dap').step_into()<CR>", desc = "Debug: Step into" },
--       { "<F4>", "<cmd>lua require('dap').step_over()<CR>", desc = "Debug: Step over" },
--       {
--         "<F5>",
--         "<cmd>lua require('dap').repl.toggle({height = 6})<CR>",
--         desc = "Debug: Toggle REPL",
--       },
--       { "<F6>", "<cmd>lua require('dap').repl.run_last()<CR>", desc = "Debug: Run last" },
--       {
--         "<F9>",
--         function()
--           local _, dap = require("dap")
--           dap.disconnect()
--           require("dapui").close()
--         end,
--         desc = "Debug: Stop",
--       },
--     },
--     config = function()
--       local dap = require("dap")
--       require("dap-ruby").setup()
--       require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
--
--       ---Show the nice virtual text when debugging
--       ---@return nil|function
--       local function virtual_text_setup()
--         local ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
--         if not ok then
--           return
--         end
--
--         return virtual_text.setup()
--       end
--
--       ---Show custom virtual text when debugging
--       ---@return nil
--       local function signs_setup()
--         vim.fn.sign_define("DapBreakpoint", {
--           text = "",
--           texthl = "DebugBreakpoint",
--           linehl = "",
--           numhl = "DebugBreakpoint",
--         })
--         vim.fn.sign_define("DapStopped", {
--           text = "",
--           texthl = "DebugHighlight",
--           linehl = "",
--           numhl = "DebugHighlight",
--         })
--       end
--
--       ---Slick UI which is automatically triggered when debugging
--       ---@param adapter table
--       ---@return nil
--       local function ui_setup(adapter)
--         local ok, dapui = pcall(require, "dapui")
--         if not ok then
--           return
--         end
--
--         dapui.setup({
--           layouts = {
--             {
--               elements = {
--                 "scopes",
--                 "breakpoints",
--                 "stacks",
--               },
--               size = 35,
--               position = "left",
--             },
--             {
--               elements = {
--                 "repl",
--               },
--               size = 0.30,
--               position = "bottom",
--             },
--           },
--         })
--         adapter.listeners.after.event_initialized["dapui_config"] = dapui.open
--         adapter.listeners.before.event_terminated["dapui_config"] = dapui.close
--         adapter.listeners.before.event_exited["dapui_config"] = dapui.close
--       end
--
--       dap.set_log_level("TRACE")
--
--       virtual_text_setup()
--       signs_setup()
--       ui_setup(dap)
--     end,
--   },
--   -- {
--   --   "stevearc/overseer.nvim", -- Task runner and job management
--   --   opts = {
--   --     component_aliases = {
--   --       default_neotest = {
--   --         "on_output_summarize",
--   --         "on_exit_set_status",
--   --         "on_complete_dispose",
--   --       },
--   --     },
--   --   },
--   --   init = function()
--   --     require("legendary").commands({
--   --       {
--   --         itemgroup = "Overseer",
--   --         icon = "省",
--   --         description = "Task running functionality...",
--   --         commands = {
--   --           {
--   --             ":OverseerRun",
--   --             description = "Run a task from a template",
--   --           },
--   --           {
--   --             ":OverseerBuild",
--   --             description = "Open the task builder",
--   --           },
--   --           {
--   --             ":OverseerToggle",
--   --             description = "Toggle the Overseer window",
--   --           },
--   --         },
--   --       },
--   --     })
--   --     require("legendary").keymaps({
--   --       itemgroup = "Overseer",
--   --       keymaps = {
--   --         {
--   --           "<Leader>o",
--   --           function()
--   --             local overseer = require("overseer")
--   --             local tasks = overseer.list_tasks({ recent_first = true })
--   --             if vim.tbl_isempty(tasks) then
--   --               vim.notify("No tasks found", vim.log.levels.WARN)
--   --             else
--   --               overseer.run_action(tasks[1], "restart")
--   --             end
--   --           end,
--   --           description = "Run the last Overseer task",
--   --         },
--   --       },
--   --     })
--   --   end,
--   -- },
--   {
--     "nvim-neotest/neotest",
--     lazy = true,
--     dependencies = {
--       "nvim-neotest/nvim-nio",
--       "nvim-lua/plenary.nvim",
--       "nvim-treesitter/nvim-treesitter",
--       "antoinemadec/FixCursorHold.nvim",
--
--       -- Adapters
--       "nvim-neotest/neotest-plenary",
--       "nvim-neotest/neotest-python",
--       "olimorris/neotest-rspec",
--       "olimorris/neotest-phpunit",
--     },
--     keys = {
--       {
--         "<LocalLeader>tn",
--         function()
--           if vim.bo.filetype == "lua" then
--             return require("mini.test").run_at_location()
--           end
--           require("neotest").run.run()
--         end,
--         desc = "Neotest: Test nearest",
--       },
--       {
--         "<LocalLeader>tf",
--         function()
--           if vim.bo.filetype == "lua" then
--             return require("mini.test").run_file()
--           end
--           require("neotest").run.run(vim.fn.expand("%"))
--         end,
--         desc = "Neotest: Test file",
--       },
--       {
--         "<LocalLeader>tl",
--         function()
--           require("neotest").run.run_last()
--         end,
--         desc = "Neotest: Run last test",
--       },
--       {
--         "<LocalLeader>ts",
--         function()
--           if vim.bo.filetype == "lua" then
--             return require("mini.test").run()
--           end
--           local neotest = require("neotest")
--           for _, adapter_id in ipairs(neotest.run.adapters()) do
--             neotest.run.run({ suite = true, adapter = adapter_id })
--           end
--         end,
--         desc = "Neotest: Test suite",
--       },
--       {
--         "<LocalLeader>to",
--         function()
--           require("neotest").output.open({ short = true })
--         end,
--         desc = "Neotest: Open test output",
--       },
--       {
--         "<LocalLeader>twn",
--         function()
--           require("neotest").watch.toggle()
--         end,
--         desc = "Neotest: Watch nearest test",
--       },
--       {
--         "<LocalLeader>twf",
--         function()
--           require("neotest").watch.toggle({ vim.fn.expand("%") })
--         end,
--         desc = "Neotest: Watch file",
--       },
--       {
--         "<LocalLeader>twa",
--         function()
--           require("neotest").watch.toggle({ suite = true })
--         end,
--         desc = "Neotest: Watch all tests",
--       },
--       {
--         "<LocalLeader>twa",
--         function()
--           require("neotest").watch.stop()
--         end,
--         desc = "Neotest: Stop watching",
--       },
--     },
--     config = function()
--       require("neotest").setup({
--         adapters = {
--           require("neotest-plenary"),
--           require("neotest-python")({
--             dap = { justMyCode = false },
--           }),
--           require("neotest-rspec"),
--           require("neotest-phpunit"),
--         },
--         consumers = {
--           overseer = require("neotest.consumers.overseer"),
--         },
--         diagnostic = {
--           enabled = false,
--         },
--         log_level = vim.log.levels.TRACE,
--         icons = {
--           expanded = "",
--           child_prefix = "",
--           child_indent = "",
--           final_child_prefix = "",
--           non_collapsible = "",
--           collapsed = "",
--
--           passed = "",
--           running = "",
--           failed = "",
--           unknown = "",
--           skipped = "",
--         },
--         floating = {
--           border = "single",
--           max_height = 0.8,
--           max_width = 0.9,
--         },
--         summary = {
--           mappings = {
--             attach = "a",
--             expand = { "<CR>", "<2-LeftMouse>" },
--             expand_all = "e",
--             jumpto = "i",
--             output = "o",
--             run = "r",
--             short = "O",
--             stop = "u",
--           },
--         },
--       })
--     end,
--   },
-- }
