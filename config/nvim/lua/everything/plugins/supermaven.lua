return {
    {
        "supermaven-inc/supermaven-nvim",
        opts = {
	        ignore_filetypes = {
	            oil = true,
	        },

            keymaps = {
                accept_suggestion = "<leader><Tab>",
                clear_suggestion = "<C-]>",
                accept_word = "<leader><leader><Tab>",
            },
        },
    },
}
