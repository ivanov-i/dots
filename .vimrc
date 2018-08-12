set nocompatible
imap jj <Esc>
set history=10000
set number
set ignorecase
set smartcase
set directory^=$HOME/.vim/tmp//
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set cindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set cursorline
set cmdheight=1
set showtabline=2
set winwidth=79
set scrolloff=3
set nobackup
set nowritebackup
set backspace=indent,eol,start
set showcmd
syntax on
filetype plugin indent on
set nojoinspaces
set autoread
set relativenumber number

set number
syntax enable
set background=dark
colorscheme gruvbox
set mouse=a

" Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
"autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"
