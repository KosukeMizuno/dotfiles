if &compatible
  set nocompatible
endif

" encoding
set encoding=utf-8
scriptencoding utf-8

" python executable
if has('win64')
  let g:python3_host_prog = '~/.local/opt/python3_nvim/Scripts/python.exe'
else
  let g:python3_host_prog = '~/.local/opt/python3_nvim/bin/python'
endif

" リーダー
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"
nnoremap <Leader> <Nop>
nnoremap <LocalLeader> <Nop>


" プラグイン読み込み
runtime! rc/load_dein.vim

" helper functions
command! VimShowHlLinkGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
command! VimShowHlGroup echo synIDattr(synID(line('.'), col('.'), 1), 'name')
" profiling for log file by 'vim --startuptime'
command! SortStartuplog %!sort -k2nr


