augroup GeneralAutocmd " {{{
  autocmd!

" Reload vim config automatically
autocmd BufWritePost $VIM_PATH/modules/{*.vim,*.yaml,vimrc} nested
    " \ source $MYVIMRC | redraw

" Reload Vim script automatically if setlocal autoread
" autocmd BufWritePost,FileWritePost *.vim nested
"   \ if &l:autoread > 0 | source <afile> |
"   \   echo 'source ' . bufname('%') |
"   \ endif

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
  autocmd BufWritePre * call modules#autocmd#MkdirIfNon(expand('<afile>:p:h'), v:cmdbang)

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if &ft !~# 'commit' && ! &diff &&
    \      line("'\"") >= 1 && line("'\"") <= line("$")
    \|   execute 'normal! g`"zvzz'
    \| endif


  " Disable paste mode on leaving insert mode.
  autocmd InsertLeave * set nopaste

  " Run a script cleaning out tex build files whenever I close out of a .tex file.
  autocmd VimLeave *.tex !texclear %

  " Allow saving of files as sudo when I forgot to start vim using sudo.
  " TODO: fix problem no password
  cmap w!! w !sudo tee > /dev/null %

  " Run shell scripts when editing those files
  autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
  " autocmd BufWritePost *config.h !superc % 
  " Needs a password to be passed
  autocmd BufWritePost files,dirs !syncalias

  " Automatically open & close quickfix window
  autocmd QuickFixCmdPost [^l] * nested cwindow

augroup END

" TODO: move to file type:
" When editing markdown files
" autocmd FileType markdown
"   \ setlocal expandtab spell conceallevel=0
"   \ | setlocal autoindent formatoptions=tcroqn2 comments=n:>
