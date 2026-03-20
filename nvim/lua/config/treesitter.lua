require("nvim-treesitter.configs").setup({
  ensure_installed = { "c_sharp", "html", "css", "razor" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
