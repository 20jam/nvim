" Coc {{{
set shortmess+=c 
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

if dein#tap('coc.nvim')
  let g:coc_status_error_sign = ''
  let g:coc_status_warning_sign = ''

  augroup CocAutcmd
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " Filetype Autmcd
    autocmd FileType markdown let b:coc_pairs_disabled = ['`']
    " Disable coc for markdown files
    autocmd FileType markdown let b:coc_suggest_disable = 1
  augroup end

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Exentions
  let g:coc_global_extensions =[
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-vimlsp',
      \ 'coc-snippets',
      \ 'coc-emmet',
      \ 'coc-pairs',
      \ 'coc-json',
      \ 'coc-highlight',
      \ 'coc-vetur',
      \ 'coc-tsserver',
      "\ 'coc-docthis' " Generate jsdocs
      "\ 'coc-eslint', " Code formater
      "\ 'coc-prettier', " Code Formater
      "\ 'coc-git',
      "\ 'coc-emoji',
      "\ 'coc-lists',
      "\ 'coc-stylelint',
      "\ 'coc-yaml',
      "\ 'coc-tabnine',
      "\ 'coc-gitignore',
      "\ 'coc-yank',
      "\ 'coc-explorer',
      "\ 'coc-actions',
      "\ 'coc-db',
      \]
  call coc#config('languageserver', {
    \ 'bash': {
      \ "command": "bash-language-server",
      \ "args" : ["start"],
      \ "rootPatterns": ["go.mod"],
      \ "ignoredRootPaths": ["~"],
      \ "filetypes": ["sh"]
      \ }
      \})
  call coc#config('languageserver', {
    \ 'intelephense': {
      \ "command": "intelephense",
      \ "args": ["--stdio"],
      \ "filetypes": ["php"],
      \ "initializationOptions": {
            \ "storagePath": "/tmp/intelephense"
      \ }
      \ }
      \})

