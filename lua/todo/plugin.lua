return {
    "renancavalcantercb/todo.nvim",
    dependencies = {
        "folke/which-key.nvim",
    },
    config = function()
        require("todo").setup()
    end,
} 