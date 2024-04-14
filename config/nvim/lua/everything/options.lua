-- indent tabs spaces
vim.opt.copyindent=true
vim.opt.expandtab=true
vim.opt.preserveindent=true
vim.opt.softtabstop=4
vim.opt.tabstop=4
vim.opt.shiftwidth=4

vim.opt.scrolloff=10

vim.opt.inccommand="split"
vim.opt.pumblend=0
vim.opt.wildignorecase = true
vim.opt.path="$PWD/**"
vim.opt.visualbell = true
vim.opt.autoread = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- Maintain undo history between sessions
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.relativenumber = false
vim.opt.number = false
vim.opt.mouse="a"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- TextEdit might fail if hidden is not set.
vim.opt.hidden = true

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Give more space for displaying messages.
vim.opt.cmdheight=2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime=100
vim.opt.lazyredraw = true

-- Don't pass messages to |ins-completion-menu|.
-- vim.opt.shortmess+=c

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn="yes"


-- splits

vim.opt.splitbelow = true
vim.opt.splitright = true

-- russian
vim.opt.langmap="ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- don't stop search at the end of the file
vim.opt.wrapscan = true


-- disable folds
vim.opt.foldenable = false

-- giu font

vim.opt.guifont="VictorMono Nerd Font:h16"

-- neovide
if vim.g.neovide then
    -- copy paste
    vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<D-c>', '"+y') -- Copy
    vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

    -- Scale factor
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.25)
    end)

    -- 120 fps
    vim.g.neovide_refresh_rate = 120

    -- Cursor blink

end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-c>', '"+y', { noremap = true, silent = true})

--red cursor
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, 'Cursor', { fg = 'black', bg = 'red' })
vim.api.nvim_set_hl(0, 'Cursor2', { fg = 'black', bg = 'red' })
vim.opt.guicursor = {
    'n-v-c:block-Cursor/lCursor',
    'i-ci-ve:ver25-Cursor2/lCursor2',
    'r-cr:hor20',
    'o:hor50',
    'a:blinkwait700-blinkoff400-blinkon0-Cursor/lCursor',
}

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

