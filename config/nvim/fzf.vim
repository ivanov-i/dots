" FZF fuzzy file search
set rtp+=/opt/homebrew/opt/fzf

"""" FZF - bind file fuzzy search to C-p
nnoremap <C-p> :<C-u>FZF<CR> 
nnoremap <leader>b :<C-u>Buffers<CR> 
nnoremap <leader>h :<C-u>History:<CR>
nnoremap <leader>g :<C-u>GFiles?<CR>
nnoremap <leader>/ :<C-u>BLines<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
