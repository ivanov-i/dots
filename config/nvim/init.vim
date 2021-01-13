"" PLUGIN MANAGEMENT{{{
"packadd minpac
"call minpac#init()

call plug#begin()

let g:lightline = { 'colorscheme': 'gruvbox' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'rust-lang/rust.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'dstein64/vim-startuptime'
Plug 'junegunn/vim-peekaboo'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_grep = 'rg'
Plug 'tpope/vim-unimpaired'
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'

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

call plug#end()
" }}} plugins

set foldmethod=marker

if has("nvim")
    set inccommand=split
endif

"let g:airline#extensions#tabline#enabled = 1

"colorscheme moonfly
colorscheme gruvbox
set background=dark

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
"nnoremap zz :update<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => NERDTree 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Changes NerdTree Toggle to Ctrl + n
"map <C-n> :NERDTreeToggle<CR> 
""autocmd VimEnter * NERDTree "Toggles Nerdtree on vim open
"let NERDTreeQuitOnOpen = 1 "closes NerdTree when opening a file

" source $VIMCONFIG/fzf.vim

set undodir=~/.config/nvim/undodir
set undofile " Maintain undo history between sessions
set termguicolors
set relativenumber
set number
"set ttymouse=xterm2
set mouse=a
set tabstop=4
set shiftwidth=4
let &softtabstop = &shiftwidth
let g:rustfmt_autosave = 1
set ignorecase
set smartcase

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

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
