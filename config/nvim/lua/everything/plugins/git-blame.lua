return
{
	'f-person/git-blame.nvim',
	init = function()
		vim.g.gitblame_enabled = 1
		vim.g.gitblame_delay = 1000 -- 1 second
		vim.g.gitblame_set_extmark_options = {
            priority = 2000
        }
	end,
}
