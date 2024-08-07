return {
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({})
        end,
        keymaps = {
            accept_suggestion = "<leader><Tab>",
            clear_suggestion = "<C-]>",
            accept_word = "<C-j>",
        },
    },
}
