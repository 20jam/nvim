
if has('vim_starting')
  set encoding=UTF-8 
  scriptencoding UTF-8 
endif

set conceallevel=2

" Text view {{{

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif

if has('linebreak')
  let &showbreak=' '
endif

" show whitespace
set list
set listchars=nbsp:⦸
set listchars+=tab:»»
" set listchars+=extends:»
" set listchars+=precedes:«
" set listchars+=trail:•
"set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←

" don't autoinsert two spaces after '.', '?', '!' for join command
set nojoinspaces

set whichwrap=b,h,l,s,<,>,[,],~       " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries

"}}}-----------------------------------------

" Insert Mode {{{


" Use same indenting on new lines
set autoindent

" always use spaces instead of tabs
set expandtab     
                    
" spaces per tab (when shifting)
set shiftwidth=2

" <tab>/<BS> indent/dedent in leading whitespace
set smarttab


" Indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Smart autoindenting on new lines
set smartindent     
" Round indent to multiple of 'shiftwidth'
set shiftround      


" smart auto-indenting inside numbered lists
set formatoptions+=n

" allow unrestricted backspacing in insert
set backspace=indent,start,eol


"}}}-----------------------------------------

" Buffers related {{{

" Allow hiding buffers with unsaved changes 
set hidden

"}}}-----------------------------------------

" UI Options  {{{

" Height of the command line
set cmdheight=1

set scrolloff=2         " Keep at least 2 lines above/below

" TODO: FIX
set fcs=eob:\           " hide ~ tila

" always show status line
set laststatus=2

set showtabline=2       " Always show the tabs line

" Enable mouse clicks
set mouse=a

" Disable Numbers 
" set nonu nornu
set nu rnu
" Don't Show current mode
set noshowmode

" Don't redraw during macro playback
set lazyredraw

set ttyfast    " Improves smoothness of redrawing


" Don't redraw singlecolumn
" set signcolumn=yes

" if exists('+colorcolumn')
  " Highlight up to 254
"  let &l:colorcolumn='+' . join(range(0, " 254), ',+')
" endif

" highlight current line
" set cursorline

" suppress ~ at EndOfBuffer
set fillchars+=eob:\

  if has('windows')
    set fillchars=diff:∙               " 
    set fillchars+=fold:·              " 
    set fillchars+=vert:┃              " 
  endif

" Sync with corresponding nvim :highlight commands in /modules/autocmds.vim
" ~/@ at end of window, 'showbreak'
" set highlight+=@:Conceal
" override DiffDelete
" set highlight+=D:Conceal
" make current line number stand out a little
" set highlight+=N:FoldColumn
" blend vertical separators with line numbers
" set highlight+=c:LineNr

" Transparent background for popupmenu
set pumblend=15 
set virtualedit=onemore
set viewoptions=folds,options,cursor,unix,slash

" set title
" set list

" Title length.
set titlelen=95
" Title string.
let &g:titlestring="
      \ %{expand('%:p:~:.')}%(%m%r%w%)
      \ %<\[%{fnamemodify(getcwd(), ':~')}\] - Neovim"


set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height
if exists('+previewpopup')
  set previewpopup=height:10,width:60
endif

" Pseudo-transparency for completion menu and floating windows
if &termguicolors
  if exists('&pumblend')
    set pumblend=10
  endif
  if exists('&winblend')
    set winblend=10
  endif
endif

"}}}-----------------------------------------

" UI behaviors {{{

" open horizontally below current window
set splitbelow                      
" open vertically right current window
set splitright
" try to reuse windows/tabs when switching buffers
set switchbuf=usetab

set visualbell noerrorbells t_vb= " Turn off error beep/flash

"}}}-----------------------------------------

" Folding {{{

set foldmethod=marker
set foldlevelstart=99               
" set foldtext=

"}}}-----------------------------------------

" Diff View {{{

" don't show fold column in diff view
set diffopt+=foldcolumn:0

"}}}-----------------------------------------

" Misc {{{

" Number of history to be saved
set history=100

" Number of undos to be saved
set undolevels=1000


" Use buffer directory for file browsing
set bsdir=buffer

" live preview of :s results
if exists('&inccommand')
  set inccommand=split
endif

" Shell
" set shell=zsh                       
execute 'set shell=' . (filereadable('/bin/zsh') ? '/bin/zsh' : 'bin/bash')
" set shell=/usr/bin/zsh
" prevent bsb's watch mode from getting confused
if has('wildignore')
  set backupskip+=*.re,*.rei
