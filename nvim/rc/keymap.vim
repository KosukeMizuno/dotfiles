"""" KEYMAPPING """"
" memo: レジスタz, マークz,k,lは用途あり
"       トグル系はunimpairedに倣い `yo-` でマップする
" - Reg z: 外部コマンドとのやり取り用バッファなど、一時的に使用
" - Mark z: 一時的な位置保存用
" - Mark k: ジャンプじゃない移動直前位置を保存（gmkが押しやすいのでこれにいれとく）
" - Mark l: 一定時間何もしなかった場合にその位置を記録（gml で考え事をしていた時の場所に戻るなど）

"""" ヘルパー関数 """"  {{{1

" IME off
if executable('imeoff.exe')
  command! ImeOff call system('imeoff.exe')
elseif executable('xvkbd')
  command! ImeOff call system('xvkbd -text "\[Muhenkan]"')
else
  command! ImeOff :
endif

" mark-k
noremap <SID>(mark-k) mKmk

" 色々解除
function! s:clear_things (clear_marker, clear_scrollbar)  " {{{
  " clear markers by neosnippet
  if a:clear_marker
    NeoSnippetClearMarkers
  endif

  " clear marker
  call clever_f#reset()

  " clear scrollbar
  "" context_filetype によるsyntax設定が壊されるので必要なときだけ呼ぶ
  silent let l:sc = dein#check_install('scrollbar')
  if a:clear_scrollbar && l:sc == 0
    lua require('scrollbar').clear()
  endif

  " disable spell check
  setlocal nospell
  " close preview window
  pclose
  " clear git-messeinger window
  GitMessengerClose

  echo ""
  redraw!
endfunction  " }}}
command! ClearWindow call s:clear_things(v:true, v:false)

" toggle - unimpaired like maps
nnoremap [TOGGLE] <Nop>
nmap yo [TOGGLE]
nnoremap [TOGGLE]c <cmd>setlocal cursorline!<CR><cmd>setlocal cursorline?<CR>
nnoremap [TOGGLE]u <cmd>setlocal cursorcolumn!<CR><cmd>setlocal cursorcolumn?<CR>
nnoremap [TOGGLE]x <cmd>setlocal cursorline! cursorcolumn!<CR><cmd>setlocal cursorline? cursorcolumn?<CR>
nnoremap [TOGGLE]n <cmd>setlocal number!<CR><cmd>setlocal number?<CR>
nnoremap [TOGGLE]r <cmd>setlocal relativenumber!<CR><cmd>setlocal relativenumber?<CR>
nnoremap [TOGGLE]w <cmd>setlocal wrap!<CR><cmd>setlocal wrap?<CR>


"""" 表示系 """"  {{{1

" ESC連打/<space><C-l>で検索ハイライト解除＆画面再描画＆保存
nnoremap <silent> <ESC><ESC>    <cmd>nohl<CR><cmd>call <SID>clear_things(v:true, v:false)<CR>
nnoremap <silent> <Leader><C-l> <cmd>nohl<CR><cmd>call <SID>clear_things(v:true, v:true)<CR>

" Scrollbar設定  {{{
nnoremap <Leader>s <cmd>call <SID>toggle_scrollbar()<CR>
function! s:toggle_scrollbar() abort
  silent let l:sc = dein#check_install('scrollbar')
  if l:sc != 0
    return
  endif

  if g:scrollbar_enabled
    let g:scrollbar_enabled = v:false
    lua require('scrollbar').clear()
    autocmd! ScrollbarInit
    let l:msg = "Disabling scrollbar..."
  else
    let g:scrollbar_enabled = v:true
    lua require('scrollbar').show()
    augroup ScrollbarInit
      autocmd!
      autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
      autocmd BufEnter,FocusGained           * silent! lua require('scrollbar').show()
      autocmd BufLeave,FocusLost             * silent! lua require('scrollbar').clear()
    augroup end
    let l:msg = "Enabling scrollbar..."
  endif
  if !has('vim_starting')
    echo l:msg
  endif
endfunction
let g:scrollbar_enabled = v:true
call s:toggle_scrollbar()
"" }}}

"""" 折りたたみ """"   {{{1
" 折りたたみ削除はアンドゥできないのでアンマップしておく
"" 必要ならビジュアルモードでやればOK
nnoremap zd <Nop>
nnoremap zD <Nop>
nnoremap zE <Nop>

" 折りたたみレベル増減時に値を出す
command! EchoFdl echo "foldlevel="..&foldlevel
nnoremap zm zmzv<cmd>EchoFdl<CR>
nnoremap zr zrzv<cmd>EchoFdl<CR>
" set foldlevel
nnoremap z0 <cmd>set foldlevel=0<CR>zv<cmd>EchoFdl<CR>
nnoremap z1 <cmd>set foldlevel=1<CR>zv<cmd>EchoFdl<CR>
nnoremap z2 <cmd>set foldlevel=2<CR>zv<cmd>EchoFdl<CR>
nnoremap z3 <cmd>set foldlevel=3<CR>zv<cmd>EchoFdl<CR>
nnoremap z4 <cmd>set foldlevel=4<CR>zv<cmd>EchoFdl<CR>

" 折りたたみを開く時に下の設定値よりネストが深ければ再帰的に開く
let g:foldpartiallevel = 2
nnoremap <expr> <Plug>(foldopen-partial)
    \ foldlevel('.')
    \ >= get(b:, 'foldpartiallevel', g:foldpartiallevel)
    \ ? 'zO' : 'zo'
nmap zo <Plug>(foldopen-partial)

