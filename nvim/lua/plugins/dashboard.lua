return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[

██╗   ██╗██╗███████╗██╗   ██╗ █████╗ ██╗         ███████╗████████╗██╗   ██╗██████╗ ██╗ ██████╗
██║   ██║██║██╔════╝██║   ██║██╔══██╗██║         ██╔════╝╚══██╔══╝██║   ██║██╔══██╗██║██╔═══██╗
██║   ██║██║███████╗██║   ██║███████║██║         ███████╗   ██║   ██║   ██║██║  ██║██║██║   ██║
╚██╗ ██╔╝██║╚════██║██║   ██║██╔══██║██║         ╚════██║   ██║   ██║   ██║██║  ██║██║██║   ██║
 ╚████╔╝ ██║███████║╚██████╔╝██║  ██║███████╗    ███████║   ██║   ╚██████╔╝██████╔╝██║╚██████╔╝
  ╚═══╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝
                                                                                              
          ]],
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#AE7FE2" })
        end,
      })
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#AE7FE2" })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.SnacksDashboardHeader = { fg = "#AE7FE2" }
      end,
    },
  },
}
