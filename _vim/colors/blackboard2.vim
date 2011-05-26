" Vim color scheme
"
" Name:         blackboard2.vim
" Maintainer:   Stefan Scherfke <stefan@sofa-rockers.org>
" Last Change:  2011-05-26
" License:      public domain
" Version:      1.0

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "blackboard2"

" General interface
hi Normal       guifg=#F8F8F8 guibg=#0C1021
hi Cursor                                   gui=inverse
hi CursorLine                 guibg=#20253D
hi LineNr       ctermfg=244   ctermbg=NONE  cterm=NONE
hi ColorColumn  ctermfg=NONE  ctermbg=17
hi Folded       ctermfg=14    ctermbg=240
hi Visual                     ctermbg=24

" Popup windows
hi PMenu        ctermfg=254   ctermbg=25
hi PMenuSel     ctermfg=NONE  ctermbg=NONE  cterm=inverse

" Highlighting
hi MatchParent                ctermbg=27
hi Comment      ctermfg=45
hi Constant     ctermfg=191
hi Keyword      ctermfg=220                 cterm=bold
hi String       ctermfg=76
hi Type         ctermfg=110
hi Identifier   ctermfg=NONE
hi Function     ctermfg=202

