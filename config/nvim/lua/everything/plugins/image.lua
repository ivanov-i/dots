return
{
    '3rd/image.nvim',
    cond = function()
        if vim.env.KITTY_WINDOW_ID ~= nil or vim.env.TERM == 'xterm-kitty' then return true end
        if vim.env.TMUX ~= nil then
            local ok, out = pcall(vim.fn.systemlist, { 'tmux', 'display', '-p', '#{client_termname}' })
            if ok and type(out) == 'table' and #out > 0 and out[1]:match('kitty') then return true end
        end
        return false
    end,
    opts = {
        backend = 'kitty',
        -- max_width_window_percentage = 95,
        -- max_height_window_percentage = 90,
        scale_factor = 60.0,
    },
}
