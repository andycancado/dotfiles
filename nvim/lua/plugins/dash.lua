return {
  {
    -- https://patorjk.com/software/taag/?ref=devas.life#p=display&f=ANSI%20Shadow&t=devaslife
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      -- figlet font "The Edge"
      local logo = [[
         █████╗ ███╗   ██╗██████╗ ██╗   ██╗     
        ██╔══██╗████╗  ██║██╔══██╗╚██╗ ██╔╝     
        ███████║██╔██╗ ██║██║  ██║ ╚████╔╝      
        ██╔══██║██║╚██╗██║██║  ██║  ╚██╔╝       
███████╗██║  ██║██║ ╚████║██████╔╝   ██║███████╗
╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝    ╚═╝╚══════╝
                                                ]]

      logo = string.rep("\n", 6) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
