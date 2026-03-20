return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          lmstudio = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "lmstudio",
              env = {
                url = "http://localhost:1234",
                api_key = "lmstudio",
              },
              schema = {
                model = {
                  default = "qwen3-vl-4b-instruct",
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = { adapter = "lmstudio" },
        inline = { adapter = "lmstudio" },
        agent = { adapter = "lmstudio" },
      },
    })

    -- Keymaps
    vim.keymap.set({ "n", "v" }, "<leader>a", "", { desc = "AI" })
    vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })
    vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "Inline AI" })
    vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
  end,
}
