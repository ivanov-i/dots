-- indent tabs spaces
vim.opt.copyindent=true
vim.opt.expandtab=true
vim.opt.preserveindent=true
vim.opt.softtabstop=4
vim.opt.tabstop=4
vim.opt.shiftwidth=4

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

