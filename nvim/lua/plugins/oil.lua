return {
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        -- Customize options here
        columns = {
          "icon",
        },
        default_file_explorer = false, -- Set to true to replace netrw
      })
    end,
  },
}