" markdownのリストなどo/Oを上書きしたい時用に定義しておく
nnoremap <Plug>(o-newline) o
nnoremap <Plug>(O-newline) O
" カーソル下に折りたたみがあって閉じていればOで開く（再帰的）
" そうでなければデフォルトのo（新しい行でインサートモード）
nmap <expr> o foldclosed('.') != -1 ? "\<Plug>(foldopen-partial)" : "\<Plug>(o-newline)"
nmap <expr> O foldclosed('.') != -1 ? "\<Plug>(foldopen-partial)" : "\<Plug>(O-newline)"

" TODO: zc, zo, o をsubmodeで連打可能にしたい

" インサートモード出入りで折り畳みをなくす
augroup foldgroup
  autocmd!
  autocmd InsertEnter * let w:oldfdm = &l:foldmethod | setlocal foldmethod=manual
  autocmd InsertLeave *
    \ if exists('w:oldfdm') |
    \   let &l:foldmethod = w:oldfdm |
    \   unlet w:oldfdm |
    \ endif |
    \ normal! zv
augroup END


"""" MOUSE """"  {{{1
" マウスを使用可能にする
set mouse=a

" ノーマルモードで移動する前にマークしておく
" TODO: なんか動かん
" nnoremap <LeftMouse> <SID>(mark-k)<LeftMouse>

" インサートモードではクリック無効化
inoremap <LeftMouse> <Nop>

"""" 移動系 """"  {{{1
" 通常のバッファ内でしばらく何もしなかったら lマークを付ける
"" カーソル移動の高速化をリセット & コマンドラインになんか出てたら消す
augroup MyMarkGroup
  autocmd!
  autocmd User CursorHoldMarked call s:reset_fast_jk()
  autocmd User CursorHoldMarked echo ""
augroup END

" Space+Up/Down で移動量トグル  {{{
"" CursorHoldからリセットを呼ぶように後で設定
let g:movement_jk = 1
let g:movement_arrow = 1
function! s:toggle_fast_jk() abort
  if g:movement_arrow > 1
    call s:reset_fast_jk()
  else
    " let g:movement_jk = 3
    let g:movement_arrow = 5
  endif
  if !has('vim_starting')
    echo "j/k movement = " .. g:movement_jk .. ", Down/Up movement = " .. g:movement_arrow
  endif
endfunction
function! s:reset_fast_jk() abort
  let g:movement_jk = 1
  let g:movement_arrow = 1
endfunction
noremap <SID>(toggle_movement) <cmd>call <SID>toggle_fast_jk()<CR>

nmap <silent> <Space><Down> <SID>(toggle_movement)
nmap <silent> <Space><Up>   <SID>(toggle_movement)
" }}}

