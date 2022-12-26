vim.g.mapleader = " "
vim.keymap.set("i", "jj", "<escape>")
vim.keymap.set("n", "<cr>", vim.cmd.nohl)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<space>", "<nop>")

-- move by screen lines when wrapping
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- buffers
vim.keymap.set("n", "]b", vim.cmd.bnext)
vim.keymap.set("n", "[b", vim.cmd.bprev)

