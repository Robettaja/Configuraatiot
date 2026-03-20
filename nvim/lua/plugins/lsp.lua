return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {
        html = {
          filetypes = { "html", "cshtml" },
        },
      },
    },
  },
}