" 上下移動（行単位＆スクロール）  " {{{
" 表示行単位で上下移動する
"" 数字指定の場合は論理行単位で移動する（相対行表示通りに移動）
nnoremap <silent> <expr> j v:count ? 'j' : g:movement_jk..'gj'
nnoremap <silent> <expr> k v:count ? 'k' : g:movement_jk..'gk'
"" ビジュアルモード・オペレータ待機モードは一行ずつにしておく
xnoremap <expr> j v:count ? 'j' : 'gj'
onoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'
onoremap <expr> k v:count ? 'k' : 'gk'
"" 矢印キーも少し速く動けるようにする
nnoremap <expr> <Down> v:count ? 'j' : g:movement_arrow..'gj'
nnoremap <expr> <Up>   v:count ? 'k' : g:movement_arrow..'gk'
xnoremap <expr> <Down> v:count ? 'j' : 'gj'
xnoremap <expr> <Up>   v:count ? 'k' : 'gk'
"" 矢印キー（インサートモード）
"" <cmd>normal を使うとIME状態を保つようにできる
inoremap <Down> <cmd>normal! gj<CR>
inoremap <Up> <cmd>normal! gk<CR>

" gj/gk は行単位に入れ替えておく
nnoremap gj j
xnoremap gj j
onoremap gj j
nnoremap gk k
xnoremap gk k
onoremap gk k

" スムーズなスクロール
nnoremap <silent> <C-d> mk:<C-u>call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> mk:<C-u>call comfortable_motion#flick(-100)<CR>
"" Space+<C-d/u> で戻る＋画面の真ん中にもってくる
nnoremap <silent> <Leader><C-d> g`kzz
nnoremap <silent> <Leader><C-u> g`kzz

" 行頭行末への移動
"" 行末へ移動＋（ノーマルモードなら）1つ後ろへ移動
"" memo: ビジュアルモードの$はもともと1つ後ろへ移動する。オペレータ待機モードはしない
nnoremap <Leader>l mk$l
xnoremap <Leader>l mk$
onoremap <Leader>l $
"" インデントを含まない行頭と含む行頭をtoggleで移動, https://twitter.com/yuki_ycino/status/1336527468434317317
nnoremap <expr> <Leader>h getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? 'mk0' : 'mk^'
xnoremap <expr> <Leader>h getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? 'mk0' : 'mk^'
onoremap <expr> <Leader>h getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'

" 上下ブロック移動（vim-edgemotion）
nmap <Leader>j <SID>(mark-k)<Plug>(edgemotion-j)
xmap <Leader>j <SID>(mark-k)<Plug>(edgemotion-j)
omap <Leader>j <SID>(mark-k)<Plug>(edgemotion-j)
nmap <Leader>k <SID>(mark-k)<Plug>(edgemotion-k)
xmap <Leader>k <SID>(mark-k)<Plug>(edgemotion-k)
omap <Leader>k <SID>(mark-k)<Plug>(edgemotion-k)

" インサートモードでzsh-likeな移動
"" memo: CTRL-G U == 次のカーソル移動でundoを分割しない
inoremap <C-a> <C-g>U<Home>
inoremap <C-e> <C-g>U<End>
inoremap <C-b> <C-g>U<Left>
inoremap <C-f> <C-g>U<Right>

" 対応するカッコ (match) への移動
"" %へのマップはnxoでそれぞれ違うことに注意する
nmap <Leader>m <SID>(mark-k)<Plug>(matchup-%)
xmap <Leader>m <SID>(mark-k)<Plug>(matchup-%)
omap <Leader>m <Plug>(matchup-%)

" }}}

" easy-motion  " {{{
" s は vim-sandwithのprefixでもあるのでssにする
" anywhere: 設定でジャンプ先を減らしている
nmap ss <SID>(mark-k)<Plug>(easymotion-jumptoheads)
xmap ss <SID>(mark-k)<Plug>(easymotion-jumptoheads)
omap ss <Plug>(easymotion-jumptoheads)
nmap se <SID>(mark-k)<Plug>(easymotion-jumptoends)
xmap se <SID>(mark-k)<Plug>(easymotion-jumptoends)
omap se <Plug>(easymotion-jumptoends)
" jump to word
nmap s, <SID>(mark-k)<Plug>(easymotion-bd-w)
xmap s, <SID>(mark-k)<Plug>(easymotion-bd-w)
omap s, <Plug>(easymotion-bd-w)
" jump with a character
nmap sf <SID>(mark-k)<Plug>(easymotion-bd-f)
xmap sf <SID>(mark-k)<Plug>(easymotion-bd-f)
omap sf <Plug>(easymotion-bd-f)
" linewise
nmap sl <SID>(mark-k)<Plug>(easymotion-bd-jk)
xmap sl <SID>(mark-k)<Plug>(easymotion-bd-jk)
omap sl <Plug>(easymotion-bd-jk)
" last pattern
nmap s/ <SID>(mark-k)<Plug>(easymotion-bd-n)
xmap s/ <SID>(mark-k)<Plug>(easymotion-bd-n)
omap s/ <Plug>(easymotion-bd-n)
" overwin
nmap SS <SID>(mark-k)<Plug>(easymotion-overwin-w)

" }}}

"""" ウィンドウ＆バッファ操作 """"  {{{1
" buffer 移動 (barbar.nvim)
silent let s:bf = dein#check_install('barbar.nvim')
if s:bf == 0
  nnoremap ]b <cmd>BufferNext<CR>
  nnoremap [b <cmd>BufferPrevious<CR>
  nnoremap <Leader>]b <cmd>BufferMoveNext<CR>
  nnoremap <Leader>[b <cmd>BufferMovePrevious<CR>
  nnoremap sb <cmd>BufferPick<CR>
else
  nnoremap ]b <cmd>bnext<CR>
  nnoremap [b <cmd>bprev<CR>
  nnoremap <Leader>]b <Nop>
  nnoremap <Leader>[b <Nop>
  nnoremap sb <Nop>
endif

" tab
nnoremap ]t <cmd>tabn<CR>
nnoremap [t <cmd>tabp<CR>

" ZQ(終了)は潰す
nnoremap ZQ <Nop>
" windowsのnvimだとCTRL-Zでsuspendedできない
" 誤爆するとターミナル全体が固まるので潰しておく
if has('win64') && has('nvim')
  nnoremap <C-z> <Nop>
endif

" バッファ閉じる
nnoremap <Leader>w :<C-u>bd<CR>

" Ctrl+hjkl でvimウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" winresizer
"" lazyloadのために変数指定とマップを両方しておく
let g:winresizer_start_key = '<C-w><C-w>'
nnoremap <C-w><C-w> :<C-u>WinResizerStartResize<CR>

"""" GIT """"  {{{1

nnoremap [GIT] <Nop>
nmap <Leader>g [GIT]

" gitgutter
"" move on hunk
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)
"" open hunks list on quickfix
nmap [GIT]hl <cmd>ToggleQLtoQ<CR><cmd>GitGutterQuickFix<CR><cmd>cwindow<CR>
"" stage/undo a hunk
nmap [GIT]hs <Plug>(GitGutterStageHunk)
nmap [GIT]hu <Plug>(GitGutterUndoHunk)
"" preview hunk's changes
nmap [GIT]hp <Plug>(GitGutterPreviewHunk)

" gina.vim
" TODO: git statusはfloatwindowか上半分くらいで出したい
nnoremap [GIT]s :<C-u>Gina status<CR>
nnoremap [GIT]d :<C-u>Gina diff<CR>
nnoremap <expr> [GIT]a ':<C-u>Gina add '.. expand('%:p') ..'<CR>'
nnoremap [GIT]c :<C-u>Gina commit<CR>
nnoremap [GIT]p :<C-u>Gina push<CR>

" git blame
nnoremap [GIT]b :<C-u>BlamerToggle<CR>
" git-messenger
nnoremap [GIT]m :<C-u>GitMessenger<CR>
" Open GitHub
nnoremap [GIT]x :<C-u>OpenGithubProject<CR>


"""" 編集補助 """"  {{{1
" s はeasymotionとvim-sandwithのprefixになっているので消しとく
"" もともとのsはclで代用可能
nnoremap s <Nop>
nnoremap S <Nop>

" jj でインサートモードを抜ける
"" 他のモードでもjjしたらIME offする
noremap <silent> っｊ :<C-u>ImeOff<CR>
nnoremap <silent> ｊ :<C-u>ImeOff<CR>
inoremap <silent> っｊ <ESC>
inoremap <silent> ｊｊ <ESC>
inoremap <silent> jj <ESC>
nnoremap <silent> <CR> :<C-u>ImeOff<CR>
"" jを打てるようにしておく
inoremap <silent> j<Space> j

" インサートモードで左移動
"" jjiでもできるけど割と頻繁に打ち間違えるのでいくつかセットしておく
"" カッコ入力直後だとShiftキーが効いてしまう時があるので大文字もセットしておく
inoremap <silent> jk   <C-g>U<Left>
inoremap <silent> Jk   <C-g>U<Left>
inoremap <silent> JK   <C-g>U<Left>
inoremap <silent> ｊｋ <C-g>U<Left>
" 右移動
"" kjを設定していたけど最後がkで終わる単語はそこそこあるので気になった
"" 左より使用頻度少ないのでひとつだけいれとく
inoremap <silent> jij  <C-g>U<Right>
inoremap <silent> Jij  <C-g>U<Right>
inoremap <silent> JIj  <C-g>U<Right>
inoremap <silent> JIJ  <C-g>U<Right>
inoremap <silent> じｊ <C-g>U<Right>
" 上移動
" 移動後、空行ならインデントする
inoremap <expr> <SID>(insert_autoindent) len(getline('.')) ? '' : '<ESC>"_cc'
imap jl <cmd>normal! gk<CR><SID>(insert_autoindent)

" ;の次にスペース以外を打つことはほとんどないのでマップ起点にする
inoremap <silent> ;; ;
inoremap <silent> ;h <C-g>U<Left>
inoremap <silent> ;j <C-g>U<Down>
inoremap <silent> ;k <C-g>U<Up>
inoremap <silent> ;l <C-g>U<Right>

" quickrun起点
imap <silent> ;r <ESC><Leader>r

"" インサートモードを抜けた時に IME off する
"" マルチバイト文字検索した後にも抜けれるようにする
augroup ImeOffGroup
  autocmd!
  autocmd InsertLeave * ImeOff
  autocmd CmdlineLeave /,\?,: ImeOff
augroup END

" spell check on/off
nnoremap [TOGGLE]s <cmd>setlocal spell!<CR>
" gs でスペルミスを解消 (go correct spell)
"" gs, [s, ]s をスペルチェックoffのときでも使えるようにする
"" メモ: デフォルトのgsはスリープ
nnoremap gs :<C-u>setlocal spell<CR>1z=
nnoremap [s :<C-u>setlocal spell<CR>[s
nnoremap ]s :<C-u>setlocal spell<CR>]s

" i/A で編集を始めたときにオートインデントする
"" a,A は入れ替える
nnoremap <expr> <SID>(i_autoindent) len(getline('.')) ? 'i' : '"_cc'
nnoremap <expr> <SID>(A_autoindent) len(getline('.')) ? 'A' : '"_cc'
nmap i <SID>(i_autoindent)
nmap a <SID>(A_autoindent)
nnoremap I I
nnoremap A a
nnoremap <Leader>i I
nnoremap <Leader>a a

" IMEオンになってしまった場合の対応
nmap い i
nmap あ a

" 改行などでUndoを区切る
" inoremap <silent> <CR> <C-g>u<CR>
"" CRは補完設定のところでやる
inoremap <silent> <C-w> <C-g>u<C-w>

" operator-replace
"" r/Rで入れる置換モードは普段使わないので潰す
nmap r <Plug>(operator-replace)
xmap r <Plug>(operator-replace)
nmap rr <cmd>normal! V<CR><Plug>(operator-replace)
nmap R <Plug>(operator-replace)$

" operator-trailingspace-killer
nmap g= <Plug>(operator-trailingspace-killer)
xmap g= <Plug>(operator-trailingspace-killer)
nmap g== <cmd>normal! V<CR><Plug>(operator-trailingspace-killer)

" vim-preciousのトグル
"" yof: filetype の f
nnoremap <expr> [TOGGLE]f
      \  get(b:, 'precious_switch_lock', 0)
      \    ? "\<cmd>echo 'precious-unlocked'<CR>\<cmd>PreciousSwitchUnlock\<CR>"
      \    : "\<cmd>echo 'precious-locked'<CR>\<cmd>PreciousSwitchLock\<CR>"

" ビジュアルモードで選択範囲拡大／縮小
xmap + <Plug>(expand_region_expand)
xmap _ <Plug>(expand_region_shrink)

" ビジュアルモードでのインデントを連続入力できるようにする＆２回押しが必要にする
xnoremap > <Nop>
xnoremap < <Nop>
xnoremap >> >gv
xnoremap << <gv

" " dial.nvim
" nmap <C-a> <Plug>(dial-increment)
" nmap <C-x> <Plug>(dial-decrement)
" "" ビジュアルモードでのインクリメント/デクリメントを連続入力可にする
" vmap <C-a> <Plug>(dial-increment)gv
" vmap <C-x> <Plug>(dial-decrement)gv
" xmap g<C-a> <Plug>(dial-increment-additional)gv
" xmap g<C-x> <Plug>(dial-decrement-additional)gv

" gmをマークにする（go mark *）
"" memo: もとのgmは画面幅の真ん中にカーソルを持ってくる
nnoremap gm `

" 任意文字で行連結
"" J ==> 一文字
nmap J <Plug>(jplus-getchar)
xmap J <Plug>(jplus-getchar)
"" <Space>J ==> 複数文字
nmap <Leader>J <Plug>(jplus-input)
xmap <Leader>J <Plug>(jplus-input)

" 語頭を大文字小文字切り替え
"" wordをヤンクすると語頭にカーソルが行くことを利用（マークを使ってカーソルを戻す）
nnoremap <SID>(switch-case-wordhead) mz"_yiwg~lg`z
nmap <Leader>` <SID>(switch-case-wordhead)
" 行頭を大文字小文字切り替え
nnoremap <LocalLeader>` mzV"_y~g`z

" Ctrl+Up/Downで行入れ替え
nnoremap <C-Up> k"zdd"zpk
nnoremap <C-Down> "zdd"zp

" Ctrl+Right/Left で選択開始
nnoremap <C-Right> v<C-Right>
nnoremap <C-Left> v<C-Left>

" Ctrl+s で画面再描画＆保存, insert modeの場合はノーマルモードに戻る
nnoremap <silent> <C-s> <cmd>nohl<CR><cmd>call <SID>clear_things(v:false, v:false)<CR>:update<CR>
xmap <silent> <C-s> <ESC><C-s>
"" 補完中なら、現在の候補を確定させてから保存する
imap <expr><silent> <C-s> pumvisible() ? "\<C-y>\<ESC>\<C-s>" : "\<ESC>\<C-s>"

" インサートモード中にC-o２連打で新行作れるようにする
"" 挿入ノーマルモードでの C-o o と等価にする
nmap <expr> <C-o> mode(1)=="niI" ? "o" : "\<C-o>"

" Undo-tree
"" default のUはややこしいので潰してOK
nnoremap U <cmd>MundoToggle<CR>

" switch.vim
nnoremap <Leader>t <cmd>Switch<CR>

" F5 で Goyo
nnoremap <F5> :<C-u>Goyo<CR>

" vim-easy-align
nmap gA <Plug>(EasyAlign)
xmap gA <Plug>(EasyAlign)

" linediff
xnoremap <Leader>d :Linediff<CR>


"""" 補完 """"  {{{1

"" Xモードのヒント  {{{2
" 参考：https://koturn.hatenablog.com/entry/2018/02/10/170000
" 入力キーの辞書
let s:compl_key_dict = {
      \ char2nr("\<C-l>"): "\<C-x>\<C-l>",
      \ char2nr("\<C-n>"): "\<C-x>\<C-n>",
      \ char2nr("\<C-p>"): "\<C-x>\<C-p>",
      \ char2nr("\<C-k>"): "\<C-x>\<C-k>",
      \ char2nr("\<C-t>"): "\<C-x>\<C-t>",
      \ char2nr("\<C-i>"): "\<C-x>\<C-i>",
      \ char2nr("\<C-]>"): "\<C-x>\<C-]>",
      \ char2nr("\<C-f>"): "\<C-x>\<C-f>",
      \ char2nr("\<C-d>"): "\<C-x>\<C-d>",
      \ char2nr("\<C-v>"): "\<C-x>\<C-v>",
      \ char2nr("\<C-u>"): "\<C-x>\<C-u>",
      \ char2nr("\<C-o>"): "\<C-x>\<C-o>",
      \ char2nr('s'): "\<C-x>s",
      \ char2nr("\<C-s>"): "\<C-x>s"
      \}
" 表示メッセージ
let s:hint_i_ctrl_x_msg = join([
      \ '<C-l>: While lines',
      \ '<C-n>: keywords in the current file (next)',
      \ '<C-p>: keywords in the current file (previous)',
      \ "<C-k>: keywords in 'dictionary'",
      \ "<C-t>: keywords in 'thesaurus'",
      \ '<C-i>: keywords in the current and included files',
      \ '<C-]>: tags',
      \ '<C-f>: file names',
      \ '<C-d>: definitions or macros',
      \ '<C-v>: Vim command-line',
      \ "<C-u>: User defined completion ('completefunc')",
      \ "<C-o>: omni completion ('omnifunc')",
      \ "s: Spelling suggestions ('spell')"
      \], "\n")
function! s:hint_i_ctrl_x() abort
  echo s:hint_i_ctrl_x_msg
  let c = getchar()
  return get(s:compl_key_dict, c, nr2char(c))
endfunction

inoremap <expr> <C-x>  <SID>hint_i_ctrl_x()
inoremap <C-x><C-l> <C-x><C-l>
inoremap <C-x><C-n> <C-x><C-n>
inoremap <C-x><C-p> <C-x><C-p>
inoremap <C-x><C-k> <C-x><C-k>
inoremap <C-x><C-t> <C-x><C-t>
inoremap <C-x><C-i> <C-x><C-i>
inoremap <C-x><C-]> <C-x><C-]>
inoremap <C-x><C-f> <C-x><C-f>
inoremap <C-x><C-d> <C-x><C-d>
inoremap <C-x><C-v> <C-x><C-v>
inoremap <C-x><C-u> <C-x><C-u>
inoremap <C-x><C-o> <C-x><C-o>
inoremap <C-x>s <C-x>s
" }}}

"" F3で補完のオンオフ  {{{2
" TODO: ここg:なのおかしいのでは。。。
function! SetCompletionState (is_enabled)
  let g:state_deoplete_completion = a:is_enabled
  call deoplete#custom#buffer_option('auto_complete', g:state_deoplete_completion)
endfunction

function! ToggleCompletion ()
  if (g:state_deoplete_completion)
    echo "Deoplete: disabled"
    call SetCompletionState(v:false)
  else
    echo "Deoplete: enabled"
    call SetCompletionState(v:true)
  endif
endfunction
command! ToggleCompletion call ToggleCompletion()

" デフォルトONなので判定用の変数だけいれとく
let g:state_deoplete_completion = v:true

" F3, yod で補完ON/OFF
nnoremap [TOGGLE]d <cmd>ToggleCompletion<CR>
nnoremap <F3> :<C-u>ToggleCompletion<CR>
inoremap <F3> <ESC>:<C-u>ToggleCompletion<CR>a
" }}}

"" Neosnippet/Deoplete  {{{2

"" C-kでスニペット展開orジャンプ or ダイグラフ開始 or 補完候補がなければ補完を開く
inoremap <SID>(digraph) <C-k>
imap <expr> <C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
  \                                      pumvisible() ? "\<SID>(digraph)" : deoplete#manual_complete()
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" ESC/CR でキャンセル・確定
"" CRはUndoを区切るようにする
inoremap <expr> <Esc>  pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" [Shift+]Tabでも補完候補の選択ができるようにする
inoremap <expr><Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }}}

"" Language Server Protocol  {{{2
" gl はもともとの割当なし
nnoremap [LSP] <Nop>
nmap gl [LSP]
nnoremap [LSP]<Space> <cmd>LspStatus<CR>

" K / Space+K でヘルプを出す
"" LSPがある場合は Space+Kがホバーになる
nnoremap <Leader>K K

" 初期化設定
augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
function! s:on_lsp_buffer_enabled() abort  " {{{
  " TODO: vim-preciousによるコンテキストスイッチが
  " 有効だと範囲外領域を診断してうざいので切りたい
  setlocal signcolumn=yes
  if &omnifunc ==# ''
    setlocal omnifunc=lsp#complete
  endif

  nmap <buffer> gd <Plug>(lsp-definition)zv

  nmap <buffer> [LSP]d <Plug>(lsp-definition)zv
  nnoremap <buffer> [LSP]s <cmd>CtrlPLspDocumentSymbol<CR>
  nnoremap <buffer> [LSP]S <cmd>CtrlPLspWorkspaceSymbol<CR>
  nmap <buffer> [LSP]r <Plug>(lsp-references)
  nmap <buffer> [LSP]i <Plug>(lsp-implementation)
  nmap <buffer> [LSP]t <Plug>(lsp-type-definition)
  nmap <buffer> [LSP]n <Plug>(lsp-rename)

  nnoremap <buffer> [LSP]f <cmd>LspDocumentFormatSync<CR>
  nnoremap <buffer> [LSP]l <cmd>ToggleQLtoL<CR><cmd>LspDocumentDiagnostics<CR>
  nmap <silent><buffer> [g <Plug>(lsp-previous-diagnostic)zv
  nmap <silent><buffer> ]g <Plug>(lsp-next-diagnostic)zv
  nmap <silent><buffer> [e <Plug>(lsp-previous-error)zv
  nmap <silent><buffer> ]e <Plug>(lsp-next-error)zv
  nmap <silent><buffer> [w <Plug>(lsp-previous-warning)zv
  nmap <silent><buffer> ]w <Plug>(lsp-next-warning)zv

  nmap <buffer> <Leader>K  <Plug>(lsp-hover)
  if has('nvim-0.5') && &tagfunc ==# ''
    setlocal tagfunc=lsp#tagfunc
  endif
  nnoremap <buffer> <Plug>(toggle_vista) <cmd>Vista vim_lsp<CR>

  echom "LSP enabled: ft=".. &ft .. ", " .. expand("%")
endfunction  " }}}

" }}}

"""" 検索系 """"  {{{1

" tagstack
nnoremap <C-]> g<C-]>

" 指定したレジスタの中身を移動せずに検索してハイライト＆コマンドラインに表示
command! -nargs=1 SetHighlightReg execute "let @/ = @" . "<args>" | set hlsearch | echo "/" .. @/
" カーソル下の単語をハイライト (feedkeysを使うのでノーマルモード以外から呼んではダメ)
function s:toggle_hlsearch_regz() abort  " {{{
  " ハイライトされている（v:hlsearch==1） かつ
  " カーソル下単語と検索レジスタが一致する場合、nohlを呼ぶ
  " それ以外の場合は検索レジスタをセット
  if v:hlsearch && (@/ ==# @z)
    call feedkeys(":nohls\n", 'n')
  else
    let @/ = @z
    call feedkeys(":set hlsearch\n", 'n')
    echo "/"..@/
  endif
endfunction  " }}}
nnoremap <Space><Space> mz"zyiw`z<cmd>call <SID>toggle_hlsearch_regz()<CR>
" 選択範囲を検索する
xnoremap / "zy:<C-u>SetHighlightReg z<CR>

" n/N: ハイライトされていれば通常通り、なければまずhlsearch
"" マップの中で実行されたジャンプは折りたたみ展開しないのでzvを呼んでおく
nnoremap <expr> n v:hlsearch ? "nzv" : ":SetHighlightReg /\<CR>"
nnoremap <expr> N v:hlsearch ? "Nzv" : ":SetHighlightReg /\<CR>"

" verymagic
nnoremap g/ /\v
cnoremap <C-z> <Home>\v<End>

" Ctrl+F でripgrepの入力待状態にする
nnoremap <C-f> <cmd>ToggleQLtoQ<CR>:<C-u>Rg<Space>''<Left>
xnoremap <C-f> <cmd>ToggleQLtoQ<CR>"zy:<C-u>Rg '<C-r>z'<CR>
" Space -> Ctrl+F でカーソル下ワードをripgrepする
"" <Space>2連打の検索を呼んでバッファ内にハイライトも付ける
nnoremap <Leader><C-f>  <cmd>ToggleQLtoQ<CR>mz"zyiw`z:<C-u>SetHighlightReg z<CR>:Rg "<C-r>/"<CR>


" openbrowser  {{{
nnoremap [WEB] <Nop>
xnoremap [WEB] <Nop>
nmap <Leader>/ [WEB]
xmap <Leader>/ [WEB]

"" 単語を入力してgoogle検索する
nnoremap [WEB]/g :<C-u>OpenBrowserSearch -google<Space>
nnoremap [WEB]/w :<C-u>OpenBrowserSearch -weblio<Space>
nnoremap [WEB]/a :<C-u>OpenBrowserSearch -alc<Space>
"" カーソル下の単語を検索する
nnoremap <expr> [WEB]g ":\<C-u>OpenBrowserSearch -google ".expand('<cword>')."\<CR>"
nnoremap <expr> [WEB]w ":\<C-u>OpenBrowserSearch -weblio ".expand('<cword>')."\<CR>"
nnoremap <expr> [WEB]a ":\<C-u>OpenBrowserSearch -alc ".expand('<cword>')."\<CR>"
"" ビジュアルモードで選択した部分を検索する
xnoremap [WEB]g "zy:<C-u>OpenBrowserSearch <C-r>z<CR>
xnoremap [WEB]w "zy:<C-u>OpenBrowserSearch -weblio <C-r>z<CR>
xnoremap [WEB]a "zy:<C-u>OpenBrowserSearch -alc <C-r>z<CR>
" }}}

" translate a sentence under cursor  {{{
"" transコマンドは`brew install translate-shell`で用意しておく
command! TranslateShell execute '!cat "~/.vimbuffer" | trans {en=ja} --no-ansi'
command! TranslateShellDict execute '!cat "~/.vimbuffer" | trans {en=ja} -d --no-ansi'
"" 文を翻訳：ノーマルモードならその行、ビジュアルなら選択範囲を翻訳する
xnoremap [WEB]t "zy:<C-u>BufferRegZ<CR>:Capture TranslateShell<CR>
nnoremap [WEB]t V"zy:<C-u>BufferRegZ<CR>:Capture TranslateShell<CR>
"" 単語を翻訳（辞書モード）
xnoremap [WEB]d "zy:<C-u>BufferRegZ<CR>:Capture TranslateShellDict<CR>
nnoremap [WEB]d "zyiw:<C-u>BufferRegZ<CR>:Capture TranslateShellDict<CR>
nnoremap [WEB]/de :<C-u>Capture !trans --no-ansi -d {en=ja}<Space>
nnoremap [WEB]/dj :<C-u>Capture !trans --no-ansi -d {ja=en}<Space>
" }}}

" Fern
nnoremap <C-e> <cmd>Fern . -drawer -reveal=%<CR>

" vista.vim
"" vimtexのToCなどファイルタイプごとの目次機能がある場合はC-bをそっちに割り当てる
nnoremap <Plug>(toggle_vista) <cmd>Vista<CR>
nmap <C-b> <Plug>(toggle_vista)
nmap <Space><C-b> <Plug>(toggle_vista)

" Space+x でexplorerを開く
if has('win64')
  command! OpenExplorer call system("explorer.exe "..'"'..getcwd()..'"')
  "" 最後の<CR>がないとシェルコマンドの返り値が出てうるさいので消しておく
  nnoremap <Leader>x :<C-u>OpenExplorer<CR>
else
  " TODO: Implement for linux
  nnoremap <Leader>x <Nop>
endif


"""" q-related, Quickfix """"  {{{1

" Macro  " {{{
"" q[ ] は混み合っているのでq単発でマクロ開始は消す
nnoremap q <Nop>
"" Q/qq で開始する
"" note: レジスタqに記録開始する場合は qqq と三連打必要
nnoremap Q q
nnoremap qq q

" @にはpeekaboo立ち上げがマップされている
"" @@でリピートするときにもpeekabooの窓が立ち上がるとうるさいので、
"" わざと被らせて入力待ちの場合のみ出すようにする
nnoremap @@ @@
" }}}

" Quickfix  {{{
"" cyclic next/prev
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

"" clear quickfix
command! Cclear cexpr [] | cclose
command! Lclear lexpr [] | lclose

function! s:toggle_QL_mapping (force_location, force_quickfix)
  let g:mapping_quickfix = exists('g:mapping_quickfix') ? g:mapping_quickfix : 0
  let l:map_to_loc = a:force_location || ( !a:force_quickfix && g:mapping_quickfix )
  if l:map_to_loc
    let g:mapping_quickfix = 0
    nnoremap qj :<C-u>Lnext<CR>zv
    nnoremap qk :<C-u>Lprev<CR>zv
    nnoremap qo :<C-u>lopen<CR>
    nnoremap qc :<C-u>lclose<CR>
    nnoremap qw :<C-u>lopen<CR>
    let l:msg = "Mapping for location list"
  else
    let g:mapping_quickfix = 1
    nnoremap qj :<C-u>Cnext<CR>zv
    nnoremap qk :<C-u>Cprev<CR>zv
    nnoremap qo :<C-u>copen<CR>
    nnoremap qc :<C-u>cclose<CR>
    nnoremap qw :<C-u>copen<CR>
    let l:msg = "Mapping for quickfix list"
  endif
  if !has('vim_starting')
    echo l:msg
  endif
endfunction
command! ToggleQL call <SID>toggle_QL_mapping(0, 0)
command! ToggleQLtoQ call <SID>toggle_QL_mapping(0, 1)
command! ToggleQLtoL call <SID>toggle_QL_mapping(1, 0)
nnoremap <silent> [TOGGLE]q <cmd>ToggleQL<CR>
silent call s:toggle_QL_mapping(0, 1)

" }}}


"""" Cmdwin """"  {{{1
nnoremap q: q:
nnoremap q; q:
nnoremap q/ q/
nnoremap q? q?

nnoremap <SID>(QuitCmdwin) o<CR>

augroup complete_myrc
  autocmd!

  " 左端に出るものを消す
  autocmd CmdwinEnter * setlocal nonumber
  autocmd CmdwinEnter * setlocal norelativenumber
  autocmd CmdwinEnter * setlocal signcolumn=no
  autocmd CmdwinEnter * setlocal foldcolumn=0

  " qw, ESC連打 で戻れるようにする
  " C-j で実行させる
  autocmd CmdwinEnter * nmap <buffer> qw <SID>(QuitCmdwin)
  autocmd CmdwinEnter * nmap <buffer> <ESC><ESC> <SID>(QuitCmdwin)
  autocmd CmdwinEnter * nnoremap <buffer> <C-j> <CR>
augroup END


"""" QuickRun """"  {{{1
" rr でファイルを実行
" r+textobj で範囲実行
nmap <Leader>r  <cmd>w<CR><Plug>(quickrun-op)
nmap <Leader>rr <cmd>w<CR><Plug>(quickrun)
xmap <Leader>r  <cmd>w<CR>gv<Plug>(quickrun)
" rt で context_filetype によるブロックを実行
"" run-block ということでrbにしてもよかったが打ちにくいのでrtにした
nmap <Leader>rt <cmd>w<CR><Plug>(precious-quickrun-op)<Plug>(textobj-precious-i)


"""" コピーペースト関係 """"  {{{1
" gyで最後にヤンクしたテキストを選択
"" もしくは最後に操作したテキスト範囲
nnoremap gy mk`[v`]
xnoremap gy mko`[o`]

" ヤンク前にはマーク(k)を付けておく
"" yyが潰されるので再マップしておく
"" レジスタを受け取れるようにexprで定義する
nnoremap <expr> y  'mk"' .. v:register .. 'y'
xnoremap <expr> y  'mk"' .. v:register .. 'y'
nnoremap <expr> yy 'mk"' .. v:register .. 'yy'
" 行末までヤンク
nnoremap <expr> Y  'mk"' .. v:register .. 'y$'

" x の一文字消去でレジスタを汚さないようにする
xnoremap x "_x
xnoremap X "_X
"" normal modeでのxはアンドゥを分割しない
"" (設定はplugins.tomlに移した)
" nnoremap x "_x
" nnoremap X "_X

" Clipboard連携
vnoremap <C-c> mk"+y
inoremap <S-Insert> <C-r>+

" ペーストモードをF2でトグル
set pastetoggle=<F2>

" i_<C-r> によるペーストで直ぐにPeekabooが立ち上がると
" うるさいのでいくつかマップしておく
inoremap <C-r>0 <C-r>0
inoremap <C-r>1 <C-r>1
inoremap <C-r>% <C-r>%
inoremap <C-r>/ <C-r>/

" yankround + ctrlp
"" C-p でCtrlpもしくはYankrond-previousを呼ぶ
"" note: CTRL-N は j と同じなので実質開いてる
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <expr> <C-n> yankround#is_active() ? "\<Plug>(yankround-next)" : "\<C-n>"
nmap <expr> <C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : "\<cmd>CtrlP\<CR>"



"""" Fuzzy Finder """"  {{{1

" Space+f+[ ] で ctrlp の色々な拡張を呼び出す
"" 入力しなければモード選択状態で立ち上げる
nnoremap [CtrlP] :<C-u>CtrlPMenu<CR>
nmap  <Leader>f <SID>(mark-k)[CtrlP]
nnoremap [CtrlP]f :<C-u>CtrlP<CR>
nnoremap [CtrlP]c :<C-u>CtrlPCmdPalette<CR>
nnoremap [CtrlP]p :<C-u>CtrlPCmdPalette<CR>
nnoremap [CtrlP]; :<C-u>CtrlPCmdline<CR>
nnoremap [CtrlP]b :<C-u>CtrlPBuffer<CR>
nnoremap [CtrlP]l :<C-u>CtrlPLine<CR>
nnoremap [CtrlP]u :<C-u>CtrlPMRUFiles<CR>
nnoremap [CtrlP]q :<C-u>cclose<CR>:CtrlPQuickfix<CR>
nnoremap [CtrlP]h :<C-u>CtrlPHelp<CR>
nnoremap [CtrlP]g :<C-u>CtrlPGhq<CR>
nnoremap [CtrlP]t :<C-u>CtrlPTag<CR>

nnoremap [Denite] <cmd>Denite source -start-filter<CR>
nmap <Leader>; <SID>(mark-k)[Denite]
nnoremap [Denite]u <cmd>Denite file_mru -start-filter<CR>
nnoremap [Denite]y <cmd>Denite neoyank<CR>
nnoremap [Denite]m <cmd>Denite mark<CR>
nnoremap [Denite]r <cmd>Denite register<CR>
nnoremap [Denite]c <cmd>Denite command -start-filter<CR>
nnoremap [Denite]p <cmd>Denite command -start-filter<CR>
nnoremap [Denite]; <cmd>Denite command_history -start-filter<CR>
nnoremap [Denite]l <cmd>Denite line -start-filter<CR>

"""" Terminal mode (Deol) """"  {{{1

" TODO: bash_profileを読み込んでほしい
command! DeolBash Deol -command bash -split=horizontal

" ZZ でDeol起動 or バッファに戻る
if has('gui')
  nnoremap ZZ <cmd>DeolBash<CR>
else
  nnoremap ZZ <cmd>ClearWindow<CR><cmd>xa<CR>
endif

tnoremap ZZ <C-\><C-n><C-w><C-q>
tnoremap jj <C-\><C-n>
tnoremap j<Space> j

" ESCでインサートモードを抜ける（C-\ C-n と入れ替え）
"" 初期設定でESCでないのはESCを受け付けるプログラムの実行時用らしいが、
"" とりあえず困らないので無視
"" 困るケースに出会ったら考える
tnoremap <ESC> <C-\><C-n>
tnoremap <C-\><C-n> <ESC>


"""" Commandline keymap """"  {{{1
" ;でコマンドラインモードに入れるようにする
"" 素の;は使ってないので潰す
nnoremap ; :
xnoremap ; :

" emacs-likeのカーソル移動
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" 左移動
cnoremap jk <Left>
cnoremap j<Space> j

" 普段はignorecase+smartcaseだが、
" コマンドの補完でだけnosmartcaseにする
cnoremap <expr> <Tab>
    \ '<cmd>set nosmartcase<CR>'
    \ ..nr2char(&wildcharm)
    \ ..'<cmd>let &smartcase = '..g:smartcase_stashed..'<CR>'
augroup cmdline_nosmartcase_gruop
  autocmd!
  autocmd CmdlineEnter : let g:smartcase_stashed=&smartcase
augroup END


"""" その他 """"  {{{1

" vim-which-key
nnoremap <silent> <Leader>? :<C-u>WhichKey '<Space>'<CR>
nnoremap <silent> <LocalLeader>? :<C-u>WhichKey '\'<CR>
xnoremap <silent> <Leader> :<C-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> [? :<C-u>WhichKey '['<CR>
nnoremap <silent> ]? :<C-u>WhichKey ']'<CR>

" check syntax and highlight
nnoremap <Leader>v <cmd>VimShowHlGroup<CR>

