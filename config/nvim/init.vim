call plug#begin()

Plug 'stefandtw/quickfix-reflector.vim'

Plug 'jremmen/vim-ripgrep'
let g:rg_command = 'rg --vimgrep -S'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'lambdalisue/nerdfont.vim'
Plug 'dstein64/vim-startuptime'
" Plug 'junegunn/vim-peekaboo'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_grep = 'rg'
Plug 'tpope/vim-unimpaired'
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
" Plug 'itchyny/lightline.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'

Plug 'antoinemadec/FixCursorHold.nvim'
" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100

Plug '907th/vim-auto-save'
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

Plug 'tpope/vim-sleuth'

Plug 'gruvbox-community/gruvbox'
Plug 'bluz71/vim-moonfly-colors'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'cideM/yui'

Plug 'huyvohcmc/atlas.vim'
Plug 'karoliskoncevicius/distilled-vim'

Plug 'folke/which-key.nvim'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim'

call plug#end()

nnoremap <space> <Nop>
let g:mapleader="\<space>"

source $VIMCONFIG/fzf.vim

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF


set foldmethod=marker

if has("nvim")
    set inccommand=split
endif


" colorscheme moonfly
" colorscheme gruvbox
" colorscheme atlas
colorscheme distilled
set background=dark

" colorscheme yui
" let g:yui_comments = 'emphasize'

" let g:lightline = { 'colorscheme': 'moonfly' }
" let g:lightline.colorscheme = 'atlas'
" let g:lightline = { 'colorscheme': 'gruvbox' }
" let g:lightline.colorschem = 'distilled'


set pumblend=30
set wildignorecase

" Disable Autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set path=$PWD/**

" Blink cursor on error instead of beeping (grr)
set visualbell
set t_vb=

imap jj <Esc>
nmap <leader>gs :G<CR>
nnoremap <cr> :noh<CR><CR>:<backspace>
nnoremap Y y$

set timeoutlen=300
set undodir=~/.config/nvim/undodir
set undofile " Maintain undo history between sessions
set termguicolors
set norelativenumber
set nonumber
set mouse=a
set tabstop=4
set shiftwidth=4
let &softtabstop = &shiftwidth
let g:rustfmt_autosave = 1
set ignorecase
set smartcase
set colorcolumn=80

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set noswapfile

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
set lazyredraw

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes


" LSP

lua << EOF

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require'lspconfig'.rust_analyzer.setup{on_attach=require'completion'.on_attach}

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler


local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)

  require'completion'.on_attach(client)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', 'gr','<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', 'gi','<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- elseif client.resolved_capabilities.document_range_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- end
  
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    require('lspconfig').util.nvim_multiline_command [[
      :hi LspReferenceRead cterm=bold ctermbg=red guibg=Blue
      :hi LspReferenceText cterm=bold ctermbg=red guibg=Blue
      :hi LspReferenceWrite cterm=bold ctermbg=red guibg=Blue
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

EOF

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
set completeopt=

" Avoid showing message extra message when using completion
set shortmess+=c

" nnoremap <space> <C-d>
nnoremap <leader><leader> <C-d>

" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" highlight Cursor guifg=white guibg=steelblue
" highlight iCursor guifg=white guibg=steelblue
" set guicursor=n-v-c:block-Cursor
" set guicursor+=i:ver100-iCursor
" set guicursor+=n-v-c:blinkon0
" set guicursor+=i:blinkwait10
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

autocmd BufWritePost stdpath('config') source stdpath('config')

