vim.g.mapleader = " "
vim.keymap.set("i", "jj", "<escape>")
vim.keymap.set("n", "<cr>", ":nohl<cr>")
vim.keymap.set("n", "<leader>pv", ":Ex<cr>")
vim.keymap.set("n", "<space>", "<nop>")

-- move by screen lines when wrapping
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- buffers
vim.keymap.set("n", "]b", ":bnext<cr>")
vim.keymap.set("n", "[b", ":bprev<cr>")

-- russian
vim.keymap.set("i", "оо", "<escape>")

vim.keymap.set('n', '<leader>w', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })

