" Name:    Rasta
" Author:  Stefan Scherfke
" URL:     https://bitbucket.org/ssc/dotfiles/src/tip/_vim/colors
" License: OSI approved MIT license (see end of this file)
"
" About ------------------------------------------------------------------- {{{
"
" Rasta is stronlgy inspired by Blackboard and Solarized. It comes with dual
" light and dark modes and runs in both GUI, 256 and 16 color modes.
"
" I and I call it *Rasta*, because Python code looks very red-yellow-green-ish
" with it. Recent versions are using a bit more blue and cyan, though.
"
" Switch between light and dark mode by setting "background=dark" or
" "background=light".
"
" }}}
" Color values ------------------------------------------------------------ {{{
"
" Color    LAB          HSB          RGB          HEX      256-color
" ======== ============ ============ ============ ======== =========
" dark
" -------- ------------ ------------ ------------ -------- ---------
" base03*   10   0   0    0   0  11   27  27  27  #1b1b1b  235
" base02    20   0   0    0   0  19   48  48  48  #303030  236
" base01    45   0   0    0   0  42  106 106 106  #6a6a6a  240
" base00    50   0   0    0   0  47  119 119 119  #777777  243
" base0     65   0   0    0   0  62  158 158 158  #9e9e9e  246
" base1*    70   0   0    0   0  67  171 171 171  #ababab  249
" base2     92   0   5   43   6  93  236 232 222  #ece8de  254
" base3     97   0   5   39   6  98  251 246 237  #fbf6ed  255
" green     60 -21  37   78  50  60  130 153  76  #82994c  107
" yellow    70  -8  51   53  60  73  186 173  74  #baad4a  143
" orange    60  18  29   24  50  74  189 132  94  #bd845e  137
" red       60  33  24    9  50  82  209 120 105  #d17869  167
" magenta   60  36  -8  331  40  78  199 119 158  #c7779e  175
" purple    60  26 -23  284  30  73  171 130 186  #ab82ba  139
" blue      60   3 -30  219  40  77  118 145 196  #7691c4  111
" cyan      60 -16 -10  188  40  64   98 155 163  #629ba3   73
"
" ======== ============ ============ ============ ======== =========
" light
" -------- ------------ ------------ ------------ -------- ---------
" base03*   97   0   5   39   6  98  251 246 237  #fbf6ed  230
" base02    92   0   5   43   6  93  236 232 222  #ece8de  254
" base01    80   0   0    0   0  78  171 171 171  #c6c6c6  251
" base00    70   0   0    0   0  67  158 158 158  #9e9e9e  246
" base0     50   0   0    0   0  47  119 119 119  #777777  243
" base1*    40   0   0    0   0  37   94  94  94  #5e5e5e  240
" base2     20   0   0    0   0  19   48  48  48  #303030  236
" base3     10   0   0    0   0  11   27  27  27  #1b1b1b  235
" green     50 -26  49   78  80  51   99 130  28  #63821a   64
" yellow    60  -6  64   53 100  64  163 145   0  #a39100  136
" orange    50  39  55   24  90  76  194  89  19  #c25913  130
" red       50  55  46    9  80  84  214  69  43  #d6452b  167
" magenta   50  62  -6  331  70  82  209  63 133  #d13f85  168
" purple    50  67 -58  284  70  85  176  65 217  #b041d9  134
" blue      50  15 -55  219  70  84   64 117 214  #4075d6   68
" cyan      50 -21 -15  188  70  56   43 129 143  #2b818f   30
"
" }}}
" Preamble ---------------------------------------------------------------- {{{

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "rasta"

let s:USE_TERM_COLORS = ($TERM_PROGRAM ==? "Apple_Terminal")
let s:HAS_GUI = has("gui_running")
let s:VMODE = s:HAS_GUI ? "gui" : "cterm"
" }}}
" Define color values ----------------------------------------------------- {{{

" background: dark {{{
if &background ==? 'dark'
    if s:HAS_GUI
        let s:base03  = "#1b1b1b"
        let s:base02  = "#303030"
        let s:base01  = "#6a6a6a"
        let s:base00  = "#777777"
        let s:base0   = "#9e9e9e"
        let s:base1   = "#ababab"
        let s:base2   = "#ece8de"
        let s:base3   = "#fbf6ed"
        let s:green   = "#82994c"
        let s:yellow  = "#baad4a"
        let s:orange  = "#bd845e"
        let s:red     = "#d17869"
        let s:magenta = "#c7779e"
        let s:purple  = "#ab82ba"
        let s:blue    = "#7692c4"
        let s:cyan    = "#629ba3"
    else
        let s:base03  = "235"
        let s:base02  = "236"
        let s:base01  = "240"
        let s:base00  = "243"
        let s:base0   = "246"
        let s:base1   = "249"
        let s:base2   = "254"
        let s:base3   = "255"
        let s:green   = "107"
        let s:yellow  = "143"
        let s:orange  = "137"
        let s:red     = "167"
        let s:magenta = "175"
        let s:purple  = "139"
        let s:blue    = "111"
        let s:cyan    = "73"
    endif
