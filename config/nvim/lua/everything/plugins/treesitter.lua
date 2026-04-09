return {
	'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	lazy = false,
	config = function()
		require('everything.treesitter').setup()
	end,
}
