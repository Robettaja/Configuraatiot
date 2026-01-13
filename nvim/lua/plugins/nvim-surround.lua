return {
  {
    "kylechui/nvim-surround",
    opts = {
      keymaps = {
        normal = {
          add = "ns", -- Add surrounding in normal mode
          delete = "nd", -- Delete surrounding
          change = "nc", -- Change surrounding
        },
        visual = {
          add = "ns", -- Add surrounding in visual mode
        },
        insert = {
          add = "ns", -- Insert mode add
        },
      },
    },
  },
}
