"==============================================================================
" Name Of File: dwm.vim
"  Description: Dynamic Window Manager behaviour for Vim
"   Orignal Author: Stanislas Polu (polu.stanislas at gmail dot com)
"   EDITS: 20jam
" Last Changed: Tuesday, 19 May 2020
"      Version: See g:dwm_version for version number.
"        Usage: This file should reside in the plugin directory and be
"               automatically sourced.
"
"               For more help see supplied documentation.
"      History: See supplied documentation.
"==============================================================================

" Exit quickly if already running
if exists("g:dwm_version") || &diff || &cp
  finish
endif

let g:dwm_version = "0.1.2"

" All layout transformations assume the layout contains one master pane on the
" left and an arbitrary number of stacked panes on the right
" +--------+--------+
" |        |   S1   |
" |        +--------+
" |   M    |   S3   |
" |        +--------+
" |        |   S3   |
" +--------+--------+

" Move the current master pane to the stack
function! DWM_Stack(clockwise)
  1wincmd w
  if a:clockwise
    " Move to the top of the stack
    wincmd K
  else
    " Move to the bottom of the stack
    wincmd J
  endif
  " At this point, the layout *should* be the following with the previous master
  " at the top.
  " +-----------------+
  " |        M        |
  " +-----------------+
  " |        S1       |
  " +-----------------+
  " |        S2       |
  " +-----------------+
  " |        S3       |
  " +-----------------+
endfunction

" Add a new buffer
function! DWM_New()
  " Move current master pane to the stack
  call DWM_Stack(1)
  " Create a vertical split
  vert topleft new
  call DWM_ResizeMasterPaneWidth()
endfunction

" Move the current window to the master pane (the previous master window is
" added to the top of the stack). If current window is master already - switch
" to stack top
function! DWM_Focus()
  if winnr('$') == 1
    return
  endif

  if winnr() == 1
    wincmd w
  endif

  let l:curwin = winnr()
  call DWM_Stack(1)
  exec l:curwin . "wincmd w"
  wincmd H
  call DWM_ResizeMasterPaneWidth()
endfunction

" Handler for BufWinEnter autocommand
" Recreate layout broken by new window
function! DWM_AutoEnter()
  if winnr('$') == 1
    return
  endif

  " Skip buffers without filetype
  if !len(&l:filetype)
    return
  endif

  " Skip quickfix buffers
  if &l:buftype == 'quickfix'
    return
  endif

  " Move new window to stack top
  wincmd K

  " Focus new window (twice :)
  call DWM_Focus()
  call DWM_Focus()
endfunction

" Close the current window
function! DWM_Close()
  if winnr() == 1
    " Close master panel.
    return 'close | wincmd H | call DWM_ResizeMasterPaneWidth()'
  else
    return 'close'
  end
endfunction

function! DWM_ResizeMasterPaneWidth()
  " Make all windows equally high and wide
  wincmd =

  " resize the master pane if user defined it
  if exists('g:dwm_master_pane_width')
    if type(g:dwm_master_pane_width) == type("")
      exec 'vertical resize ' . ((str2nr(g:dwm_master_pane_width)*&columns)/100)
    else
      exec 'vertical resize ' . g:dwm_master_pane_width
    endif
  endif
endfunction

function! DWM_GrowMaster()
  if winnr() == 1
    exec "vertical resize +1"
  else
    exec "vertical resize -1"
  endif
  if exists("g:dwm_master_pane_width") && g:dwm_master_pane_width
    let g:dwm_master_pane_width += 1
  else
    let g:dwm_master_pane_width = ((&columns)/2)+1
  endif
endfunction

function! DWM_ShrinkMaster()
  if winnr() == 1
    exec "vertical resize -1"
  else
    exec "vertical resize +1"
  endif
  if exists("g:dwm_master_pane_width") && g:dwm_master_pane_width
    let g:dwm_master_pane_width -= 1
  else
    let g:dwm_master_pane_width = ((&columns)/2)-1
  endif
endfunction

function! DWM_Rotate(clockwise)
  call DWM_Stack(a:clockwise)
  if a:clockwise
    wincmd W
  else
    wincmd w
  endif
  wincmd H
  call DWM_ResizeMasterPaneWidth()
endfunction

nnoremap <silent> <Plug>DWMRotateCounterclockwise :call DWM_Rotate(0)<CR>
nnoremap <silent> <Plug>DWMRotateClockwise        :call DWM_Rotate(1)<CR>

nnoremap <silent> <Plug>DWMNew   :call DWM_New()<CR>
nnoremap <silent> <Plug>DWMClose :exec DWM_Close()<CR>
nnoremap <silent> <Plug>DWMFocus :call DWM_Focus()<CR>

nnoremap <silent> <Plug>DWMGrowMaster   :call DWM_GrowMaster()<CR>
nnoremap <silent> <Plug>DWMShrinkMaster :call DWM_ShrinkMaster()<CR>

if !exists('g:dwm_map_keys')
  let g:dwm_map_keys = 1
endif

if g:dwm_map_keys
  nnoremap <C-J> <C-W>w
  nnoremap sj <C-W>w
  nnoremap <C-K> <C-W>W
  nnoremap sk <C-W>W

  if !hasmapto('<Plug>DWMRotateCounterclockwise')
      nmap <C-,> <Plug>DWMRotateCounterclockwise
      nmap s, <Plug>DWMRotateCounterclockwise
  endif
  if !hasmapto('<Plug>DWMRotateClockwise')
      nmap <C-.> <Plug>DWMRotateClockwise
      nmap s. <Plug>DWMRotateClockwise
  endif

  if !hasmapto('<Plug>DWMNew')
      nmap <C-N> <Plug>DWMNew
      nmap sv <Plug>DWMNew
  endif
  if !hasmapto('<Plug>DWMClose')
      nmap <C-C> <Plug>DWMClose
      nmap sd <Plug>DWMClose
  endif
  if !hasmapto('<Plug>DWMFocus')
      nmap <C-@> <Plug>DWMFocus
      nmap <C-Space> <Plug>DWMFocus
      nmap ss <Plug>DWMFocus
  endif

  if !hasmapto('<Plug>DWMGrowMaster')
      nmap <C-L> <Plug>DWMGrowMaster
      nmap sl <Plug>DWMGrowMaster
  endif
  if !hasmapto('<Plug>DWMShrinkMaster')
      nmap <C-H> <Plug>DWMShrinkMaster
      nmap sh <Plug>DWMShrinkMaster
  endif
endif

if has('autocmd')
  augroup dwm
    au!
    au BufWinEnter * if &l:buflisted || &l:filetype == 'help' | call DWM_AutoEnter() | endif
  augroup end
endif

