" Language Servers
function ConfigureNativeLSP()
  call luaeval("require'nvim_lsp'.vimls.setup{}")
  call luaeval("require'nvim_lsp'.bashls.setup{}")
  call luaeval("require'nvim_lsp'.tsserver.setup{}")
  call luaeval("require'nvim_lsp'.texlab.setup{}")
  call luaeval("require'nvim_lsp'.jsonls.setup{}")
  call luaeval("require'nvim_lsp'.html.setup{}")
  call luaeval("require'nvim_lsp'.cssls.setup{}")
  call luaeval("require'nvim_lsp'.intelephense.setup{}")
  call luaeval("require'nvim_lsp'.yamlls.setup{}")
  call luaeval("require'nvim_lsp'.vuels.setup{}")
endfun
" use omni completion provided by lsp
set omnifunc=lsp#omnifunc

" Enable debug mode
let g:language_client_log_level = 'debug'

" Define mappings
function! LSPSetMappings()
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <buffer> gF    <cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    " nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
endfunction

" set hilgihting
highlight link LspDiagnosticsError User8

" Define signs
sign define LspDiagnosticsErrorSign text=
sign define LspDiagnosticsWarningSign text=
sign define LspDiagnosticsInformationSign text=כֿ
sign define LspDiagnosticsHintSign text=➤

" Enable Lsp
if has('nvim-0.5')
  call ConfigureNativeLSP()
  augroup LspAutocmd
    autocmd!
    au FileType json,less,css,sass,vim,sh,cpp,yaml,python,vue,javascript,typescript,tex :call LSPSetMappings()
    if has('nvim') && exists('*nvim_open_win')
      autocmd BufEnter __LanguageClient__ call s:Bind()
    endif
  augroup END
endif

" Commands
" Print information on current client
command! LspShowClients lua print(vim.inspect(vim.lsp.buf_get_clients()))
