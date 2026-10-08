return {
  {
    "petertriho/nvim-scrollbar",
    opts = {
      show = true,
      show_in_active_only = false,
      set_highlights = true,

      handle = {
        text = " ",
        blend = 30,
        highlight = "CursorColumn",
      },

      marks = {
        Cursor = {
          text = "•",
          highlight = "Normal",
        },
        Search = {
          text = { "-", "=" },
          highlight = "Search",
        },
        Error = {
          text = { "-", "=" },
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          highlight = "DiagnosticVirtualTextHint",
        },
      },

      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = false,
        handle = true,
        search = false,
      },
    },
  },
}
