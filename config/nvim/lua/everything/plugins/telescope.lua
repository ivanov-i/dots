return
{
	'nvim-telescope/telescope.nvim', -- tag = '0.1.0',
	-- or
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts =
	{
		defaults =
		{
			layout_strategy = 'vertical',
			layout_config = { width = 0.999, height = 0.999},
			mappings = {
                i = {
                    ["<Esc>"] = "close",
                },
		    },
		},
		pickers = {
			find_files = {
				follow = true
			},
			live_grep = {
				additional_args = {"--follow"}
			},
			grep_string = {
				additional_args = {"--follow"}
			}
		},
	},
	keys = {
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files({
                    attach_mappings = require("windovigation.telescope-utils").attach_mappings,
                })
            end,
            desc = "Find Files",
        },
        {
            "<leader>fF",
            function()
                require("telescope.builtin").find_files({
                    hidden = true,
                    no_ignore = true,
                    attach_mappings = require("windovigation.telescope-utils").attach_mappings,
                })
            end,
            desc = "Find hidden/ignored files",
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").live_grep({
                    attach_mappings = require("windovigation.telescope-utils").attach_mappings,
                })
            end,
            desc = "Live Grep",
        },
        {
            "<leader>w",
            function()
                require("telescope.builtin").grep_string({
                    attach_mappings = require("windovigation.telescope-utils").attach_mappings,
                })
            end,
            desc = "search current word",
        },
	},
}
