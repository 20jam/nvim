  " Reload vim config automatically
autocmd BufWritePost $VIM_PATH/{*.vim,*.yaml,vimrc} nested
        \ source $MYVIMRC | redraw

	" Reload Vim script automatically if setlocal autoread
	autocmd BufWritePost,FileWritePost *.vim nested
		\ if &l:autoread > 0 | source <afile> |
		\   echo 'source ' . bufname('%') |
		\ endif


  " Update filetype on save if empty
  autocmd BufWritePost * nested
        \ if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

  " Automatically set read-only for files being edited elsewhere
  autocmd SwapExists * nested let v:swapchoice = 'o'

 " Check if file changed when its window is focus, more eager than 'autoread'
  autocmd FocusGained * checktime

  " Make directory automatically.
  autocmd BufWritePre * call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)

augroup END "}}}

" Need to be moved to autoload
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction


	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~# 'commit' && ! &diff &&
		\      line("'\"") >= 1 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif

" When editing markdown files

	autocmd FileType markdown
		\ setlocal expandtab spell conceallevel=0
		\ | setlocal autoindent formatoptions=tcroqn2 comments=n:>

      " Disable paste mode on leaving insert mode.
      autocmd InsertLeave * set nopaste

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %


" Allow saving of files as sudo when I forgot to start vim using sudo.
	cmap w!! w !sudo tee > /dev/null %

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Automatically open & close quickfix window
autocmd QuickFixCmdPost [^l] * nested cwindow

" when shortcut files are updated, renew bash and ranger configs with new material
autocmd BufWritePost files,directories !shortcuts

function! DeleteInactiveBufs()
 "From tabpagebuflist() help, get a list of all buffers in all tabs 
  let tablist = []
  for i in range(tabpagenr('$'))
    call extend(tablist, tabpagebuflist(i + 1))
  endfor
 
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
    if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
      "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
     silent exec 'bwipeout' i
     let nWipeouts = nWipeouts + 1
   endif
 endfor
 echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

command! Ball :call DeleteInactiveBufs()

" get date in insert mode
iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" insted of arrows I guess
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" Map ,, to PageDown key and ,. to PageUp
noremap <leader>, <PageDown>
noremap <leader>. <PageUp>

if has('windows')

    function! MyTabLabel(n)
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        let buflen = tabpagewinnr(a:n, '$')
        let bufname = fnamemodify(bufname(buflist[winnr - 1]), ':t')

        let label = '#' . a:n . ' '
        let label .= bufname == '' ? 'Empty' : bufname
        let label .= '(' . buflen . ')'

        return label
    endfunction

    function! MyTabLine()
        let s = ''
        let is_curr = 0

        for i in range(tabpagenr('$'))
            let is_curr = (i + 1 == tabpagenr()) ? 1 : 0
            let s .= is_curr ? '%#TabLineSel#' : '%#TabLine#'
            let s .= '%' . (i + 1) . 'T'
            let s .= is_curr ? ' ~>' : ''
            let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
        endfor

        let s .= '%#TabLineFill#%T'
        if tabpagenr('$') > 1
            let s .= '%=%#TabLine#%999Xx'
        endif

        return s
    endfunction

    set tabline=%!MyTabLine()
endif

" Retab the document (convert tabs to spaces)
nnoremap <leader>rt :retab!<CR>

