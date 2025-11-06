return
{
    '3rd/diagram.nvim',
    cond = function()
        if vim.env.KITTY_WINDOW_ID ~= nil or vim.env.TERM == 'xterm-kitty' then return true end
        if vim.env.TMUX ~= nil then
            local ok, out = pcall(vim.fn.systemlist, { 'tmux', 'display', '-p', '#{client_termname}' })
            if ok and type(out) == 'table' and #out > 0 and out[1]:match('kitty') then return true end
        end
        return false
    end,
    dependencies = { '3rd/image.nvim' },
    ft = { 'markdown', 'norg', 'plantuml', 'd2', 'gnuplot', 'mermaid', 'mmd', },
    opts = {
        events = {
            render_buffer = { 'InsertLeave', 'BufWinEnter', 'TextChanged' },
            clear_buffer = { 'BufLeave' },
        },
        renderer_options = {
            mermaid = {
                scale = 20,
            }
        },
    },
    config = function(_, opts)
        local path = vim.env.PUPPETEER_EXECUTABLE_PATH
        if not path then
            local mac = {
                '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
                '/Applications/Chromium.app/Contents/MacOS/Chromium',
            }
            for _, p in ipairs(mac) do
                if vim.uv and vim.uv.fs_access and vim.uv.fs_access(p, 'X') then
                    path = p
                    break
                end
            end
            if not path then
                local exes = { 'google-chrome-stable', 'google-chrome', 'chromium' }
                for _, e in ipairs(exes) do
                    local exe = vim.fn.exepath(e)
                    if exe and exe ~= '' then
                        path = exe
                        break
                    end
                end
            end
        end
        if path then vim.env.PUPPETEER_EXECUTABLE_PATH = path end

        local r = require('diagram.renderers')
        local i = require('diagram.integrations')

        local mf = {
            id = 'mermaid-file',
            filetypes = { 'mermaid', 'mmd' },
            renderers = { r.mermaid },
            query_buffer_diagrams = function(buf)
                buf = buf or vim.api.nvim_get_current_buf()
                local n = vim.api.nvim_buf_line_count(buf)
                local ls = vim.api.nvim_buf_get_lines(buf, 0, n, false)
                local inb, tri = false, false
                local b = {}
                for _, ln in ipairs(ls) do
                    if not inb then
                        if ln:match('^%s*```%s*[Mm]ermaid%s*$') then inb = true; tri = true
                        elseif ln:match('^%s*:::%s*[Mm]ermaid%s*$') then inb = true; tri = false end
                    else
                        if (tri and ln:match('^%s*```%s*$')) or ((not tri) and ln:match('^%s*:::%s*$')) then break end
                        table.insert(b, ln)
                    end
                end
                local src = (#b > 0) and table.concat(b, '\n') or table.concat(ls, '\n')
                return {
                    {
                        bufnr = buf,
                        renderer_id = 'mermaid',
                        source = src,
                        range = { start_row = 0, start_col = 0, end_row = math.max(n - 1, 0), end_col = 0 },
                    },
                }
            end,
        }

        opts.integrations = { i.markdown, i.neorg, mf, }
        require('diagram').setup(opts)
    end,
    keys = {
        {
            '<leader>dh',
            function() require('diagram').show_diagram_hover() end,
            mode = 'n',
            ft = { 'markdown', 'norg', 'mermaid', 'mmd' },
            desc = 'Show diagram hover',
        },
    },
}
