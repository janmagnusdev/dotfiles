" Vim color scheme
"
" This style is derived from TextMate’s blackboard theme.
"
" Name:         blackboard.vim
" Maintainer:   Stefan Scherfke <stefan@sofa-rockers.org>
" Last Change:  2011-05-27
" License:      public domain
" Version:      1.0

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "blackboard"

" General interface
hi Normal                                                 guifg=#F8F8F8 guibg=#0C1021
hi Cursor                                   cterm=inverse                             gui=inverse
hi CursorLine                               cterm=underline             guibg=#20253D
hi LineNr       ctermfg=244
hi ColorColumn                ctermbg=17
hi Folded       ctermfg=14    ctermbg=240
hi Visual                     ctermbg=24

" Popup windows
hi PMenu        ctermfg=254   ctermbg=25
hi PMenuSel                                 cterm=inverse

" Highlighting
hi MatchParent                ctermbg=27
hi Comment      ctermfg=45
hi Constant     ctermfg=191
hi Keyword      ctermfg=220                 cterm=bold
hi String       ctermfg=76
hi Type         ctermfg=110
hi Identifier   ctermfg=NONE
hi Function     ctermfg=202

