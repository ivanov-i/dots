return
{
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        -- require('mini.animate').setup()
        require('mini.cursorword').setup()
        require('mini.indentscope').setup(
        {
            symbol = "┊",
            draw =
            {
                delay = 1000,
                animation = require('mini.indentscope').gen_animation.none();
            }
        })
    end
}
