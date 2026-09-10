return {
  {
    "Exafunction/windsurf.nvim",
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,
        virtual_text = {
          enabled = true, -- ghost-text style suggestions instead
        },
      })
    end,
  },
}
