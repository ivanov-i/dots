return {
	'natecraddock/telescope-zf-native.nvim',
	dependencies = {'nvim-telescope/telescope.nvim'},
	config = function ()
		pcall(require('telescope').load_extension, 'zf-native')
		vim.api.nvim_command([[
			autocmd User TelescopePreviewerLoaded setlocal wrap
		]])
	end
}
