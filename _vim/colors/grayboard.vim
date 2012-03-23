" Vim color scheme
"
" This style is derived from TextMate’s blackboard theme.

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "grayboard"

" General interface
hi Normal       ctermfg=NONE ctermbg=NONE cterm=NONE    guifg=#f8f8f8 guibg=#0c1021 gui=NONE
hi Cursor       ctermfg=232  ctermbg=255  cterm=NONE    guifg=bg      guibg=fg      gui=NONE
hi Visual       ctermfg=NONE ctermbg=24   cterm=NONE    guifg=NONE    guibg=#808080 gui=NONE
hi CursorLine   ctermfg=NONE ctermbg=237  cterm=NONE    guifg=NONE    guibg=#303030 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=237  cterm=NONE    guifg=NONE    guibg=#303030 gui=NONE
hi ColorColumn  ctermfg=NONE ctermbg=237  cterm=NONE    guifg=NONE    guibg=#303030 gui=NONE
hi LineNr       ctermfg=102  ctermbg=237  cterm=NONE    guifg=#82848d guibg=#303030 gui=NONE
hi VertSplit    ctermfg=59   ctermbg=59   cterm=NONE    guifg=#50535f guibg=#50535f gui=NONE
hi StatusLine   ctermfg=231  ctermbg=59   cterm=bold    guifg=#f8f8f8 guibg=#50535f gui=bold
hi StatusLineNC ctermfg=231  ctermbg=59   cterm=NONE    guifg=#f8f8f8 guibg=#50535f gui=NONE
hi Pmenu        ctermfg=202  ctermbg=NONE cterm=NONE    guifg=#ff6400 guibg=NONE    gui=NONE
hi PmenuSel     ctermfg=NONE ctermbg=24   cterm=NONE    guifg=NONE    guibg=#253b76 gui=NONE
hi MatchParen   ctermfg=0    ctermbg=220  cterm=NONE    guifg=#000000 guibg=#fbde2d gui=NONE
hi IncSearch    ctermfg=0    ctermbg=220  cterm=NONE    guifg=#000000 guibg=#fbde2d gui=NONE
hi Search       ctermfg=0    ctermbg=220  cterm=NONE    guifg=#000000 guibg=#fbde2d gui=NONE
hi Directory    ctermfg=191  ctermbg=NONE cterm=bold    guifg=#d8fa3c guibg=NONE    gui=bold
hi Folded       ctermfg=0    ctermbg=202  cterm=NONE    guifg=#000000 guibg=#ff6400 gui=NONE

" Highlighting
hi SpellBad                   ctermbg=88
hi Comment      ctermfg=45
hi Constant     ctermfg=191
hi Keyword      ctermfg=220                 cterm=bold
hi String       ctermfg=76
hi Type         ctermfg=110
hi Identifier   ctermfg=NONE
hi Function     ctermfg=202

hi Boolean ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
hi Character ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
hi Comment ctermfg=249 ctermbg=NONE cterm=NONE guifg=#aeaeae guibg=NONE gui=NONE
hi Conditional ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi Constant ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
hi Define ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Float ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
hi Function ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi Identifier ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi Keyword ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi Label ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
hi NonText ctermfg=59 ctermbg=16 cterm=NONE guifg=#494c59 guibg=#181c2c gui=NONE
hi Number ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
hi Operator ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi PreProc ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi Special ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f8 guibg=NONE gui=NONE
hi SpecialKey ctermfg=59 ctermbg=17 cterm=NONE guifg=#494c59 guibg=#242737 gui=NONE
hi Statement ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi StorageClass ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi String ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
hi Tag ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi Title ctermfg=231 ctermbg=NONE cterm=bold guifg=#f8f8f8 guibg=NONE gui=bold
hi Todo ctermfg=249 ctermbg=NONE cterm=inverse,bold guifg=#aeaeae guibg=NONE gui=inverse,bold
hi Type ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline

" hi rubyClass ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
" hi rubyFunction ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
" hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi rubySymbol ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
" hi rubyConstant ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi rubyStringDelimiter ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
" hi rubyBlockParameter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi rubyInstanceVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi rubyInclude ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
" hi rubyGlobalVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi rubyRegexp ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
" hi rubyRegexpDelimiter ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
" hi rubyEscape ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
" hi rubyControl ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
" hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi rubyOperator ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
" hi rubyException ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
" hi rubyPseudoVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi rubyRailsUserClass ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi rubyRailsARAssociationMethod ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi rubyRailsARMethod ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi rubyRailsRenderMethod ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi rubyRailsMethod ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi erubyComment ctermfg=249 ctermbg=NONE cterm=NONE guifg=#aeaeae guibg=NONE gui=NONE
" hi erubyRailsMethod ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
"
" hi htmlTag ctermfg=103 ctermbg=NONE cterm=NONE guifg=#7f90aa guibg=NONE gui=NONE
" hi htmlEndTag ctermfg=103 ctermbg=NONE cterm=NONE guifg=#7f90aa guibg=NONE gui=NONE
" hi htmlTagName ctermfg=103 ctermbg=NONE cterm=NONE guifg=#7f90aa guibg=NONE gui=NONE
" hi htmlArg ctermfg=103 ctermbg=NONE cterm=NONE guifg=#7f90aa guibg=NONE gui=NONE
" hi htmlSpecialChar ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
"
" hi javaScriptFunction ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
" hi javaScriptRailsFunction ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"
" hi yamlKey ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
" hi yamlAnchor ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi yamlAlias ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi yamlDocumentHeader ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
"
" hi cssURL ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hi cssFunctionName ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi cssColor ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
" hi cssPseudoClassId ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
" hi cssClassName ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
" hi cssValueLength ctermfg=191 ctermbg=NONE cterm=NONE guifg=#d8fa3c guibg=NONE gui=NONE
" hi cssCommonAttr ctermfg=110 ctermbg=NONE cterm=NONE guifg=#8da6ce guibg=NONE gui=NONE
" hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
