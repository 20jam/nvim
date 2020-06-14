
" Custom conceal
au Filetype markdown syntax match todoCheckbox "\[\ \]" conceal cchar=
au Filetype markdown syntax match todoCheckbox "\[x\]" conceal cchar=
"TODO
"LAMA

au Filetype markdwon hi def link todoCheckbox 
au Filetype markdwon hi Conceal guibg=NONE

au Filetype markdwon setlocal cole=1