" }}}
" background: light {{{
else
    if s:HAS_GUI
        let s:base03  = "#fbf6ed"
        let s:base02  = "#ece8de"
        let s:base01  = "#c6c6c6"
        let s:base00  = "#9e9e9e"
        let s:base0   = "#777777"
        let s:base1   = "#5e5e5e"
        let s:base2   = "#303030"
        let s:base3   = "#1b1b1b"
        let s:green   = "#63821A"
        let s:yellow  = "#a39100"
        let s:orange  = "#c25913"
        let s:red     = "#d6452b"
        let s:magenta = "#d13f85"
        let s:purple  = "#b041d9"
        let s:blue    = "#4075d6"
        let s:cyan    = "#2b818f"
    else
        let s:base03  = "230"
        let s:base02  = "254"
        let s:base01  = "251"
        let s:base00  = "246"
        let s:base0   = "243"
        let s:base1   = "240"
        let s:base2   = "236"
        let s:base3   = "235"
        let s:green   = "64"
        let s:yellow  = "136"
        let s:orange  = "130"
        let s:red     = "167"
        let s:magenta = "168"
        let s:purple  = "134"
        let s:blue    = "68"
        let s:cyan    = "30"
    endif
endif
" }}}
" Set background and normal text color {{{
if s:HAS_GUI
    let s:back = s:base03
    let s:text = s:base1
else
    let s:back = "NONE"
    let s:text = "NONE"
endif
" }}}
" Helpers variables for NONE, bold, ... {{{
let s:none = "NONE"
let s:bold = "bold"
let s:reverse = "reverse"
let s:standout = "standout"
let s:undercurl = "undercurl"
let s:underline = "underline"
" }}}
" }}}
" Highlighting functions -------------------------------------------------- {{{

function! s:Hi(group, fg, bg, ...)
    " Execute ``hi <group> <VMODE>fg=<fg> <VMODE>bg=<bg> <VMODE>sp=<sp>
    "           <VMODE>=<fmt>``
    let sp  = a:0 >= 1 ? a:1 : s:none
    let fmt = a:0 >= 2 ? a:2 : s:none

    let fg = s:VMODE . "fg=" . a:fg
    let bg = s:VMODE . "bg=" . a:bg
    let sp = s:HAS_GUI ? s:VMODE . "sp=" . sp : ""
    let fmt = s:VMODE . "=" . fmt
    execute "hi" a:group fg bg sp fmt
endfunction

function! s:HiLink(group, target)
    "Execute ``hi link <group> <target>``
    execute "hi link" a:group a:target
endfunction
" }}}
" Set colors--------------------------------------------------------------- {{{

" General interface {{{

call s:Hi("Normal",        s:text,   s:back)

call s:Hi("Cursor",        s:base03, s:base0)
call s:Hi("CursorLineNr",  s:yellow, s:base02)
call s:Hi("CursorLine",    s:none,   s:base02)
call s:Hi("CursorColumn",  s:none,   s:base02)
call s:Hi("ColorColumn",   s:none,   s:base02)

call s:Hi("FoldColumn",    s:base01, s:none)
call s:Hi("LineNr",        s:base01, s:none)
call s:Hi("SignColumn",    s:base01, s:none)

call s:Hi("VertSplit",     s:base01, s:base01)
call s:Hi("StatusLine",    s:base2,  s:base01)
call s:Hi("StatusLineNC",  s:base1,  s:base01)
call s:Hi("TabLine",       s:base0,  s:base01)
call s:Hi("TabLineFill",   s:base0,  s:base01)
call s:Hi("TabLineSel",    s:base0,  s:base00)

call s:Hi("Visual",        s:base3,  s:base01)
call s:Hi("Folded",        s:base00, s:base02, s:base01)

call s:Hi("Pmenu",         s:base0,  s:base02)
call s:Hi("PmenuSel",      s:base01, s:base2)
call s:Hi("PmenuSbar",     s:base2,  s:base0)
call s:Hi("PmenuThumb",    s:base0,  s:base03)

call s:Hi("MatchParen",    s:red,    s:none,   s:none,    s:underline)
call s:Hi("Directory",     s:blue,   s:none)
call s:Hi("IncSearch",     s:orange, s:none,   s:none,    s:reverse)
call s:Hi("Search",        s:yellow, s:none,   s:none,    s:reverse)
call s:Hi("WildMenu",      s:base03, s:base0)

call s:Hi("NonText",       s:base01, s:none,   s:none,    s:bold)
call s:Hi("SpecialKey",    s:base01, s:none,   s:none,    s:bold)
call s:Hi("Title",         s:orange, s:none,   s:none,    s:bold)
call s:Hi("ErrorMsg",      s:red,    s:none,   s:none,    s:reverse)
call s:Hi("WarningMsg",    s:red,    s:none,   s:none,    s:bold)
call s:Hi("Question",      s:orange, s:none,   s:none,    s:bold)
call s:Hi("MoreMsg",       s:blue,   s:none)
call s:Hi("ModeMsg",       s:green,  s:none)

