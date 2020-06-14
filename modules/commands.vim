command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!


" Minimal Vim
function! Minimal()
  set showtabline=0
  set laststatus=0
  set nocursorline
  set colorcolumn=0
  " Goyo 120
endfunction
command! Minimal call Minimal()

" Back to maximal vim
function! Maximal()
  set list
  set number relativenumber
  set showtabline=2
  set cursorline
  set colorcolumn=81
endfunction
command! Maximal call Maximal()

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')
