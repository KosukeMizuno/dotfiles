" Vim color file
" Author: Kosuke Mizuno
" Colorscheme Name: monokai_mod
" This folor is forked from phanviet/vim-monokai-pro

if !has('vim_starting')
  set background=dark
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = "monokai_mod"

" Default group
hi Cursor ctermfg=236 ctermbg=231 cterm=NONE guifg=#2d2a2e guibg=#fcfcfa gui=NONE
hi SignColumn ctermfg=NONE ctermbg=237 cterm=NONE guibg=#3a3a3a guifg=NONE guisp=NONE gui=NONE
hi Visual ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#403e41 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#423f42 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#423f42 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#423f42 gui=NONE
hi LineNr ctermfg=246 ctermbg=59 cterm=NONE guifg=#959394 guibg=#423f42 gui=NONE
hi VertSplit ctermfg=59 ctermbg=59 cterm=NONE guifg=#696769 guibg=#696769 gui=NONE
hi MatchParen ctermfg=204 ctermbg=NONE cterm=underline guifg=#ff6188 guibg=NONE gui=underline
hi StatusLine ctermfg=231 ctermbg=59 cterm=bold guifg=#fcfcfa guibg=#696769 gui=bold
hi StatusLineNC ctermfg=231 ctermbg=59 cterm=NONE guifg=#fcfcfa guibg=#696769 gui=NONE
hi Pmenu ctermfg=0 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=#000000 gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#403e41 gui=NONE
hi IncSearch ctermfg=236 ctermbg=221 cterm=NONE guifg=#2d2a2e guibg=#ffd866 gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=#ff0000 guibg=#222222 gui=underline
hi Directory ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
hi Folded ctermfg=189 ctermbg=60 cterm=NONE guifg=#dddddd guibg=#333333 gui=NONE
hi FoldColumn guifg=#959394 guibg=#423f42 gui=NONE
hi Normal ctermfg=231 ctermbg=236 cterm=NONE guifg=#fcfcfa guibg=NONE gui=NONE
hi Boolean ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi Character ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi Comment ctermfg=59 ctermbg=NONE cterm=NONE guifg=#727072 guibg=NONE gui=None
hi Conditional ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi Constant ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi Define ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi DiffAdd ctermfg=231 ctermbg=64 cterm=bold guifg=#fcfcfa guibg=#47840e gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8c0809 guibg=NONE gui=NONE
hi DiffChange ctermfg=231 ctermbg=23 cterm=NONE guifg=#fcfcfa guibg=#273a5b gui=NONE
hi DiffText ctermfg=231 ctermbg=24 cterm=bold guifg=#fcfcfa guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Float ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi Function ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi Identifier ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi Keyword ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi Label ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi NonText ctermfg=240 ctermbg=236 cterm=NONE guifg=#5b595c guibg=#2d2a2e gui=NONE
hi Number ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi Special ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi Operator ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi PreProc ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi SpecialKey ctermfg=240 ctermbg=59 cterm=NONE guifg=#5b595c guibg=#423f42 gui=NONE
hi Statement ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi StorageClass ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi String ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffd866 guibg=NONE gui=NONE
hi Tag ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi Title ctermfg=231 ctermbg=NONE cterm=bold guifg=#fcfcfa guibg=NONE gui=bold
hi Todo ctermfg=231 ctermbg=NONE cterm=inverse,bold guifg=#fcfcfa guibg=NONE gui=inverse,bold,NONE
hi Type ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline

" Color for custom group
" hi EndColons ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
" hi link Braces EndColons
" hi link Parens EndColons
" hi link Brackets EndColons
" hi link Arrow EndColons

hi BufferInactive guifg=#2d2a2e guibg=#727072

" Custom group
" syn match EndColons /[;,]/
" syn match Braces /[\[\]]/
" syn match Parens /[()]/
" syn match Brackets /[{}]/
" syn match Arrow /->/


