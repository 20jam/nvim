" modules#mappings#OpenLinkUnderCursor()
" modules#mappings#GetSelection
" modules#mappings#ToggleNumber
function modules#mappings#OpenBrowser(tag, url)

  let app = g:browser
  if app =~ 'Firefox'
    let app = 'firefox'
  endif

  if a:url == ""
    let url = input('Search: ')
  else
    let url = a:url
  end

  call system( app . ' "' . a:tag . ' ' . url . '" &' )

endfunction

function! modules#mappings#ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

function! modules#mappings#CycleNumbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!
  endif
endfunction

function! modules#mappings#matchparen() abort
  " Preserve current window because {Do,No}MatchParen cycle with :windo.
  let l:currwin=winnr()
  if exists('g:loaded_matchparen')
    NoMatchParen
  else
    DoMatchParen
  endif
  execute l:currwin . 'wincmd w'
endfunction

" Zap trailing whitespace.
function! modules#mappings#DeleteWhiteSpace() abort
  call wincent#functions#substitute('\s\+$', '', '')
endfunction

function! modules#mappings#GetSelection(cmdtype) " ((
" "This is used to replace highlighted text in nm vm"
  let temp = @s
  normal! gv"sy
  let @/ = substitute(escape(@s, '\' . a:cmdtype), '\n', '\\n', 'g')
  let @s = temp
endfunction
"
