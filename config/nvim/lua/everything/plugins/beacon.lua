return
{
	'danilamihailov/beacon.nvim',
	init = function()
		vim.g.beacon_enable = 1
		vim.keymap.set("n", "n", "n:lua require('beacon').highlight_cursor()<CR>Nn")
		vim.keymap.set("n", "N", "N:lua require('beacon').highlight_cursor()<CR>Nn")
		vim.keymap.set("n", "*", "*:lua require('beacon').highlight_cursor()<CR>Nn")
		vim.keymap.set("n", "#", "#:lua require('beacon').highlight_cursor()<CR>Nn")

		vim.api.nvim_command("highlight Beacon guibg=white ctermbg=15")
	end,
}
