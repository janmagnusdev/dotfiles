" Vim color scheme
"
" I use this style for presentation, so it’s very light and clean.
"
" Base colors:
"
" green  hsv(71°, 88%, 63%)
" blue   191°
" purple 311°

set background=light
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "presentation"

" General interface
hi Normal       ctermfg=NONE ctermbg=NONE cterm=NONE    guifg=#000000 guibg=#FFFFFF gui=NONE
hi Cursor       ctermfg=232  ctermbg=254  cterm=NONE    guifg=bg      guibg=fg      gui=NONE
hi Visual       ctermfg=NONE ctermbg=244  cterm=NONE    guifg=NONE    guibg=#B8D2D9 gui=NONE

hi CursorLine   ctermfg=NONE ctermbg=236  cterm=NONE    guifg=NONE    guibg=#E4E4E4 gui=NONE
hi CursorLineNr ctermfg=252  ctermbg=236  cterm=NONE    guifg=#6C6C6C guibg=#E4E4E4 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=236  cterm=NONE    guifg=NONE    guibg=#E4E4E4 gui=NONE
hi ColorColumn  ctermfg=NONE ctermbg=236  cterm=NONE    guifg=NONE    guibg=#EEEEEE gui=NONE

hi TabLine      ctermfg=254  ctermbg=240  cterm=NONE
hi TabLineFill  ctermfg=254  ctermbg=240  cterm=NONE
hi TabLineSel   ctermfg=254  ctermbg=NONE cterm=bold
hi FoldColumn   ctermfg=243  ctermbg=NONE cterm=NONE    guifg=#6C6C6C guibg=NONE    gui=NONE
hi LineNr       ctermfg=243  ctermbg=NONE cterm=NONE    guifg=#6C6C6C guibg=NONE    gui=NONE
hi VertSplit    ctermfg=240  ctermbg=240  cterm=NONE    guifg=#C6C6C6 guibg=#C6C6C6 gui=NONE
hi SignColumn   ctermfg=254  ctermbg=240  cterm=NONE    guifg=#303030 guibg=#C6C6C6 gui=NONE
hi StatusLine   ctermfg=254  ctermbg=240  cterm=bold    guifg=#303030 guibg=#C6C6C6 gui=NONE
hi StatusLineNC ctermfg=252  ctermbg=240  cterm=NONE    guifg=#6C6C6C guibg=#C6C6C6 gui=NONE

hi Pmenu        ctermfg=254  ctermbg=240  cterm=NONE    guifg=#303030 guibg=#E4E4E4 gui=NONE
hi PmenuSel     ctermfg=254  ctermbg=24   cterm=NONE    guifg=#303030 guibg=#B8D2D9 gui=NONE
hi PmenuSbar    ctermfg=254  ctermbg=240  cterm=NONE    guifg=#303030 guibg=#E4E4E4 gui=NONE
hi PmenuThumb   ctermfg=254  ctermbg=237  cterm=NONE    guifg=#303030 guibg=#C6C6C6 gui=NONE

hi MatchParen   ctermfg=182 ctermbg=NONE cterm=underline guifg=#CC00A7 guibg=NONE   gui=underline
hi IncSearch    ctermfg=0    ctermbg=220  cterm=NONE    guifg=#000000 guibg=#FBDE2D gui=NONE
hi Search       ctermfg=0    ctermbg=220  cterm=NONE    guifg=#000000 guibg=#FBDE2D gui=NONE
hi Directory    ctermfg=202  ctermbg=NONE cterm=bold    guifg=#1387A1 guibg=NONE    gui=bold
hi Folded       ctermfg=254  ctermbg=24   cterm=NONE    guifg=#303030 guibg=#CEEBF2 gui=NONE

hi NonText      ctermfg=240  ctermbg=NONE cterm=NONE    guifg=#C6C6C6 guibg=NONE    gui=NONE
hi SpecialKey   ctermfg=240  ctermbg=NONE cterm=NONE    guifg=#C6C6C6 guibg=NONE    gui=NONE
hi Title        ctermfg=254  ctermbg=NONE cterm=bold    guifg=#303030 guibg=NONE    gui=bold
hi ErrorMsg     ctermfg=254  ctermbg=1    cterm=NONE    guifg=#FFFFFF guibg=#CC0300 gui=NONE
hi WarningMsg   ctermfg=9    ctermbg=NONE cterm=NONE    guifg=#BF0300 guibg=NONE    gui=NONE

" Highlighting
hi Comment      ctermfg=249 ctermbg=NONE cterm=NONE guifg=#597880 guibg=NONE gui=NONE

hi Constant     ctermfg=191 ctermbg=NONE cterm=NONE guifg=#000000 guibg=NONE gui=NONE
hi String       ctermfg=106 ctermbg=NONE cterm=NONE guifg=#688800 guibg=NONE gui=NONE
hi link Character Constant
hi link Number    Constant
hi link Boolean   Constant
hi link Float     Constant

hi Identifier   ctermfg=207 ctermbg=NONE cterm=NONE guifg=#87A113 guibg=NONE gui=NONE
hi Function     ctermfg=202 ctermbg=NONE cterm=NONE guifg=#000000 guibg=NONE gui=NONE

hi Statement    ctermfg=221 ctermbg=NONE cterm=NONE guifg=#000000 guibg=NONE gui=bold
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Operator    Statement
hi link Keyword     Statement
hi link Exception   Statement

hi PreProc      ctermfg=182 ctermbg=NONE cterm=NONE guifg=#181818 guibg=NONE gui=NONE
hi Include      ctermfg=221 ctermbg=NONE cterm=NONE guifg=#FAE34B guibg=NONE gui=NONE
hi link Define    Include
hi link Macro     Include
hi link PreCondit Include

hi Type         ctermfg=110 ctermbg=NONE cterm=NONE guifg=#800068 guibg=NONE gui=NONE
hi link StorageClass Type
hi link Structure    Type
hi link Typedef      Type

hi Special      ctermfg=202 ctermbg=NONE cterm=NONE guifg=#800608 guibg=NONE gui=NONE
hi link SpecialChar    Special
hi Tag          ctermfg=106 ctermbg=NONE cterm=NONE guifg=#87A113 guibg=NONE gui=NONE
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special

hi Underlined   ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE    guibg=NONE    gui=underline
hi Ignore       ctermfg=8    ctermbg=NONE cterm=NONE      guifg=#808080 guibg=NONE    gui=NONE
hi Error        ctermfg=15   ctermbg=1    cterm=NONE      guifg=#FFFFFF guibg=#CC0300 gui=NONE
hi Todo         ctermfg=202  ctermbg=NONE cterm=NONE      guifg=#BF0300 guibg=NONE    gui=underline

" Lycosa Explorer
hi LycosaSelected   ctermfg=106 ctermbg=NONE cterm=NONE guifg=#688000 guibg=NONE gui=NONE
