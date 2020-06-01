set termguicolors
function s:PincActive()
  try
    call pinnacle#highlight({})
    return 1
  catch /E117/
    " Pinnacle probably isn't loaded
    return 0
  endtry
endfunction

function s:RemoveBg(group)
  if !s:PincActive()
    return
  endif

  let l:highlight=filter(pinnacle#dump(a:group), 'v:key != "bg"')
  execute 'highlight! clear ' . a:group
  execute 'highlight! ' . a:group . ' ' . pinnacle#highlight(l:highlight)
endfunction

function s:CheckColorScheme()
  if !has('termguicolors')
    let g:base16colorspace=256
  endif
" Old setup
" let s:config_file = expand('~/.local/share/shelltheme')
" if filereadable(s:config_file)
"   let s:config = readfile(s:config_file, '', 2)
"
"   if s:config[1] =~# '^dark\|light$'
"     execute 'set background=' . s:config[1]
"   else
"     echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
"   endif
"
"    if filereadable(expand('~/.cache/nvim/dein/repos/github.com/chriskempson/base16-vim/colors/base16-' . s:config[0] . '.vim'))
"     execute 'colorscheme base16-' . s:config[0]
"   else
"     echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
"   endif
" else " default
"   set background=dark
"   colorscheme base16-tomorrow
" endif
" New setup
source $VIM_PATH/bin/scheme
  if s:PincActive()
    execute 'highlight Comment ' . pinnacle#italicize('Comment')
  execute 'highlight link EndOfBuffer ColorColumn'
  endif
  doautocmd ColorScheme

  " Hide (or at least make less obvious) the EndOfBuffer region
  highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

  " Sync with corresponding non-nvim 'highlight' settings in settings.vim:
  highlight clear NonText
  highlight link NonText Conceal
  if s:PincActive()
    highlight clear CursorLineNr
    execute 'highlight CursorLineNr ' . pinnacle#extract_highlight('DiffText')
  endif

  highlight clear DiffDelete
  highlight link DiffDelete Conceal
  highlight clear VertSplit
  highlight link VertSplit LineNr

  " Resolve clashes with ColorColumn.
  " Instead of linking to Normal (which has a higher priority, link to nothing).
  highlight link vimUserFunc NONE

  " For Git commits, suppress the background of these groups:
  " for l:group in ['DiffAdded', 'DiffFile', 'DiffNewFile', 'DiffLine', 'DiffRemoved']
  "   call s:RemoveBg(l:group)
  " endfor

  " More subtle highlighting during merge conflict resolution.
  highlight clear DiffAdd
  highlight clear DiffChange
  highlight clear DiffText

  if s:PincActive()
    let l:highlight=pinnacle#italicize('ModeMsg')
    execute 'highlight User8 ' . l:highlight
  endif

  " Allow for overrides:
  hi Normal guibg=NONE ctermbg=NONE
  " highlight LineNr ctermfg=NONE ctermbg=NONE
  highlight clear LineNr
  highlight clear SignColumn
  highlight SignifySignAdd guibg=NONE
  highlight SignifySignDelete guibg=NONE
  highlight SignifySignChange guibg=NONE
  highlight Folded gui=italic guibg=NONE
  highlight Comment gui=italic guibg=NONE
  "
endfunction

call s:CheckColorScheme()
" Not needed and cuasing issue when switching out/in
" if v:progname !=# 'vi'
"   if has('autocmd')
"     augroup Autocolor
"       autocmd!
"       autocmd FocusGained * call s:CheckColorScheme()
"     augroup END
"   endif
" 
"   call s:CheckColorScheme()
" endif
