return
{
	'f-person/git-blame.nvim',
	init = function()
		vim.g.gitblame_enabled = 1
		vim.g.gitblame_delay = 1000 -- 1 second
	end,
}
