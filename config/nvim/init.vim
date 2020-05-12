"" PLUGIN MANAGEMENT
packadd minpac
call minpac#init()

" Managed plugins (automatically installed and updated via "Pu" and "Pc")

"call minpac#add('k-takata/minpac', {'type': 'opt'})
"call minpac#add('vim-airline/vim-airline')
"call minpac#add('vim-airline/vim-airline-themes')
"call minpac#add('MarcWeber/vim-addon-mw-utils')
"call minpac#add('garbas/vim-snipmate')
"call minpac#add('honza/vim-snippets')
"call minpac#add('tpope/vim-repeat')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('morhetz/gruvbox')

command! Pu call minpac#update()
command! Pc call minpac#clean()

source $VIMCONFIG/fzf.vim
autocmd vimenter * colorscheme gruvbox
