" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Have Autocompletion 
let g:AutoCompletion_mode = 1

if g:AutoCompletion_mode
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  autocmd BufEnter * lua require'completion'.on_attach()
else
" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
" inoremap <silent><expr> <TAB>
" \ pumvisible() ? "\<C-n>" :
" \ <SID>check_back_space() ? "\<TAB>" :
" \ completion#trigger_completion()
endif

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip'
" let g:completion_enable_snippet = 'UltiSnips'
