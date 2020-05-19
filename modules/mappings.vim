" TODO: Find a better way to organize mappings, maybe on usecase bases (e.g.
" editing text, jumping around
"
" LocalLeader {{{

" Dublicate lines
nn <localleader>d m`YP``
vn <localleader>d YPgv

" Source line, or vimrc
nn <silent><localleader>la :update<CR>:so $MYVIMRC<CR>
nn <localleader>ll ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>
vn <localleader>l y:execute @@<CR>:echo 'Sourced selection.'<CR>

" Expand edit or lcd
nn <localleader>c :lcd <C-R>=expand('%:p:h') . '/'<CR>
nn <localleader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" Replace Text
nn <localleader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nn <localleader>w <cmd>write<cr>


" }}}----------------------------------------------------------------
"
" Leader {{{
" just being lazy
nn <leader><leader> V
xn <leader><leader> <esc>
nn ' :
nn <leader>a A
nn <leader>i I

nn <leader>w <cmd>write<cr>
nn <leader>q q
nn q <cmd>quit<cr>
"nn <leader>d <cmd>bd<cr>
nn <leader>n <Cmd>ToggleNumber<CR>

" insted of arrows I guess
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" noremap <leader>, <PageDown>
" noremap <leader>. <PageUp>
" g
" Git mappings
" nn <silent> <Leader>ga :Git add %:p<CR>
" nn <silent> <Leader>gb :Git blame<CR>
" nn <silent> <Leader>gc :Git commit<CR>
" nn <silent> <Leader>gf :Gfetch<CR>
" nn <silent> <Leader>gg :Magit<CR>
" nn <silent> <Leader>gp :Gpush<CR>
" nn <silent> <Leader>gs :Git<CR>
" nn <silent> <Leader>gz :<C-u>FloatermNew height=0.7 width=0.8 lazygit<CR>
"
"
" Dein Plugin {{{
nnoremap <silent> <Leader>pu  :call dein#update()<CR>
nnoremap <silent> <Leader>pr  :call dein#recache_runtimepath()<CR>
nnoremap <silent> <Leader>pl  :echo dein#get_updates_log()<CR>
" }}}
" }}}
"
" S Leader {{{

" window-control prefix
nn  [win]   <nop>
nm      s [win]

" Buffers Navigation
nn <leader>j <cmd>bn<cr>
nn <leader>k <cmd>bp<cr>
" nn [win]] <cmd>bn<cr>
" nn [win][ <cmd>bp<cr>
nn [win]<leader> <cmd>b#<cr>
" Buffer commands
nn <leader>c <cmd>bd<cr>
" Splits Navigation
" nn <C-l> <C-w><c-k>
" nn <C-h> <C-w><c-j>
" nn <C-j> <C-w><C-h>
" nn <C-k> <C-w><C-l>
" nn <C-w> <C-w><C-w>
" nn [win]s <cmd>wincmd w<cr>
" nn [win]j <cmd>wincmd h<cr>
" nn [win]k <cmd>wincmd l<cr>
" nn [win]h <cmd>wincmd j<cr>
" nn [win]n <cmd>wincmd j<cr>
" knn [win]n <cmd>DWM_New<cr>
" nn [win]l <cmd>wincmd k<cr>

" Splits commands
" nn [win]v <cmd>vs<cr>
" nn [win]f <cmd>sp<cr>
nn [win]o <cmd>only<cr>
" nn [win]d <cmd>quit<cr>
" Tabs Navigation
no [win]g <cmd>tabprevious<CR>
no [win]; <cmd>tabnext<CR>
" Tabs Commands
no [win]n <cmd>tabnew<CR>
" Custom
no [win]q <cmd>:wqa<CR>
" }}}
"
" Normal Mode {{{
"
" A
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" All
nn L $
nn Y y$
nn H 0
nn - $
nn ;; :
nn ! :!
nn U <C-r>
" Don't work
nn <X2Mouse> p
" If we ever want to use file explore split
" nn <C-e> :!start explorer %:p:h:gs?\/?\\\\\\?<CR>
" nn <C-n> 
" nn <C-p> 
nn <C-a> <esc>ggVG<CR>
" Manually remove highlight
nn <silent> <C-h> :noh<CR>

" g
nn gq gwap
" nm go :call modules#mappings#OpenLinkUnderCursor()<cr>
nn g! :<C-u>put=execute('')<Left><Left>


" q: Making quiting with q 
nn <silent><buffer> q :quit<CR>
" z
" Folds
nn zm zM 
nn <localleader>z zMzvzz
nn <tab> za
" Center Screnn
nn <expr> zz (winline() == (winheight(0)+1) / 2) ? 'zt' : (winline() == 1) ? 'zb' : 'zz'

" Location List

nm ]l :lnext<CR>
nm [l :lprev<CR>
nm ]q :cnext<CR>
nm [q :cprev<CR>

" }}}----------------------------------------------------------------
"
" Visual Mode {{{

" Moving lines
xn <silent>N <gv
xn <silent>H <gv
xn <silent>L >gv
vn <silent>K :m-2<CR>gv=gv
vn <silent>J :m'>+<CR>gv=gv
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv

" replace contuniously
nn cN *``cgN
nn cn *``cgn

" Replace word under cursor
xn <C-r> :<C-u>call modules#mappings#GetSelection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>

" }}}----------------------------------------------------------------
"
" Insert mode {{{

cno jk <esc>
ino jk <esc>
ino jj <esc>
ino <S-Return> <C-o>o
" Doesn't work
" nmap <delete> %
" xmap <delete> %
" nmap <BS> %
" xmap <BS> %

" Get date in insert mode
iab xdate <C-r>=strftime("%H:%M %m/%d/20%y")<cr>

" Using Control in insertmode
inoremap <C-O> <Esc>o
inoremap <C-a> <ESC>^i
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-f> <Right>
inoremap <C-h> <BS>
inoremap <C-k>  <ESC>d$a
inoremap <C-u> <C-G>u<C-U>
" inoremap <C-w> <C-[>diwa
inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"

" }}}----------------------------------------------------------------
" 
" Command mode {{{
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-h> <BS>
cnoremap <C-p> <Up>
cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>
" }}}
