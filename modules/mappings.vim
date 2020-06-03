nm ; <leader>
xm ; <leader>

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
iab xdate <C-r>=strftime("%H:%M %m/%d/20%y")<cr>
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
nn <silent>gq gwap
nn <silent>gs <cmd>Dirvish<cr>
nn <silent>- <cmd>Dirvish<cr>
nn <silent>ge G
" //////

" }}}
" S Key {{{

" //////
"nn ss <cmd>b#<cr>
nn <leader>s <cmd>b#<cr>
nn ss <cmd>b#<cr>
nn sc <cmd>WintabsClose<cr>
nn s<esc> <cmd>WintabsClose<cr>
nn sk <cmd>bn<cr>
nn sj <cmd>bp<cr>

nn sd <cmd>q<cr>
nn so <cmd>only<cr>
nn sv <cmd>vs<cr>
nn sf <cmd>sp<cr>

nn <leader>k <cmd>tabnext<cr>
nn <leader>j <cmd>tabprevious<cr>
nn sp <cmd>WintabsCloseVimtab<>
nn sn <cmd>tabnew<CR>
nn s; <cmd>tabnext<CR>
nn sg <cmd>tabprevious<CR>

" //////

" }}}
" Prefix {{{

" //////
nn <silent><C-h> :noh<CR>
nn <silent><tab> za
nn <silent><C-j> <cmd>wincmd w<cr>
nn <silent><C-k> <cmd>wincmd W<cr>
nn <silent><C-n> <cmd>cn<cr>
nn <silent><C-p> <cmd>cp<cr>
" //////

" }}}
" Leader {{{

" //////
" Lazy-shift 
nn <leader>i I
nn <leader>v V
nn <leader>a A
nn <leader>8 *
xn <leader>8 *

nn <leader>c :lcd <C-R>=expand('%:p:h') . '/'<CR>
nn <leader>d m`YP``
nn <leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
nn <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nn <leader>w <cmd>write<cr>
nn <leader><Tab> zMzvzz
nn zm zM 
nn <leader>; :
nn <leader><leader> :
nn <silent><Leader>pl  :echo dein#get_updates_log()<CR>
nn <silent><Leader>pr  :call dein#recache_runtimepath()<CR>
nn <silent><Leader>pu  :call dein#update()<CR>
nn <silent><leader>la :update<CR>:so $MYVIMRC<CR>
nn <silent><leader>ll ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>
nn <silent><leader>pt<cmd>1,$s/\t/  /g<cr>
nn <silent><leader>tn <Cmd>ToggleNumber<CR>
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
  nmap sg <Plug>(easymotion-overwin-f)
  nmap gjj <Plug>(easymotion-w)
  nmap gkk <Plug>(easymotion-b)
endif

nnoremap <silent> mg :Magit<CR>
autocmd FileType magit nmap <buffer><silent> mg :quit<CR>

if dein#tap('vim-floaterm')
  nn \\ <cmd>FloatermToggle<CR>
  tno jk <C-\><C-n>:FloatermToggle<CR>
endif

if dein#tap('caw.vim')
  nmap <buffer> gc <Plug>(caw:prefix)
  xmap <buffer> gc <Plug>(caw:prefix)
  nmap <buffer> gcc <Plug>(caw:hatpos:toggle)
  xmap <buffer> gcc <Plug>(caw:hatpos:toggle)
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
  xmap v <Plug>(expand_region_expand)
  xmap V <Plug>(expand_region_shrink)
endif
if dein#tap('dsf.vim')
  nmap dsf <Plug>DsfDelete
  nmap csf <Plug>DsfChange
endif
if dein#tap('vim-operator-replace')
  " xmap p <Plug>(operator-replace)
  " TODO: fix
endif
if dein#tap('vim-sandwich')
  nmap <silent> sa <Plug>(operator-sandwich-add)
  xmap <silent> sa <Plug>(operator-sandwich-add)
  omap <silent> sa <Plug>(operator-sandwich-g@)
  nmap <silent> sx <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  xmap <silent> sx <Plug>(operator-sandwich-delete)
  nmap <silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  xmap <silent> sr <Plug>(operator-sandwich-replace)
  nmap <silent> sxb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  nmap <silent> srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  omap ib <Plug>(textobj-sandwich-auto-i)
  xmap ib <Plug>(textobj-sandwich-auto-i)
  omap ab <Plug>(textobj-sandwich-auto-a)
  xmap ab <Plug>(textobj-sandwich-auto-a)
  omap is <Plug>(textobj-sandwich-query-i)
  xmap is <Plug>(textobj-sandwich-query-i)
  omap as <Plug>(textobj-sandwich-query-a)
  xmap as <Plug>(textobj-sandwich-query-a)
endif
if dein#tap('vim-bufkill')
  nn <silent>s<esc> <cmd>BD<cr>
  nn <silent>sc <cmd>BD<cr>
  nn <silent>sk <cmd>BF<cr>
  nn <silent>sj <cmd>BB<cr>
  nn <silent>ss <cmd>BA<cr>
  nn <silent>s<leader> <cmd>BA<cr>
endif
" //////
" }}}
