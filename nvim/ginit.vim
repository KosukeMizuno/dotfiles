" Config for neovim-qt

" font
set guifont=HackGenNerd\ Console:h14
set guifontwide=HackGenNerd\ Console:h14

" GUI
GuiTabline 0
GuiPopupmenu 0

" インサートモードでは右クリックコンテキストメニュー表示
inoremap <silent><RightMouse> <cmd>call GuiShowContextMenu()<CR>

