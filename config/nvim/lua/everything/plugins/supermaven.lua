return {
    {
        "supermaven-inc/supermaven-nvim",
        opts = {
	        ignoredFiletypes = {
	            oil = true
	        },

            keymaps = {
                accept_suggestion = "<leader><Tab>",
                clear_suggestion = "<C-]>",
                accept_word = "<leader>j",
            },
        },
    },
}
