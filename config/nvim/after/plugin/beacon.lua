vim.g.beacon_shrink = 0
vim.g.beacon_minimal_jump = 5

vim.keymap.set("n", "n", "n:Beacon<CR>")
vim.keymap.set("n", "N", "N:Beacon<CR>")
vim.keymap.set("n", "*", "*:Beacon<CR>")
vim.keymap.set("n", "#", "#:Beacon<CR>")

vim.api.nvim_command("highlight Beacon guibg=white ctermbg=15")
