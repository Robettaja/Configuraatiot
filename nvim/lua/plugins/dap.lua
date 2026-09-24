return {
  {
    "mfussenegger/nvim-dap",

    opts = function(_, opts)
      vim.schedule(function()
        local dap = require("dap")

        vim.fn.sign_define("DapBreakpoint", {
          text = "⬤",
          texthl = "DapBreakpoint",
          linehl = "",
          numhl = "",
        })

        vim.api.nvim_set_hl(0, "DapBreakpoint", {
          fg = "#e51400",
        })

        -- Mason netcoredbg
        dap.adapters.coreclr = {
          type = "executable",
          command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
          args = {
            "--interpreter=vscode",
          },
        }

        -- Add normal .NET debugging alongside Godot debugging.
        -- nvim-dap-godot-mono adds its own Godot configurations.
        dap.configurations.cs = dap.configurations.cs or {}

        local exists = false

        for _, config in ipairs(dap.configurations.cs) do
          if config.name == "C# - Launch DLL" then
            exists = true
            break
          end
        end

        if not exists then
          table.insert(dap.configurations.cs, {
            type = "coreclr",
            name = "C# - Launch DLL",
            request = "launch",

            program = function()
              return vim.fn.input(
                "Path to DLL: ",
                vim.fn.getcwd() .. "/bin/Debug/",
                "file"
              )
            end,

            cwd = "${workspaceFolder}",
          })
        end
      end)

      return opts
    end,

    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Continue",
      },

      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },

      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },

      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },

      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },

      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(
            vim.fn.input("Breakpoint condition: ")
          )
        end,
        desc = "Debug: Conditional Breakpoint",
      },

      {
        "<leader>dq",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: Terminate",
      },

      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: Toggle UI",
      },
    },
  },

  {
    "fm39hz/nvim-dap-godot-mono",

    dependencies = {
      "stevearc/overseer.nvim",
    },

    ft = "cs",

    opts = {
      godot = {
        godot_executable = "godot-mono",

        netcoredbg_path =
            vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
      },

      verbose = true,
    },
  },
}
