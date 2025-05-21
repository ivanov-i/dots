return
{
	'nvim-telescope/telescope.nvim',
	-- tag = '0.1.0',
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
}