endif
" }}}
" UltiSnips {{{
if dein#tap('ultisnips')
  " Editing snips
  let g:UltiSnipsEditSplit='tabdo'
  " let g:UltiSnipsSnippetsDir = '~/.config/nvim/snippets/'
  " let g:UltiSnipsSnippetDirectories = [
  "      \   'ultisnips',
  "      \   'ultisnips-private'
  "      \ ]
    let g:UltiSnipsJumpForwardTrigger = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
    let g:UltiSnipsExpandTrigger       = '<Plug>(ultisnips_expand)'
    let g:UltiSnipsListSnippets        = ''
    " Jump Forward result
    let g:ulti_jump_forwards_res = 0 " (0: fail, 1: success)

    function s:IsExpandableUltiSnips() abort
        return !(
                   \ col('.') <= 1
                   \ || !empty(matchstr(getline('.'), '\%' . (col('.') - 1) . 'c\s'))
                   \ || empty(UltiSnips#SnippetsInCurrentScope())
                   \ )
    endfunction

    function! s:UltiSnipsExpand() abort
        if s:IsExpandableUltiSnips()
            return "\<Plug>(ultisnips_expand_or_jump)"
        endif

        if pumvisible()
            return "\<C-e>"
        endif

        return "\<C-k>"
    endfunction

    inoremap <silent> <Plug>(ultisnips_expand_or_jump) <C-r>=UltiSnips#ExpandSnippetOrJump()<CR>
    snoremap <silent> <Plug>(ultisnips_expand_or_jump) <Esc>:call UltiSnips#ExpandSnippetOrJump()<CR>

    imap <silent> <expr> <C-k> <SID>UltiSnipsExpand()
    smap                 <C-k> <Plug>(ultisnips_expand_or_jump)
    xmap                 <C-k> <Plug>(ultisnips_expand)
endif
" }}}
" Completion-nvim {{{
if dein#tap('completion-nvim')
  let g:AutoCompletion_mode = 0
	" Set completeopt to have a better completion experience
	set completeopt=menuone,noinsert,noselect

	" Avoid showing message extra message when using completion
	set shortmess+=c

	if g:AutoCompletion_mode
		inoremap <expr> <Tab>		pumvisible() ? "\<C-n>" : "\<Tab>"
		inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
		inoremap <expr> <c-j>		pumvisible() ? "\<C-n>" : "\<c-j>"
		inoremap <expr> <c-k>		pumvisible() ? "\<C-p>" : "\<c-k>"
		autocmd BufEnter * lua require'completion'.on_attach()
	else
		autocmd BufEnter * lua require'completion'.on_attach()
		inoremap <expr> <c-j>		pumvisible() ? "\<C-n>" : "\<c-j>"
		inoremap <expr> <c-k>		pumvisible() ? "\<C-p>" : "\<c-k>"
		inoremap <expr> <c-space>		pumvisible() ? "\<C-n>" : "\<c-space>"
		inoremap <expr> <c-s-space>		pumvisible() ? "\<C-p>" : "\<c-s-space>"
		function! s:check_back_space() abort
				let col = col('.') - 1
				return !col || getline('.')[col - 1]	=~ '\s'
		endfunction
		inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ completion#trigger_completion()
		inoremap <silent><expr> <c-space>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ completion#trigger_completion()
		inoremap <silent><expr> <c-j>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ completion#trigger_completion()
	endif
  " Length
  " let g:completion_trigger_keyword_length = 3 " default = 1
	" Add completion sources
	let g:completion_auto_change_source = 1
  let g:completion_enable_auto_popup = 1
	let g:completion_chain_complete_list = {
	\'default' : {
			 \'default': [
				 \{'complete_items': ['lsp', 'snippet', 'buffers', 'file', 'path']},
			   \{'complete_items': ['path'], 'triggered_only': ['./', '/']},
				 \{'mode': '<c-p>'},
				 \{'mode': 'keyn'},
				 \{'mode': 'keyp'},
				 \{'mode': 'file'},
				 \{'mode': '<c-n>'}
				 \	 ],
			 \'comment': [],
      \   'string' : [{'complete_items': ['path']}]
	\}
	\}
	let g:completion_enable_auto_paren = 0
	let g:completion_matching_strategy_list = ['fuzzy', 'exact', 'substring']
	 let g:completion_customize_lsp_label = {
		\ "Method": "\uf794 [method]",
		\ "Function": "\uf794 [function]",
		\ "Variable": "\uf6a6 [variable]",
		\ "Field": "\uf6a6 [field]",
		\ "Class": "\ufb44 [class]",
		\ "Struct": "\ufb44 [struct]",
		\ "Interface": "\uf836 [interface]",
		\ "Module": "\uf668 [module]",
		\ "Property": "\uf0ad [property]",
		\ "Value": "\uf77a [value]",
		\ "Enum": "\uf77a [enum]",
		\ "Operator": "\uf055 [operator]",
		\ "Reference": "\uf838 [reference]",
		\ "Keyword": "\uf80a [keyword]",
		\ "Color": "\ue22b [color]",
		\ "Unit": "\ue3ce [unit]",
		\ "Snippet": "\uf68e [snippet]",
		\ "Text": "\uf52b [text]",
		\ "Buffers": "\uf64d [buffers]",
		\ "TypeParameter": "\uf635 [type]",
	\}


  let g:completion_confirm_key = "\<C-y>"
  let g:completion_enable_snippet = 'UltiSnips'
endif 
" }}} 
" Deoplete {{{
if dein#tap('deoplete.nvim')
  call deoplete#custom#source('ultisnips', 'rank', 1000)
  call deoplete#custom#source('file', 'rank', 2000)
  call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

  inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
	inoremap <expr><C-g>     deoplete#undo_completion()
  inoremap <silent> <expr> <C-x><C-f> deoplete#manual_complete('file')

  call deoplete#custom#option({
             \ 'auto_complete':        v:true,
             \ 'auto_complete_delay':  50,
             \ 'refresh_always':       v:true,
             \ 'camel_case':           v:true,
             \ 'skip_multibyte':       v:true,
             \ 'prev_completion_mode': 'length',
             \ 'auto_preview':         v:true,
             \ 'max_list':             200,
             \ })
  " Save indent and CR
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function() abort
	  return deoplete#close_popup() . "\<CR>"
	endfunction
endif
"}}}
" Nvim-lsp {{{
if dein#tap('nvim-lsp')
  " Language Servers
  call luaeval("require'nvim_lsp'.vimls.setup{}")
  call luaeval("require'nvim_lsp'.bashls.setup{}")
  call luaeval("require'nvim_lsp'.tsserver.setup{}")
  call luaeval("require'nvim_lsp'.jsonls.setup{}")
  call luaeval("require'nvim_lsp'.html.setup{}")
  call luaeval("require'nvim_lsp'.cssls.setup{}")
  call luaeval("require'nvim_lsp'.intelephense.setup{}")
  call luaeval("require'nvim_lsp'.vuels.setup{}")
  call luaeval("require'nvim_lsp'.sourcekit.setup{}")
  "call luaeval("require'nvim_lsp'.yamlls.setup{}")
  "call luaeval("require'nvim_lsp'.texlab.setup{}")
  " use omni completion provided by lsp
  set omnifunc=lsp#omnifunc
  " Enable debug mode
  let g:language_client_log_level = 'debug'
  " set hilgihting
  highlight link LspDiagnosticsError User8
  " Define signs
  sign define LspDiagnosticsErrorSign text=
  sign define LspDiagnosticsWarningSign text=
  sign define LspDiagnosticsInformationSign text=כֿ
  sign define LspDiagnosticsHintSign text=➤
endif
" }}}
