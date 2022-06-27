if &compatible
  set nocompatible
endif

"""" Basic """"  {{{1
" encoding
set encoding=utf-8
scriptencoding utf-8

" gitbash内でcmd.exeを動かすための設定
"" この設定はdein.vimの読み込みより前に書く
if has("win64")
  set shell=cmd.exe
  set shellcmdflag=/c
  set shellquote=""
  set shellxquote="("
  set shellxescape="\"&|<>()@^"
endif

" アイコンを出すかどうか
let g:rc_enable_icon = !empty($USE_ICON_IN_TERM) && $USE_ICON_IN_TERM != "false"

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

" disable providers  {{{4
let g:loaded_python_provider = 0  " python2
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
" }}}

" disable default plugins  {{{4
let g:loaded_2html_plugin      = 1
let g:loaded_logiPat           = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_man               = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1
" }}}

"""" 分割したスクリプトをロード """"  {{{1
" credintial file
" Note: runtimeコマンドはファイルが無くてもエラーにならない
runtime! rc/set_credential.vim

" プラグイン読み込み
runtime! rc/load_dein.vim
" call dein#call_hook('source')
" call dein#call_hook('post_source')

" KEY MAPPING
runtime! rc/keymap.vim

"""" Helper function """"  {{{1
" インデントサイズをまとめて設定
function! s:set_indent(tab_length) abort
  execute 'setlocal shiftwidth='..a:tab_length
    \     ..' softtabstop='..a:tab_length
    \     ..' tabstop='..a:tab_length
endfunction
command! -nargs=1 SetIndent call s:set_indent(<f-args>)

"""" 色関係 """"  {{{1
try
  colorscheme monokai_mod
catch /^Vim\%((\a\+)\)\=:E185/
  echo "colorscheme is not detected."
endtry

" ft-plugin有効化
if has('vim_starting') && !empty(argv())
  filetype plugin indent on
  syntax enable
  filetype detect
endif
set termguicolors


"""" 基本設定 """"  {{{1
if has('vim_starting')
  let g:force_reload_myrc = 0
endif

" TODO: vim_starting を条件付けするもの、しないものを整理する

" misc  {{{2
if has('vim_starting') || g:force_reload_myrc
  set number          " 行番号を表示
  set relativenumber  " 相対行番号を表示
  set cursorline      " 現在の行をハイライトする
  set showmatch       " 対応するカッコを強調する
  set matchtime=1     " カッコの強調時間を0.1sにする
  set matchpairs+=<:>,「:」,（:）
  set whichwrap+=<,>  " 矢印キーで行を移動できるようにする
  set modeline        " モードライン（ファイル毎の設定）を有効にする
  set virtualedit=onemore,block
  set nrformats=      " 数の増減を10進数扱いとする

  set laststatus=2
  set signcolumn=yes:1
  set cmdheight=2
  set showcmd         " 入力したコマンドを表示

  set nowrap          " 折り返さない
  set breakindent     " インデントを考慮した折返しを行う
  set breakindentopt=min:20,shift:0  " indentシフト設定（デフォルト）
  set showbreak=      " indent表示（デフォルトなし） teh indent

  set nospell             " デフォルトではスペルチェック無し
  set spelllang=en,cjk    " 日本語をスペルチェックから除外
  set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
  set spelloptions=camel  " CamelCasedは分割してスペルチェック
endif

" インデント基本設定  {{{2
if has('vim_starting') || g:force_reload_myrc
  set shiftround
  set autoindent
  set expandtab
  set smartindent
  set shiftwidth=4
  set softtabstop=4
  set tabstop=4
endif

" 表示関係  {{{2
if has('vim_starting') || g:force_reload_myrc
  "set ambiwidth=single

  set foldmethod=marker
  set foldcolumn=3

  set list
  set listchars=tab:»-,extends:»,precedes:«,nbsp:%
  set conceallevel=2

  " set scrolloff=4  " -> drzel/vim-scrolloff-fractionで制御させる
  set sidescrolloff=8
endif

" ファイル処理  {{{2
if has('vim_starting') || g:force_reload_myrc
  set confirm
  set hidden
  set autoread
  set updatetime=400

  " セッション
  set sessionoptions=buffers,curdir,help,folds,tabpages,slash
  set viewoptions=cursor,folds,slash,unix

  " undodir
  set undofile
  set backup
  set noswapfile

  set undodir=$HOME/.local/share/nvim/undo
  set backupdir=$HOME/.local/share/nvim/backup
  set directory=$HOME/.local/share/nvim/swap
endif

" 検索  {{{2
if has('vim_starting') || g:force_reload_myrc
  set incsearch
  set ignorecase
  set smartcase
  set wrapscan
  set hlsearch
  set inccommand=nosplit

  set helplang=ja,en
endif

" インサートモード関係 {{{2
if has('vim_starting') || g:force_reload_myrc
  set pumheight=12
  set completeopt=menuone,noinsert,noselect

  " コマンドライン補完
  set wildcharm=<Tab>
  set wildmenu
  set wildmode=longest:full,full
endif


"""" config helpers """" {{{1
command! VimShowHlLinkGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
command! VimShowHlGroup echo synIDattr(synID(line('.'), col('.'), 1), 'name')
command! CheckHealth call dein#source() | checkhealth

" Dein shortcuts
command! DeinReCache call dein#recache_runtimepath()
if empty(get(g:, 'dein#install_github_api_token', ''))
  command! DeinUpdate call dein#update()
else
  command! DeinUpdate call dein#check_update(v:true)
endif

" profiling for log file by 'vim --startuptime'
command! SortStartuplog %!sort -k2nr

" reload function  {{{
"" 関数の実行中に関数を書き換えられないので初期化時のみ定義する
if has('vim_starting')
  function s:reload_vimrc() abort
    execute printf('source %s', $MYVIMRC)
    if (&term == 'nvim') || has('gui')
      execute printf('source %s', $MYGVIMRC)
    endif
    redraw
    echom printf('.vimrc/.gvimrc was reloaded'..(g:force_reload_myrc ? ' with (g:force_reload_myrc=v:true)': '')..' (%s).', strftime('%c'))
    let g:force_reload_myrc = v:false
  endfunction
endif  " }}}
command! ReloadRC call s:reload_vimrc()
command! ReloadRCForced let g:force_reload_myrc = v:true | call s:reload_vimrc()

