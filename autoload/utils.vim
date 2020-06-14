" INFO: Setup required functions by $MYVIMRC/init.vim
" Credit: Adopted from @hardcoreplayers/ThinkVim 

function! utils#source_file(root_path,path, ...)
  " Source user configuration files with set/global sensitivity
  let use_global = get(a:000, 0, ! has('vim_starting'))
  let abspath = resolve(a:root_path . '/' . a:path)
  if ! use_global
    execute 'source' fnameescape(abspath)
    return
  endif

  let tempfile = tempname()
  let content = map(readfile(abspath),
    \ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
  try
    call writefile(content, tempfile)
    execute printf('source %s', fnameescape(tempfile))
  finally
    if filereadable(tempfile)
      call delete(tempfile)
    endif
  endtry
endfunction

function! utils#check_source(filename)
    if filereadable(a:filename)
        let content = readfile(a:filename)
        if !empty(content)
            execute 'source' a:filename
        endif
    endif
endfunction


function! utils#new_project()
  let l:suffix= "/vid-preprod."
  let l:templetedir = $HOME . "/.templetes"
  let l:workdir = $HOME . "/dmas/2020/projects"
  let l:ext = ".md"
  let l:date = strftime('%b.%d') 
  let l:filename = l:workdir . l:suffix . l:date . l:ext

  if !filereadable(l:filename)
      exe "edit" l:filename
      exe "read" l:templetedir . "/pre-prod.templete.md"
      setlocal statusline =[
      setlocal statusline +=XN]
      " setlocal statusline +=\ NewProject:
      " setlocal statusline +=\ %t
      " setlocal statusline +=\ [%M]
      " setlocal noru nonu nornu
      " setlocal statusline +=%4*\ %<%F%*
      " setlocal statusline +=(%f)
    else
      exe "edit" l:filename
      setlocal statusline =[
      " setlocal statusline +=XN:work]
      " setlocal statusline +=\ ProjectFilename:
      " setlocal statusline +=\ %t
      " setlocal statusline +=\ [%M]
      " setlocal noru nonu nornu
      " setlocal statusline +=%4*\ %<%F%*
      " setlocal statusline +=(%f)
  endif
endfunction

command! XN :call utils#new_project()

let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'
function! utils#foldtext() abort
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  return l:first
endfunction

