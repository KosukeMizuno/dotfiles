"""" Load dein.vim """"
let g:dein#auto_recache = v:true

" Add the dein installation directory into runtimepath
let s:cache_dir = expand('~/.cache/dein')
let s:dein_dir = expand('~/ghq/github.com/Shougo/dein.vim')
execute('set runtimepath+=' . s:dein_dir)

" Start loading if needed
if !dein#load_state(s:cache_dir)
  finish
endif

" rc files
let s:toml_dir = expand('~/dotfiles/nvim_test/rc')
let s:toml_plugins = s:toml_dir . '/plugins.toml'

" Setup dein.vim
call dein#begin(s:cache_dir,
      \         [s:toml_plugins],
      \ )
call dein#add(s:dein_dir)
call dein#load_toml(s:toml_plugins)
call dein#end()
call dein#save_state()

" check plugins
if dein#check_install()
  call dein#install()
endif

