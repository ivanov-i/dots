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
vim.keymap.set("n", "[Q", ":cfirst<cr>")
vim.keymap.set("n", "]q", ":cnext<cr>")
vim.keymap.set("n", "[q", ":cprev<cr>")
vim.keymap.set("n", "]Q", ":clast<cr>")

-- russian
vim.keymap.set("i", "оо", "<escape>")

vim.keymap.set('n', '<leader><leader>', '<C-d>')

-- close all buffers except the current one
-- in vimscript it is:
-- command! BufOnly execute '%bdelete|edit #|normal `"'
vim.cmd("command! BufOnly execute '%bdelete|edit #|normal `\"'")
-- map it to <leader>q
vim.keymap.set("n", "<leader>q", ":BufOnly<cr>")

