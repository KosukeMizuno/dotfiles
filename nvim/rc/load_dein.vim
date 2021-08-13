"""" Load dein.vim """"
let g:dein#auto_recache = v:true
" let g:dein#lazy_rplugins = v:true  " なんか動きを勘違いしてるっぽい。とりあえずdisableしとく
let g:dein#enable_notification = v:true

" Add the dein installation directory into runtimepath
let s:cache_dir = expand('~/.cache/dein')
let s:dein_dir = expand('~/ghq/github.com/Shougo/dein.vim')
execute('set runtimepath+=' . s:dein_dir)

" Start loading if needed
if !dein#load_state(s:cache_dir)
  finish
endif

" rc files
let s:toml_dir = expand('~/dotfiles/nvim/rc')
let s:toml_plugins = s:toml_dir . '/plugins.toml'
let s:toml_completion = s:toml_dir . '/plugins_compl.toml'
let s:toml_textobj = s:toml_dir . '/plugins_textobj.toml'
let s:toml_ftplugins = s:toml_dir . '/plugins_ft.toml'

" Setup dein.vim
call dein#begin(s:cache_dir,
      \         [s:toml_plugins,
      \          s:toml_completion,
      \          s:toml_textobj,
      \          s:toml_ftplugins],
      \ )
call dein#add(s:dein_dir)

call dein#load_toml(s:toml_plugins)
call dein#load_toml(s:toml_completion)
call dein#load_toml(s:toml_textobj)
call dein#load_toml(s:toml_ftplugins)

call dein#end()
call dein#save_state()

" check plugins
if dein#check_install()
  call dein#install()
endif

