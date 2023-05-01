vim.g.beacon_enable = 1

vim.keymap.set("n", "n", "n:Beacon<CR>")
vim.keymap.set("n", "N", "N:Beacon<CR>")
vim.keymap.set("n", "*", "*:Beacon<CR>")
vim.keymap.set("n", "#", "#:Beacon<CR>")

vim.api.nvim_command("highlight Beacon guibg=white ctermbg=15")
