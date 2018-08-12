set nocompatible

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
    
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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