endif

if has('showcmd')
  set noshowcmd                       " don't show extra info at end of command line
endif

if has('clipboard')
  set clipboard& clipboard+=unnamedplus
endif

" Enable true color
if has('termguicolors') 
  set termguicolors
endif

" Make ESC work in terminal

function s:exit_to_normal() abort
    if &filetype ==# 'fzf'
      return "\<Esc>"
    endif
    return "\<C-\>\<C-n>"
  endfunction
  tnoremap <expr> <Esc> <SID>exit_to_normal()

if has('virtualedit')
  set virtualedit=block               " allow cursor to move where there is no text in visual block mode
endif

set report=0                 " Don't report on line changes
set errorbells               " Trigger bell on error
set visualbell               " Use visual bell instead of beeping

          
set fileformats=unix,dos,mac " Use Unix as the standard file type
set magic                    " For regular expressions turn magic on
set path+=**

set synmaxcol=2500           " Don't syntax highlight long lines

" What to save for views and sessions:
set viewoptions=folds,cursor,curdir,slash,unix
set sessionoptions=curdir,help,tabpages,winsize

  set viminfo='300,<10,@50,h,n$DATA_PATH/viminfo

" Secure sensitive information, disable backup files in temp directories
if exists('&backupskip')
  set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*
  set backupskip+=.vault.vim
endif

" Disable swap/undo/viminfo/shada files in temp directories or shm
augroup user_secure
  autocmd!
  silent! autocmd BufNewFile,BufReadPre
    \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
    \ setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada=
augroup END

"}}}-----------------------------------------

" Notfications {{{


set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=c
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start


"}}}-----------------------------------------

" Spellling {{{

" don't check for capital letters at start of sentence
if has('syntax')
  set spellcapcheck=
endif

"}}}-----------------------------------------

" Searching Options {{{

" ignoring case
set ignorecase

" Keep case when searching with *
set smartcase       

" Adjust case in insert completion mode
set infercase

" Enable Incremental Search  
set incsearch

" Highlight search results
set hlsearch

" Searches wrap around the end of the file
set wrapscan

" Jump to matching bracket
set showmatch

" Add HTML brackets to pair matching
set matchpairs+=<:>

" Tenths of a second to show the matching paren
set matchtime=1

" showmatch will wait 0.5s or until a char is typed
set cpoptions-=m

" Set rg or ag for searching
" set grepprg=rg\ --vimgrep\ $*
if executable('rg')
  set grepformat=%f:%l:%m
  let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
elseif executable('ag')
  set grepformat=%f:%l:%m
  let &grepprg = 'ag --vimgrep' . (&smartcase ? ' --smart-case' : '')
endif

"}}}-----------------------------------------

" Wildcart {{{

" Ignore
set wildignore+=*.so,*~,*/.git/*,*/node_modules/*,*/.svn/*,*/.DS_Store,*/tmp/(*)

" Display the completion matches using the popupmenu
set wildoptions=pum 

set completeopt =longest,menu
set completeopt-=preview

" set path+=**
" Provides completion for all file-related tasks

  if has('conceal')
    set conceallevel=3 concealcursor=niv
  endif
"

set wildcharm=<C-z>                   " substitute for 'wildchar' (<Tab>) in macros

set wildmenu                        " show options as list when switching buffers etc

  set wildignorecase
  set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
  set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
  set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
  set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
  set wildignore+=__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**

set complete=.,w,b,k  " C-n completion: Scan buffers, windows and dictionary


"}}}-----------------------------------------

" Timing {{{

" Set timeout
set timeout ttimeout
" Set key squence timeout
set timeoutlen=500
" Set key squence timeout
set ttimeoutlen=10
" Idle time to write swap and trigger CursorHold
set updatetime=100

set redrawtime=1500  " Time in milliseconds for stopping display redraw

"}}}-----------------------------------------

" Files & Buffers {{{

" Automatically saves undo history
set undofile              
" Make a backup before overwriting a file
set nobackup              
" Automaticly update files if changed 
set autoread
" Write file on set command
set autowrite
" Write file on everything
" set autowriteall
" Raise a dialog before closing thr buffee
set confirm

set undodir=$DATA_PATH/undo//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set backupdir=$DATA_PATH/backup/,$DATA_PATH,~/tmp,/var/tmp,/tmp
set viewdir=$DATA_PATH/view/
set spellfile=$VIM_PATH/spell/en.utf-8.add

" }}}
"
