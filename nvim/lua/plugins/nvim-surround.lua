return
{
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            keymaps = {

                normal = "gs"

            }
            -- Configuration here, or leave empty to use defaults
        })
    end
}
