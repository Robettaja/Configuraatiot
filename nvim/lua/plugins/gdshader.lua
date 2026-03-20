vim.filetype.add({
  extension = {
    gdshader = "gdshader",
    gdshaderinc = "gdshaderinc",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gdshader", "gdshaderinc" },
  callback = function()
    vim.lsp.start({
      name = "gdshader-lsp",
      cmd = { "/home/roope/.tools/gdshader-lsp" },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })
  end,
})

return {}
