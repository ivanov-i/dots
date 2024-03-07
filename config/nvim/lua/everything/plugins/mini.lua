return
{
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        require('mini.animate').setup()
        require('mini.cursorword').setup()
    end
}
