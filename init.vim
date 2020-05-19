if &compatible
	" vint: -ProhibitSetNoCompatible
	set nocompatible
	" vint: +ProhibitSetNoCompatible
endif

" Set main configuration directory as current directory (Perhaps nonimportant :P)
let $VIM_PATH = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" Disable vim distribution plugins
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" Initialize base requirements
if has('vim_starting')
	let g:mapleader="\<Space>"
	let g:maplocalleader=";"

	" Release keymappings prefixes, some functionality will be lost. such as
	" marker
	nn <Space>  <Nop>
	xn <Space>  <Nop>
	nn ,        <Nop>
	xn ,        <Nop>
	nn ;        <Nop>
	xn ;        <Nop>
	nn s      	<Nop>
	xn s      	<Nop>
  " nn '      	<Nop>
  " xn '      	<Nop>

endif

" Init Dein Plugin Manager
call utils#source_file($VIM_PATH,'bin/dein.vim')

" Source Internal Modules
call utils#source_file($VIM_PATH,'modules/mappings.vim')
call utils#source_file($VIM_PATH,'modules/theme.vim')
call utils#source_file($VIM_PATH,'modules/settings.vim')
call utils#source_file($VIM_PATH,'modules/autocmd.vim')
call utils#source_file($VIM_PATH,'modules/dwm.vim')

set secure

" vim: set ts=2 sw=2 tw=80 noet :

