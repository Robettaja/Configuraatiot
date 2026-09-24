return {
  {
    "Mathijs-Bakker/godotdev.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-treesitter/nvim-treesitter",
    },

    config = function()
      require("godotdev").setup({
        godot_path = "/usr/bin/godot-mono",
        csharp = true,
        autostart_editor_server = true,
      })

      local dap = require("dap")

      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = {
          "--interpreter=vscode",
        },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Godot C#",
          request = "launch",

          program = function()
            return vim.fn.input(
              "Path to Godot DLL: ",
              vim.fn.getcwd() .. "/.godot/mono/temp/bin/Debug/",
              "file"
            )
          end,

          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
