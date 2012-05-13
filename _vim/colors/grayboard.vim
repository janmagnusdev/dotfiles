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
hi Normal       ctermfg=NONE ctermbg=NONE cterm=NONE    guifg=#F8F8F8 guibg=#181818 gui=NONE
hi Cursor       ctermfg=232  ctermbg=255  cterm=NONE    guifg=bg      guibg=fg      gui=NONE
hi Visual       ctermfg=NONE ctermbg=244  cterm=NONE    guifg=NONE    guibg=#808080 gui=NONE

hi CursorLine   ctermfg=NONE ctermbg=236  cterm=NONE    guifg=NONE    guibg=#303030 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=236  cterm=NONE    guifg=NONE    guibg=#303030 gui=NONE
hi ColorColumn  ctermfg=NONE ctermbg=236  cterm=NONE    guifg=NONE    guibg=#303030 gui=NONE

hi TabLine      ctermfg=255  ctermbg=240  cterm=NONE
hi TabLineFill  ctermfg=255  ctermbg=240  cterm=NONE
hi TabLineSel   ctermfg=255  ctermbg=NONE cterm=bold
hi FoldColumn   ctermfg=243  ctermbg=NONE cterm=NONE    guifg=#767676 guibg=NONE    gui=NONE
hi LineNr       ctermfg=243  ctermbg=NONE cterm=NONE    guifg=#767676 guibg=NONE    gui=NONE
hi VertSplit    ctermfg=240  ctermbg=240  cterm=NONE    guifg=#585858 guibg=#585858 gui=NONE
hi SignColumn   ctermfg=255  ctermbg=240  cterm=NONE    guifg=#F8F8F8 guibg=#585858 gui=NONE
hi StatusLine   ctermfg=255  ctermbg=240  cterm=bold    guifg=#F8F8F8 guibg=#585858 gui=bold
hi StatusLineNC ctermfg=252  ctermbg=240  cterm=NONE    guifg=#d0d0d0 guibg=#585858 gui=NONE

hi Pmenu        ctermfg=255  ctermbg=240  cterm=NONE    guifg=#F8F8F8 guibg=#585858 gui=NONE
hi PmenuSel     ctermfg=255  ctermbg=24   cterm=NONE    guifg=#F8F8F8 guibg=#0A2733 gui=NONE
hi PmenuSbar    ctermfg=255  ctermbg=240  cterm=NONE    guifg=#F8F8F8 guibg=#585858 gui=NONE
hi PmenuThumb   ctermfg=255  ctermbg=237  cterm=NONE    guifg=#F8F8F8 guibg=#303030 gui=NONE

hi MatchParen   ctermfg=0    ctermbg=220  cterm=NONE    guifg=#000000 guibg=#FBDE2D gui=NONE
hi IncSearch    ctermfg=0    ctermbg=220  cterm=NONE    guifg=#000000 guibg=#FBDE2D gui=NONE
hi Search       ctermfg=0    ctermbg=220  cterm=NONE    guifg=#000000 guibg=#FBDE2D gui=NONE
hi Directory    ctermfg=110  ctermbg=NONE cterm=bold    guifg=#7AB5CC guibg=NONE    gui=bold
hi Folded       ctermfg=255  ctermbg=24   cterm=NONE    guifg=#F8F8F8 guibg=#295566 gui=NONE

hi NonText      ctermfg=240  ctermbg=NONE cterm=NONE    guifg=#585858 guibg=NONE    gui=NONE
hi SpecialKey   ctermfg=240  ctermbg=NONE cterm=NONE    guifg=#585858 guibg=NONE    gui=NONE
hi Title        ctermfg=255  ctermbg=NONE cterm=bold    guifg=#F8F8F8 guibg=NONE    gui=bold
hi ErrorMsg     ctermfg=255  ctermbg=1    cterm=NONE    guifg=#FFFFFF guibg=#CC0300 gui=NONE
hi WarningMsg   ctermfg=9    ctermbg=NONE cterm=NONE    guifg=#FF3633 guibg=NONE    gui=NONE

" Highlighting
hi Comment      ctermfg=249 ctermbg=NONE cterm=NONE guifg=#AFAFAF guibg=NONE gui=NONE

hi Constant     ctermfg=191 ctermbg=NONE cterm=NONE guifg=#CCE54C guibg=NONE gui=NONE
hi String       ctermfg=106 ctermbg=NONE cterm=NONE guifg=#8EB33B guibg=NONE gui=NONE
hi link Character Constant
hi link Number    Constant
hi link Boolean   Constant
hi link Float     Constant

hi Identifier   ctermfg=207 ctermbg=NONE cterm=NONE guifg=#FAAC38 guibg=NONE gui=NONE
hi Function     ctermfg=202 ctermbg=NONE cterm=NONE guifg=#F26F18 guibg=NONE gui=NONE

hi Statement    ctermfg=221 ctermbg=NONE cterm=NONE guifg=#FAE34B guibg=NONE gui=NONE
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Operator    Statement
hi link Keyword     Statement
hi link Exception   Statement

hi PreProc      ctermfg=182 ctermbg=NONE cterm=NONE guifg=#C8A0D1 guibg=NONE gui=NONE
hi Include      ctermfg=221 ctermbg=NONE cterm=NONE guifg=#FAE34B guibg=NONE gui=NONE
hi link Define    Include
hi link Macro     Include
hi link PreCondit Include

hi Type         ctermfg=110 ctermbg=NONE cterm=NONE guifg=#7AB5CC guibg=NONE gui=NONE
hi link StorageClass Type
hi link Structure    Type
hi link Typedef      Type

hi Special      ctermfg=202 ctermbg=NONE cterm=NONE guifg=#F26F18 guibg=NONE gui=NONE
hi link SpecialChar    Special
hi Tag          ctermfg=106 ctermbg=NONE cterm=NONE guifg=#7DB200 guibg=NONE gui=NONE
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special

hi Underlined   ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE    guibg=NONE    gui=underline
hi Ignore       ctermfg=8    ctermbg=NONE cterm=NONE      guifg=#808080 guibg=NONE    gui=NONE
hi Error        ctermfg=15   ctermbg=1    cterm=NONE      guifg=#FFFFFF guibg=#CC0300 gui=NONE
hi Todo         ctermfg=202  ctermbg=NONE cterm=NONE      guifg=#FF3633 guibg=NONE    gui=underline
