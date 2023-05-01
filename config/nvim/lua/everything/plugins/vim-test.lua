return
{
	-- make test commands execute using dispatch.vim

	'vim-test/vim-test',
	init = function ()

		vim.g["test#strategy"] = "neovim"

		vim.keymap.set("n", "<leader>t", ":TestNearest<cr>")
		vim.keymap.set("n", "<leader>T", ":TestFile<cr>")
		vim.keymap.set("n", "<leader>a", ":TestSuite<cr>")
		-- vim.keymap.set("n", "<leader>l", ":TestLast<cr>")
		vim.keymap.set("n", "<leader>g", ":TestVisit<cr>")
	end
}

