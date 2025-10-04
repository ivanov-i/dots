return
{
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory', 'DiffviewRefresh', 'DiffviewLog' },
    keys = {
        { '<leader>gv', '<cmd>DiffviewOpen<cr>', desc = 'diffview open' },
        { '<leader>gV', '<cmd>DiffviewClose<cr>', desc = 'diffview close' },
        { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'diffview history repo' },
        { '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', desc = 'diffview history file' },
        { '<leader>gt', '<cmd>DiffviewToggleFiles<cr>', desc = 'diffview toggle files' },
    },
    opts = {
        enhanced_diff_hl = true,
        view = {
            merge_tool = { layout = 'diff4_mixed' },
        },
    },
}
