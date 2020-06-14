nm ; <leader>
xm ; <leader>
" Fix keybind name for Ctrl+Space
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Command Mode {{{

" //////////////////////////////////////////////////
cno jk <esc>
cno <C-a> <Home>
cno <C-b> <Left>
cno <C-d> <Del>
cno <C-e> <End>
cno <C-f> <Right>
cno <C-h> <BS>
cno <C-p> <Up>
cno <C-t> <C-R>=expand("%:p:h") . "/" <CR>
" //////////////////////////////////////////////////

" }}}
" Insert Mode {{{
" //////////////////////////////////////////////////
iab xdate <C-r>=strftime("%m/%d/20%y")<cr>
ino <C-O> <Esc>o
ino <C-a> <ESC>^i
ino <C-b> <Left>
ino <C-d> <Del>
ino <C-f> <Right>
ino <C-h> <BS>
ino <C-k>  <ESC>d$a
ino <C-u> <C-G>u<C-U>
ino <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"
ino jj <esc>
ino jk <esc>
" //////////////////////////////////////////////////

" }}}
" Visual Mode {{{

" //////////////////////////////////////////////////
vn <leader>d YPgv
vn <leader>l y:execute @@<CR>:echo 'Sourced selection.'<CR>
vn <silent>J :m'>+<CR>gv=gv
vn <silent>K :m-2<CR>gv=gv
vnoremap <silent><expr> k       v:count == 0 ? 'gk' : 'k'
vnoremap <silent><expr> j       v:count == 0 ? 'gj' : 'j'
vmap < <gv
vmap > >gv
nnoremap < <<
nnoremap > >>
vmap <c-k> >gv
vmap <c-j> <gv
xn <C-r> :<C-u>call modules#mappings#GetSelection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>
xn <S-Tab> <gv
xn <Tab> >gv|
"xn <leader>v <esc>
xn <silent>H 0
xn <silent>L $
" //////////////////////////////////////////////////

" }}}
" Normal Mode
" G Key {{{

" //////
nn g! :<C-u>put=execute('')<Left><Left>
nn <silent>- <cmd>Dirvish<cr>
nn <silent>ge G
nn <silent>gb <c-o>
" //////

" }}}
" S Key {{{

" //////
"nn ss <cmd>b#<cr>
" nn <leader>s <cmd>b#<cr>
nn ss <cmd>b#<cr>
" nn sc <cmd>WintabsClose<cr>
" nn s<esc> <cmd>WintabsClose<cr>
" nn sk <cmd>bn<cr>
" nn sj <cmd>bp<cr>

nn sc <cmd>q<cr>
" Macros
" nnoremap Q q
" nnoremap gQ @q

" Ultimatus Quitos
autocmd BufWinEnter * if &buftype == ''
	"\ | nnoremap <silent><buffer> q :quit<CR>
	\ | nnoremap <silent><buffer> sc :quit<CR>
	\ | endif

nn so <cmd>only<cr>
nn <silent>sD <cmd>WintabsOnly<cr>
nn sv <cmd>vs<cr>
nn sf <cmd>sp<cr>

nn <leader>k <cmd>tabnext<cr>
nn <leader>j <cmd>tabprevious<cr>
nn <leader>K <cmd>tablast<cr>
nn <leader>J <cmd>tabfirst<cr>
nn s; <cmd>tabnext<CR>
nn sg <cmd>tabprevious<CR>
nn s: <cmd>tablast<cr> 
nn sG <cmd>tabfirst<cr>

" nn sp <cmd>WintabsCloseVimtab<>
nn s\ <cmd>tabnew<CR>

" //////

" }}}
" Prefix {{{

" //////
nn <silent><C-h> :noh<CR>
" nn <silent><tab> za
nn <silent><C-j> <cmd>wincmd w<cr>
nn <silent><C-k> <cmd>wincmd W<cr>
nn <silent><C-n> <cmd>cn<cr>
nn <silent><C-p> <cmd>cp<cr>
" c-o/c-i: next/previous edited position
nn <c-o> <c-o>zz
noremap <C-p> <c-i>zz
nnoremap <Backspace> <C-o>zz
nnoremap <Cr> <C-i>zz
nn <c-i> za
nn n nzz
nn N Nzz
nn * *zz
nn # #zz

" //////

" }}}
" Leader {{{

" //////
" Lazy-shift 
" TODO: toggle off/on statusbar and tabline
nn <leader>i I
nn <leader>v V
nn <leader><leader> V
nn <leader>a A
nn <leader>8 *
xn <leader>8 *
nn <silent><leader>, :e ./TODO<CR>
nn <leader>cc :lcd <C-R>=expand('%:p:h') . '/'<CR>
nn <leader>d m`YP``
nn <leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
nn <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nn <leader>w <cmd>write<cr>
nn <leader><Tab> zMzvzz
nn zm zM 
nn <leader>; :
nn <esc>  gt
" nn <leader><leader> :
xn <leader><leader> :
nn <leader>l :BLines<CR>
nn <silent><Leader>pl  :echo dein#get_updates_log()<CR>
nn <silent><Leader>pr  :call dein#recache_runtimepath()<CR>
nn <silent><Leader>pu  :call dein#update()<CR>
" nn <silent><leader>la :update<CR>:so $MYVIMRC<CR>
nn <silent><leader>pp ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>
nn <silent><leader>pt<cmd>1,$s/\t/  /g<cr>
nn <silent><leader>tn <Cmd>ToggleNumber<CR>
" noremap <leader>sg :Ggrep<space>
noremap <leader>sg :Lines<CR>
noremap <leader>ss :BLines<CR>
noremap <leader>sj :JumpBLines<CR>
" nn <silent><leader>tt :TodoistInit<CR>

" nn <leader>j <cmd>wincmd w<cr>
" nn <leader>k <cmd>wincmd W<cr>
" //////

" }}}
" Letters {{{

" nn \ :Ag<space>
" nn <BS> %
nn <expr> zz (winline() == (winheight(0)+1) / 2) ? 'zt' : (winline() == 1) ? 'zb' : 'zz'
nn [l :lprev<CR>
nn [q :cprev<CR>
nn ]l :lnext<CR>
nn ]q :cnext<CR>
nn cN *``cgN
nn cn *``cgn
"nn bd <cmd>bd<CR>
nn ! :!
"nn ' :
"nn ;; :
nn H 0
nn L $
nn U <C-r>
nn Y y$
nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>
nnoremap <silent><expr> k       v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr> j       v:count == 0 ? 'gj' : 'j'
" }}}
" Plugins {{{
if dein#tap('accelerated-jk')
  nm <silent>j <Plug>(accelerated_jk_gj)
  nm <silent>k <Plug>(accelerated_jk_gk)
endif
if dein#tap('vim-asterisk')
  map *   <Plug>(asterisk-g*)
  map g*  <Plug>(asterisk-*)
  map #   <Plug>(asterisk-g#)
  map g#  <Plug>(asterisk-#)

  map z*  <Plug>(asterisk-z*)
  map gz* <Plug>(asterisk-gz*)
  map z#  <Plug>(asterisk-z#)
  map gz# <Plug>(asterisk-gz#)
endif
if dein#tap('vim-smoothie')
  nnoremap <silent> <C-f> :<C-U>call smoothie#forwards()<CR>
  nnoremap <silent> <C-b> :<C-U>call smoothie#backwards()<CR>
  nnoremap <silent> <C-d> :<C-U>call smoothie#downwards()<CR>
  nnoremap <silent> <C-u> :<C-U>call smoothie#upwards()<CR>
endif
if dein#tap('vim-easymotion')
  "nmap sg <Plug>(easymotion-overwin-f)
  nmap gj <Plug>(easymotion-w)
  nmap gk <Plug>(easymotion-b)
endif

nnoremap <silent> mg :Magit<CR>
autocmd FileType magit nmap <buffer><silent> mg :quit<CR>
autocmd FileType magit set nonu nornu

if dein#tap('vim-floaterm')
  nn \\ <cmd>FloatermToggle<CR>
  tno \\ <C-\><C-n>:FloatermToggle<CR>
endif

if dein#tap('caw.vim')
	function! InitCaw() abort
		if ! (&l:modifiable && &buftype ==# '')
			" silent! nunmap <buffer> <Leader>V
			" silent! xunmap <buffer> <Leader>V
			" silent! nunmap <buffer> <Leader>v
			" silent! xunmap <buffer> <Leader>v
		  silent! nunmap <buffer> gc
			silent! xunmap <buffer> gc
			silent! nunmap <buffer> gcc
			silent! xunmap <buffer> gcc
		else

			" nmap <buffer> <Leader>V <Plug>(caw:wrap:toggle)
			" xmap <buffer> <Leader>v <Plug>(caw:hatpos:toggle)
			" nmap <buffer> <Leader>v <Plug>(caw:hatpos:toggle)
			nmap <buffer> gc <Plug>(caw:prefix)
			xmap <buffer> gc <Plug>(caw:prefix)
			nmap <buffer> gcc <Plug>(caw:hatpos:toggle)
			xmap <buffer> gcc <Plug>(caw:hatpos:toggle)
		endif
	endfunction
	autocmd user_events FileType * call InitCaw()
	call InitCaw()
endif

if dein#tap('goyo.vim')
  nmap <leader>g <cmd>Goyo<CR>
endif
if dein#tap('vim-niceblock')
  silent! xmap I  <Plug>(niceblock-I)
  silent! xmap gI <Plug>(niceblock-gI)
  silent! xmap A  <Plug>(niceblock-A)
endif
if dein#tap('vim-expand-region')
  xmap <silent> v <Plug>(expand_region_expand)
  xmap <silent> V <Plug>(expand_region_shrink)
endif
if dein#tap('dsf.vim')
  " deleting srrounding functions and leave its content.
  nmap dsf <Plug>DsfDelete
  nmap csf <Plug>DsfChange
endif
if dein#tap('vim-operator-replace')
  " xmap p <Plug>(operator-replace)
  " TODO: fix
endif
if dein#tap('vim-sandwich')
  nmap <silent> sa <Plug>(operator-sandwich-add)
  nmap <silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  nmap <silent> srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  nmap <silent> sx <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  nmap <silent> sxb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

  omap <silent> sa <Plug>(operator-sandwich-g@)
  omap ab <Plug>(textobj-sandwich-auto-a)
  omap as <Plug>(textobj-sandwich-query-a)
  omap ib <Plug>(textobj-sandwich-auto-i)
  omap is <Plug>(textobj-sandwich-query-i)

  xmap <silent> sa <Plug>(operator-sandwich-add)
  xmap <silent> sr <Plug>(operator-sandwich-replace)
  xmap <silent> sx <Plug>(operator-sandwich-delete)
  xmap ab <Plug>(textobj-sandwich-auto-a)
  xmap as <Plug>(textobj-sandwich-query-a)
  xmap ib <Plug>(textobj-sandwich-auto-i)
  xmap is <Plug>(textobj-sandwich-query-i)
endif
if dein#tap('vim-bufkill')
  nn <silent>s<esc> <cmd>BD<cr>
  nn <silent>sc <cmd>BD<cr>
endif
if dein#tap('vim-wintabs')
  nn <silent>sk <cmd>WintabsNext<cr>
  nn <silent>sj <cmd>WintabsPrevious<cr>
  nn <silent>sK <cmd>WintabsLast<cr>
  nn <silent>sJ <cmd>WintabsFirst<cr>
  nn <silent>sd <cmd>WintabsClose <cr>
endif
if dein#tap('ctrlp.vim')
  nn <leader>f <cmd>CtrlP<cr>
  " nn <leader>b <cmd>CtrlPBuffer<cr>
  nn <leader><esc> <cmd>CtrlPBuffer<cr>
endif
if dein#tap('vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

if dein#tap('vim-signify')
  " nmap gdj <plug>(signify-next-hunk)
  " nmap gdk <plug>(signify-prev-hunk)
  " nnoremap gde :SignifyDiff<cr>
  " nnoremap gds :SignifyToggle<cr>
  " nnoremap gdu :SignifyHunkUndo<cr>
  omap ic <plug>(signify-motion-inner-pending)
  xmap ic <plug>(signify-motion-inner-visual)
  omap ac <plug>(signify-motion-outer-pending)
  xmap ac <plug>(signify-motion-outer-visual)
endif
if dein#tap('nvim-lsp')
  if has('nvim-0.5')
    function! LSPSetMappings()
        setlocal omnifunc=v:lua.vim.lsp.omnifunc
        nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
        nnoremap <silent> <buffer> gh    <cmd>lua vim.lsp.buf.hover()<CR>
        nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <silent> <buffer> gpd   <cmd>lua vim.lsp.buf.peek_definition()<CR>
        nnoremap <silent> <buffer> gtd   <cmd>lua vim.lsp.buf.type_definition()<CR>
        nnoremap <silent> <buffer> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
        nnoremap <silent> <buffer> gF    <cmd>lua vim.lsp.buf.formatting()<CR>
        nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
        nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
        nnoremap <silent> <buffer> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
        nnoremap <silent> <buffer> gR    <cmd>lua vim.lsp.buf.rename()<CR>
        nnoremap <silent> <buffer> gH    <cmd>lua vim.lsp.buf.document_highlight()<CR>
        nnoremap <silent> <buffer> gl    <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
        if &filetype != "tex" 
          inoremap <buffer><silent> (     <cmd>lua vim.lsp.buf.signature_help()<CR>(
        endif
    endfunction
    augroup LspAutocmd
      autocmd!
      au FileType lua,php,json,less,css,sass,vim,sh,cpp,python,vue,javascript,typescript,tex :call LSPSetMappings()
    augroup END
  endif
endif

if dein#tap('coc.nvim')
  " Backspace
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  function! s:definition_other_window() abort
    if winnr('$') >= 4
      exec "normal \<Plug>(coc-definition)"
    else
      exec 'vsplit'
      exec "normal \<Plug>(coc-definition)"
    endif
  endfunction

  " Next selction
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  inoremap <silent><expr> <c-j>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  
  " Snippet
  let g:coc_snippet_next = '<TAB>'
  let g:coc_snippet_prev = '<S-TAB>'
  " Pervios selction
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <expr><c-k> pumvisible() ? "\<C-p>" : "\<C-h>"
  " confirm selction
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  inoremap <silent><expr> <c-m> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()
  " LSP Mappings:
  " Hover show docs
  nnoremap <silent> K :call CocActionAsync('doHover')<CR>
  " Hover show docs
  nnoremap <silent> gh :call CocActionAsync('doHover')<CR>
  " Hover show docs
  nnoremap <silent> <Leader>ch :call CocActionAsync('doHover')<CR>
  " Lsp jump to defination
  nmap <silent> gD :<C-u>call <sid>definition_other_window()<CR>
  " Lsp jump to defination
  nmap <silent> gd <Plug>(coc-definition)
  " Lsp type defination
  nmap <silent> gy <Plug>(coc-type-definition)
  " Lsp Find implementation'
  nmap <silent> gi <Plug>(coc-implementation)
  " Lsp Find Reference'
  nmap <silent> gr <Plug>(coc-references)
  " Lsp Rename
  nmap <Leader>cw <Plug>(coc-rename)
  " Lsp Rename
  nmap gR <Plug>(coc-rename)
  " Lsp Format'
  vmap <Leader>cf  <Plug>(coc-format-selected)
  " Lsp Format'
  nmap <Leader>cf  <Plug>(coc-format-selected)
  " Organize Imports
  nnoremap <silent> <Leader>co :<C-u>OR<CR>
  " Search workspace symbols.
  nnoremap <silent> <space>cs  :<C-u>CocList -I symbols<cr>
  " Select range
  nmap <silent> <leader>cj <Plug>(coc-range-select)
  " Select and enter muli cursors mode 
  nmap <silent>g<space> <Plug>(coc-cursors-position)
  " Select and enter muli cursors mode 
  xmap <silent>g<space> <Plug>(coc-cursors-range)
  " Quick fix current line
  nmap <Leader>cf  <Plug>(coc-fix-current)
  " Search across workspace
  nnoremap  <Leader>cs :<C-u>CocSearch -w<Space>
  " Resume list
  nnoremap <silent> <Leader>'  :<C-u>CocListResume<CR>
  " call actions
  nnoremap <Leader>ca  <cmd>CocAction<CR>
  " Extra text objects
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)
  " Lsp Organize Import'
  " Other:
  " nmap <Leader>gi <Plug>(coc-git-chunkinfo)
  " nmap <Leader>gm <Plug>(coc-git-commit)
  " nmap ]g <Plug>(coc-git-prevchunk)
  " nmap [g <Plug>(coc-git-nextchunk)
endif
" //////

" }}}
