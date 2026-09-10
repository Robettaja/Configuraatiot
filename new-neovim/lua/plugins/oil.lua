return {
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        columns = {
          "icon",
        },

        default_file_explorer = true,
        view_options = {
          show_hidden = true,

          is_hidden_file = function(name, bufnr)
            local m = name:match("^%.")
            return m ~= nil
          end,
        },
      })
    end,
  },
}
