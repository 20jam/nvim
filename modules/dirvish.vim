augroup DirvishMappings
  autocmd!
  autocmd FileType dirvish 
        \  nmap <buffer><silent> l :<C-U>.call dirvish#open('edit', 0)<CR>
        \| nmap <buffer><silent> h <Plug>(dirvish_up)
        \| nmap <buffer><silent> J <Plug>(dirvish_up)
        \| nmap <buffer><silent> gs <Plug>(dirvish_up)
        \| nmap <buffer><silent> - <Plug>(dirvish_up)
        \| nmap <buffer><silent> i /
        \| nmap <buffer> c :DirvishCopy<cr>
        \| nmap <buffer> r :DirvishRename<cr>
        \| nmap <buffer> mv :DirvishMove<cr>
        \| nmap <buffer> dd :DirvishDelete<cr>
        \| nmap <buffer> mkd :DirvishMkdir<cr>
        \| nmap <buffer> mkf :DirvishFile<cr>
        \| nmap <buffer><silent> sd gq
        \| nmap <buffer> + ":<c-u>edit ".expand("%:.")
        \| setlocal colorcolumn=
        \| setlocal statusline=%f
augroup END

function! s:copy()
  let from = getline('.')
  let extension = substitute(l:from, '.*/[^\.]*\(.\{-}\)$', '\1', '')
  let move_cursor = substitute(l:extension, '.', "\<left>", 'g')
  call inputsave()
  let to = input('!cp -r ' . l:from . ' -> ', l:from . l:move_cursor, 'file')
  call inputrestore()
  redraw!
  if !empty(l:to)
    silent exec ('!cp -r ' . l:from . ' ' . l:to)
    call append(line('.') - 1, l:to)
    normal k
    " Dirvish %
  endif
endfunction

function! s:move()
  let from = getline('.')
  let extension = substitute(l:from, '.*/\(.\{-}\)$', '\1', '')
  let move_cursor = substitute(l:extension, '.', "\<left>", 'g')
  call inputsave()
  let to = input('!mv ' . l:from . ' -> ', l:from . l:move_cursor, 'file')
  call inputrestore()
  redraw!
  if !empty(l:to)
    silent exec ('!mv ' . l:from . ' ' . l:to)
    call setline('.', l:to)
  endif
endfunction

function! s:rename()
  let from = getline('.')
  let dir_name = substitute(l:from, '\(.*/\).\{-}$', '\1', '')
  let file_name = substitute(l:from, '.*/\(.\{-}\)$', '\1', '')
  let extension = substitute(l:from, '.*/[^\.]*\(.\{-}\)$', '\1', '')
  let move_cursor = substitute(l:extension, '.', "\<left>", 'g')
  call inputsave()
  let to = input('!mv ' . l:from . ' -> '. l:dir_name, l:file_name . l:move_cursor, 'file')
  call inputrestore()
  redraw!
  if !empty(l:to)
    silent exec ('!mv ' . l:from . ' ' . l:dir_name . l:to)
    call setline('.', l:dir_name . l:to)
  endif
endfunction

function! s:delete()
  let file = getline('.')
  call inputsave()
  let confirm = input('!rm -fr ' . l:file . ' // Are you sure? [yes|no]: ')
  call inputrestore()
  redraw!
  if l:confirm == 'yes' || l:confirm == 'y'
    silent exec ('!rm -fr ' . l:file)
    silent! exec ('bd! ' . l:file)
    Dirvish %
  endif
endfunction

function! s:file()
  let from = expand('%:p')
  call inputsave()
  let to = input('e ', l:from, 'file')
  call inputrestore()
  redraw!
  if !empty(l:to)
    silent exec ('e ' . l:to)
  endif
endfunction

function! s:mkdir()
  let from = expand('%:p')
  call inputsave()
  let to = input('!mkdir -p ', l:from, 'file')
  call inputrestore()
  redraw!
  if !empty(l:to)
    silent exec ('!mkdir -p ' . l:to)
    Dirvish %
  endif
endfunction

command! DirvishMkdir call s:mkdir()
command! DirvishCopy call s:copy()
command! DirvishRename call s:rename()
command! DirvishMove call s:move()
command! DirvishDelete call s:delete()
command! DirvishFile call s:file()
