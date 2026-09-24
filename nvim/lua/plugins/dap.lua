return {
  {
    "mfussenegger/nvim-dap",

    opts = function(_, opts)
      vim.schedule(function()
        vim.fn.sign_define("DapBreakpoint", {
          text = "",
          texthl = "DapBreakpoint",
          linehl = "",
          numhl = "",
        })

        vim.api.nvim_set_hl(0, "DapBreakpoint", {
          fg = "#e51400",
        })
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
        -- Your Mono Godot executable
        godot_executable = "godot-mono",

        -- Mason's netcoredbg
        netcoredbg_path = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
      },

      verbose = true,
    },
  },
}
