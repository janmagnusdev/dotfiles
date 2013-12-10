" Vim syntax file
" Language: mosaik scenario language
" Author: Stefan Scherfke

if exists("b:current_syntax")
    finish
endif

syn keyword moslImport    import package
syn keyword moslStatement end composition sim model config physical topology
syn keyword moslStatement composite entity internal external
syn keyword moslStatement study of using
syn keyword moslStatement port in out static accepting optional
syn keyword moslStatement with stepsize
syn keyword moslStatement connect to where
syn match   moslComment        "#.*$" display contains=moslTodo,@Spell
syn match   moslComment        "//.*$" display contains=moslTodo,@Spell
syn keyword moslTodo                TODO FIXME XXX contained

syn region moslString     start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=moslEscape,moslEscapeError,@Spell
syn region moslString     start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=moslEscape,moslEscapeError,@Spell

syn match moslEscape             +\\[abfnrtv'"\\]+ display contained
syn match moslEscape             "\\\o\o\=\o\=" display contained
syn match moslEscapeError        "\\\o\{,2}[89]" display contained
syn match moslEscape             "\\x\x\{2}" display contained
syn match moslEscapeError        "\\x\x\=\X" display contained
syn match moslEscape             "\\$"

syn match moslNumber        "\<\d\+[lLjJ]\=\>" display
syn match moslFloat         "\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match moslFloat         "\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match moslFloat         "\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\=" display

hi def link moslImport     Include
hi def link moslStatement  Statement
hi def link moslComment    Comment
hi def link moslTodo       Todo
hi def link moslString     String
hi def link moslNumber     Number
hi def link moslFloat      Float

let b:current_syntax = "mosl"