call s:Hi("DiffAdd",       s:green,  s:none,   s:none,    s:reverse)
call s:Hi("DiffDelete",    s:red,    s:none,   s:none,    s:reverse)
call s:Hi("DiffChange",    s:yellow, s:none,   s:none,    s:reverse)
call s:Hi("DiffText",      s:blue,   s:none,   s:none,    s:reverse)

call s:Hi("Conceal",       s:blue,   s:none)
call s:Hi("SpellBad",      s:none,   s:none,   s:red,     s:undercurl)
call s:Hi("SpellCap",      s:none,   s:none,   s:blue,    s:undercurl)
call s:Hi("SpellRare",     s:none,   s:none,   s:magenta, s:undercurl)
call s:Hi("SpellLocal",    s:none,   s:none,   s:cyan,    s:undercurl)
" }}}
" Highlighting {{{

call s:Hi("Comment",       s:base2,  s:none)

call s:Hi("Constant",      s:cyan,   s:none)
call s:Hi("String",        s:green,  s:none)
call s:HiLink("Character", "Constant")
call s:HiLink("Number",    "Constant")
call s:HiLink("Boolean",   "Constant")
call s:HiLink("Float",     "Constant")

call s:Hi("Identifier",    s:orange, s:none)
call s:Hi("Function",      s:red,    s:none)

call s:Hi("Statement",     s:yellow, s:none)
call s:HiLink("Conditional", "Statement")
call s:HiLink("Repeat",      "Statement")
call s:HiLink("Label",       "Statement")
call s:HiLink("Operator",    "Statement")
call s:HiLink("Keyword",     "Statement")
call s:HiLink("Exception",   "Statement")

call s:Hi("PreProc",       s:blue,   s:none)
call s:Hi("Include",       s:blue,   s:none)
call s:HiLink("Define",    "Include")
call s:HiLink("Macro",     "Include")
call s:HiLink("PreCondit", "Include")

call s:Hi("Type",          s:purple, s:none)
call s:HiLink("StorageClass", "Type")
call s:HiLink("Structure",    "Type")
call s:HiLink("Typedef",      "Type")

call s:Hi("Special",       s:red,    s:none)
call s:HiLink("SpecialChar",    "Special")
call s:Hi("Tag",           s:green,  s:none)
call s:HiLink("Delimiter",      "Special")
call s:HiLink("SpecialComment", "Special")
call s:HiLink("Debug",          "Special")

call s:Hi("Underlined",    s:none,   s:none,   s:none,    s:underline)
call s:Hi("Ignore",        s:base01, s:none)
call s:Hi("Error",         s:red,    s:none,   s:none,    s:bold)
call s:Hi("Todo",          s:magenta,s:none,   s:none,    s:bold)
" }}}
" HTML {{{

call s:Hi("htmlTag",             s:text,   s:none)
call s:Hi("htmlEndTag",          s:text,   s:none)
" }}}
" Lycosa Explorer {{{

call s:Hi("LycosaSelected",      s:green,  s:none)
" }}}
" Patch {{{

call s:Hi("diffAdded",           s:green,  s:none)
" }}}
" Python {{{

call s:Hi("pythonBuiltinObj",    s:yellow, s:none)
call s:Hi("pythonSelf",          s:blue,   s:none)
" }}}
" }}}
" Lightline color scheme--------------------------------------------------- {{{

let s:llcs = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}}
" Colors:                      ofg       obg          ifg      ibg
let s:llcs.normal.left =     [[s:base02, s:blue],    [s:base2, s:base01]]
let s:llcs.normal.right =    [[s:base2,  s:base01],  [s:base2, s:base01]]
let s:llcs.inactive.right =  [[s:base1,  s:base01],  [s:base1, s:base01]]
let s:llcs.inactive.left =   [[s:base1,  s:base01],  [s:base1, s:base01]]
let s:llcs.insert.left =     [[s:base02, s:green],   [s:base2, s:base01]]
let s:llcs.replace.left =    [[s:base02, s:orange],  [s:base2, s:base01]]
let s:llcs.visual.left =     [[s:base02, s:magenta], [s:base2, s:base01]]
let s:llcs.normal.middle =   [[s:base1, s:base01]]
let s:llcs.inactive.middle = [[s:base1, s:base01]]

let g:lightline#colorscheme#Rasta#palette = lightline#colorscheme#fill(s:llcs)

" Reload lightline colors when colorscheme is reloaded (e.g, bg is changed)
if exists('g:loaded_lightline')
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endif
" }}}
" License ----------------------------------------------------------------- {{{
"
" The MIT License (MIT)
"
" Copyright (c) 2013 Stefan Scherfke
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"
" }}}