" Ruby
hi rubyClass ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi rubyFunction ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
hi rubyConstant ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffd866 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
hi rubyInclude ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=231 ctermbg=NONE cterm=NONE guifg=#fcfcfa guibg=NONE gui=NONE
hi rubyRegexp ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffd866 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffd866 guibg=NONE gui=NONE
hi rubyEscape ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi rubyControl ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=231 ctermbg=NONE cterm=NONE guifg=#fcfcfa guibg=NONE gui=NONE
hi rubyOperator ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi rubyException ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi rubyKeywordAsMethod ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
hi erubyComment ctermfg=59 ctermbg=NONE cterm=NONE guifg=#727072 guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE

" HTML
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE


" XML
hi XmlTagName ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi XmlTag ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi XmlEndTag ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE

" YAML
hi yamlKey ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi yamlAnchor ctermfg=231 ctermbg=NONE cterm=NONE guifg=#fcfcfa guibg=NONE gui=NONE
hi yamlAlias ctermfg=231 ctermbg=NONE cterm=NONE guifg=#fcfcfa guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffd866 guibg=NONE gui=NONE

" CSS
hi cssURL ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
hi cssFunctionName ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi cssColor ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi cssClassName ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi cssValueLength ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi cssBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi cssUnitDecorators ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE

" js
hi javaScriptFunction ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsFuncCall ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
hi jsFunction ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi jsFuncArgs ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
hi jsObjectKey ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
hi jsThis ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
hi jsGlobalObjects ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=NONE
hi jsFuncBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsFuncParens ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsParens ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsIfElseBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsRepeatBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsObjectBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsBrackets ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsModuleBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsNoise ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsObjectSeparator ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE
hi jsLabel ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi jsArrowFunction ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
hi jsUndefined ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE

" GraphQL
hi graphqlType ctermfg=231 ctermbg=236 cterm=NONE guifg=#fcfcfa guibg=#2d2a2e gui=NONE
hi graphqlName ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffd866 guibg=NONE gui=NONE
hi graphqlBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=NONE

" TreeSitter
hi clear TSNone
hi link TSPunctDelimiter Delimiter
hi link TSPunctBracket Delimiter
hi link TSPunctSpecial Delimiter
hi link TSConstant     Constant
hi link TSConstBuiltin Special
hi link TSConstMacro   Define
hi link TSString       String
hi link TSStringRegex  String
hi link TSStringEscape SpecialChar
hi link TSCharacter    Character
hi link TSNumber       Number
hi link TSBoolean      Boolean
hi link TSFloat        Float
hi link TSFunction     Function
hi link TSFuncBuiltin  Special
hi link TSFuncMacro    Macro
hi link Macro PreProc
hi link TSParameter    Identifier
hi link TSParameterReference TSParameter
hi link TSMethod       Function
hi link TSField        Identifier
hi link TSProperty     Identifier
hi link TSConstructor  Special
hi link TSAnnotation   PreProc
hi link TSAttribute    PreProc
hi link TSNamespace    Include
hi link Include PreProc
hi link TSSymbol       Identifier
hi link TSConditional  Conditional
hi link TSRepeat       Repeat
hi link Repeat Statement
hi link TSLabel        Label
hi link TSOperator     Operator
hi link TSKeyword      Keyword
hi link TSKeywordFunction Keyword
hi link TSKeywordOperator TSOperator
hi link TSException    Exception
hi link Exception Statement
hi link TSType         Type
hi link TSTypeBuiltin  Type
hi link TSInclude      Include
hi link TSVariableBuiltin Special
hi link TSText         TSNone
hi clear TSStrong
hi clear TSEmphasis
hi clear TSUnderline
hi clear TSStrike
hi link TSMath         Special
hi link TSTextReference Constant
hi link TSEnviroment   Macro
hi link TSEnviromentName Type
hi link TSTitle        Title
hi link TSLiteral      String
hi link TSURI          Underlined
hi link TSComment      Comment
hi link TSNote         SpecialComment
hi link SpecialComment Special
hi link TSWarning      Todo
hi link TSDanger       WarningMsg
hi link TSTag          Label
hi link TSTagDelimiter Delimiter
hi clear TSError
hi clear TSVariable
