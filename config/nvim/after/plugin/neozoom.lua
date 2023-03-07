require('neo-zoom').setup {
}
vim.keymap.set('n', '<leader>z', function () vim.cmd('NeoZoomToggle') end, { silent = true, nowait = true })
