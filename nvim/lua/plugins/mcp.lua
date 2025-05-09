return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- Required for Job and HTTP requests
    },
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    config = function()
        require("mcphub").setup({
            -- Required options
            -- port = 3000,  -- Port for MCP Hub server
            config = vim.fn.expand("~/mcpservers.json"),  -- Absolute path to config file
            extensions = {
                codecompanion = {
                    show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
                    make_slash_commands = true,
                    make_vars = true, -- make chat #variables from MCP server resources
                },
            },

            -- Optional options
            -- on_ready = function(hub)
            --     -- Called when hub is ready
            -- end,
            -- on_error = function(err)
            --     -- Called on errors
            -- end,
            shutdown_delay = 0, -- Wait 0ms before shutting down server after last client exits
            log = {
                level = vim.log.levels.WARN,
                to_file = false,
                file_path = nil,
                prefix = "MCPHub"
            },
        })
    end
}
