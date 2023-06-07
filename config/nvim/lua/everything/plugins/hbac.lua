return
{
	'axkirillov/hbac.nvim',
	dependencies = {
		-- these are optional, add them, if you want the telescope module
		'nvim-telescope/telescope.nvim',
		'nvim-lua/plenary.nvim',
		-- 'nvim-tree/nvim-web-devicons'
	},
	opts =
	{
		autoclose = true, -- set autoclose to false if you want to close manually
		threshold = 10 -- hbac will start closing unedited buffers once that number is reached
	}
}
