return {
  {
    "seblyng/roslyn.nvim",

    dependencies = {
      "neovim/nvim-lspconfig",
    },

    config = function()
      local roslyn = require("roslyn")

      roslyn.setup({

        autostart = true,
        -- Automatically install server if not present
        install = true,

        -- Optional: custom dotnet command
        dotnet_cmd = "dotnet",

        -- Enable logging (helpful for debugging)
        log_level = "info",

        root_dir = function()
          return vim.fn.getcwd() -- adjust if needed to detect your .sln or .csproj
        end,

        -- LSP configuration override
        config = {
          settings = {
            ["csharp|background_analysis"] = {
              dotnet_analyzer_diagnostics_scope = "openFiles",
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true, -- requires auto-refresh lua
            },
            ["csharp|completion"] = {
              dotnet_show_completion_items_from_unimported_namespaces = true,
              dotnet_Show_name_completion_suggestions = true,
            },
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,
              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_enable_inlay_hints_for_types = true,
            },
            ["csharp|symbol_search"] = {
              dotnet_search_reference_assemblies = true,
            },
            ["csharp|formatting"] = {
              dotnet_organize_imports_on_format = true,
            },
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function(...)
              vim.lsp.diagnostic.on_publish_diagnostics(...)
            end,
          },
        },
      })
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = "*.cshtml",
        callback = function()
          vim.cmd("setlocal syntax=html")
          vim.opt_local.syntax = "html"
          vim.bo.filetype = "html"
        end,
      })
    end,
  },
}
