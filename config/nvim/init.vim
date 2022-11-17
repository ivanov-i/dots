call plug#begin()

Plug 'stefandtw/quickfix-reflector.vim'

Plug 'jremmen/vim-ripgrep'
let g:rg_command = 'rg --vimgrep -S'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'lambdalisue/nerdfont.vim'
Plug 'dstein64/vim-startuptime'
" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_grep = 'rg'
Plug 'tpope/vim-unimpaired'
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
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

Plug 'kyazdani42/nvim-web-devicons'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim'

Plug 'lewis6991/gitsigns.nvim'

" 'Match 4 of 20' when searching
Plug 'henrik/vim-indexed-search'

" lets you do things like `vim file.txt:123`
Plug 'kopischke/vim-fetch'

"run command in tmux window
Plug 'benmills/vimux'
let g:VimuxOrientation = "h"
" map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>

"shows the context of the currently visible buffer contents
Plug 'wellle/context.vim'

"Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'karoliskoncevicius/distilled-vim'

"java

Plug 'williamboman/mason.nvim'
Plug 'mfussenegger/nvim-jdtls'

"rust

Plug 'folke/trouble.nvim'

if(has('nvim-0.7'))

  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'hrsh7th/cmp-path'
  " Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/nvim-cmp'

endif
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'

" Standalone UI for nvim-lsp progress. Eye candy for the impatient.
"Plug 'j-hui/fidget.nvim'

"Plug 'kosayoda/nvim-lightbulb'
" Plug 'm-demare/hlargs.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'simrat39/rust-tools.nvim'
Plug 'weilbith/nvim-code-action-menu'
Plug 'williamboman/nvim-lsp-installer'

call plug#end()

nnoremap <space> <Nop>
let g:mapleader="\<space>"

let configpath = stdpath('config')

let fzfpath = configpath . "/fzf.vim"
execute 'source '.fnameescape(fzfpath)

set foldmethod=marker

if has("nvim")
    set inccommand=split
endif

colorscheme distilled

" lua << EOF
" vim.g.tokyonight_transparent = true
" vim.g.tokyonight_transparent_sidebar = true
" EOF

"colorscheme tokyonight
hi Normal guibg=NONE ctermbg=NONE

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

" Scrolling/Line movement

" move by screen lines when wrapping
nnoremap gj j
nnoremap gk k
nnoremap j gj
nnoremap k gk

" move by actual lines when count
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

"paste and keep the register contents
xnoremap <leader>p "_dP

set breakindent
" set timeoutlen=500
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
" set colorcolumn=80

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


" splits

set splitbelow
set splitright

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

EOF

"autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

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

"gitsigns
lua require('gitsigns').setup()
"set color to be the same as comment
highlight link GitSignsCurrentLineBlame Comment
Gitsigns toggle_current_line_blame

"java

lua << EOF
require("mason").setup()
EOF

"rust

" ------------------------------------
" j-hui/fidget.nvim
" ------------------------------------
"
"lua require("fidget").setup()

" ------------------------------------
" kosayoda/nvim-lightbulb
" ------------------------------------
"
"autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()

" ------------------------------------
" weilbith/nvim-code-action-menu
" ------------------------------------
"
let g:code_action_menu_window_border = 'single'

" ------------------------------------
" folke/trouble.nvim
" ------------------------------------
"
lua require("trouble").setup()

" ------------------------------------
" Neovim LSP
" ------------------------------------
"
" Configure Rust LSP.
"
" https://github.com/simrat39/rust-tools.nvim#configuration
"
lua <<EOF
local opts = {
  -- rust-tools options
  tools = {
    autoSetHints = true,
--    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
      },
    },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  -- https://rust-analyzer.github.io/manual.html#features
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      --vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      --vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate"
          },
        cargo = {
          allFeatures = true
          },
        checkOnSave = {
          -- default: `cargo check`
          command = "clippy"
          },
        },
        inlayHints = {
          lifetimeElisionHints = {
            enable = true,
            useParameterNames = true
          },
        },
      }
    },
}
require('rust-tools').setup(opts)

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
EOF

" Configure LSP code navigation shortcuts
" as found in :help lsp
"
nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gc        <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gn        <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gs        <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gw        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Replaced LSP implementation with code action plugin...
"
" nnoremap <silent> ga        <cmd>lua vim.lsp.buf.code_action()<CR>
"
nnoremap <silent> ga        <cmd>CodeActionMenu<CR>

nnoremap <silent> [x        <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]x        <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> ]s        <cmd>lua vim.diagnostic.show()<CR>

" Replaced LSP implementation with trouble plugin...
"
" nnoremap <silent> <space>q  <cmd>lua vim.diagnostic.setloclist()<CR>
"
nnoremap <silent> <space>q  <cmd>Trouble<CR>

" Setup Completion
" https://github.com/hrsh7th/nvim-cmp#recommended-configuration
"
if(has('nvim-0.7'))
  lua <<EOF
  local cmp = require('cmp')
  cmp.setup(
  {
      completion = {
        autocomplete = false,
        },
      snippet = {
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
        end,
        },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
        })
      },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'nvim_lsp_signature_help' },
      },
  })
EOF
endif

" Setup Treesitter and friends
"
" NOTE: originally used `ensure_installed = "all"` but an experimental PHP
" parser was causing NPM lockfile errors.
"
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "c", "cmake", "css", "dockerfile", "go", "gomod", "gowork", "hcl", "help", "html", "http", "javascript", "json", "lua", "make", "markdown", "python", "regex", "ruby", "rust", "toml", "vim", "yaml", "zig" },
  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  }
}
-- require('hlargs').setup()
EOF

syntax off
