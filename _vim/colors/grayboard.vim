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
hi Normal                                                 guifg=#F8F8F8 guibg=#181818
" hi Cursor                                   cterm=inverse
hi CursorLine                               cterm=underline             guibg=#404040
hi LineNr       ctermfg=244                               guifg=#808080
hi ColorColumn                ctermbg=240                               guibg=#606060
hi Folded       ctermfg=14    ctermbg=240
hi Visual                     ctermbg=24

" Popup windows
hi PMenu        ctermfg=254   ctermbg=25
hi PMenuSel                                 cterm=inverse

" Highlighting
hi MatchParent                ctermbg=27
hi SpellBad                   ctermbg=88
hi Comment      ctermfg=45
hi Constant     ctermfg=191
hi Keyword      ctermfg=220                 cterm=bold
hi String       ctermfg=76
hi Type         ctermfg=110
hi Identifier   ctermfg=NONE
hi Function     ctermfg=202

