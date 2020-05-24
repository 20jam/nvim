command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

