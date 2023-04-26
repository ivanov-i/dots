require('telescope').setup{
	defaults = {
		path_display=
			{
				shorten=3,
			},
	}
}
local builtin = require('telescope.builtin')
pcall(require('telescope').load_extension, 'fzf')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>w', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })

vim.api.nvim_command([[
autocmd User TelescopePreviewerLoaded setlocal wrap
]])
