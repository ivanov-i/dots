" FZF fuzzy file search
set rtp+=/opt/homebrew/opt/fzf

" search word under cursor

command! -bang -nargs=* RgExact
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


"""" FZF - bind file fuzzy search to C-p
nnoremap <leader>ff :<C-u>FZF<CR>
nnoremap <leader>fg :<C-u>RG<CR>
nnoremap <leader>b :<C-u>Buffers<CR>
nnoremap <leader>h :<C-u>History:<CR>
nnoremap <leader>g :<C-u>GFiles?<CR>
nnoremap <leader>/ :<C-u>BLines<CR>
nnoremap <Leader>w :execute 'RgExact ' . expand('<cword>') <Cr>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
