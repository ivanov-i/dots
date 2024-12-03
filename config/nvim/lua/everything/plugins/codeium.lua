return {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function ()
        vim.g.codeium_no_map_tab = true
        vim.keymap.set('i', '<leader><Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.g.codeium_filetypes = {
            gitcommit = true,
            gitrebase = true,
        }
    end,
}
