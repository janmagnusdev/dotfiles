" Name:    Rasta
" Author:  Stefan Scherfke
" URL:     https://bitbucket.org/sscherfke/dotfiles/src/tip/_vim/colors
" License: OSI approved MIT license (see end of this file)
"
" About ------------------------------------------------------------------- {{{
"
" Rasta is stronlgy inspired by Blackboard and Solarized. It comes with dual
" light and dark modes and runs in both GUI, 256 and 16 color modes.
"
" Original iterations looked very red-yellow-green-ish, thus the name *Rasta*.
" Recent versions are using a more purple, blue, though.
"
" Switch between light and dark mode by setting "background=dark" or
" "background=light".
"
" }}}
" Color values ------------------------------------------------------------ {{{
"
" Base hues (used with color.adobe.com):
"
"     green:   69
"     blue:    triad
"     red:     triad
"     purple:  complementary
"     cyan:    184
"     yellow:  triad
"     magenta: triad
"     orange:  complementary
"
" Color    LAB          HSB          RGB          HEX      256-color
" ======== ============ ============ ============ ======== =========
" dark
" -------- ------------ ------------ ------------ -------- ---------
" base03*   10   0   0    0   0  11   27  27  27  #1B1B1B  235
" base02    20   0   0    0   0  19   48  48  48  #303030  236
" base01    45   0   0    0   0  42  106 106 106  #6A6A6A  240
" base00    55   0   0    0   0  52  132 132 132  #848484  243
" base0     65   0   0    0   0  62  158 158 158  #9E9E9E  246
" base1*    70   0   0    0   0  67  171 171 171  #ABABAB  249
" base2     81   0   4   42   5  80  204 201 191  #CCC9C2  254
" base3     97   0   5   39   6  98  251 246 237  #FBF6ED  255
" green     60 -16  38   69  50  59  139 150  75  #8B964B  106
" yellow    70  -7  51   52  60  73  186 171  74  #BAAB4A  142
" orange    60  17  29   25  50  74  189 133  94  #BD855E  137
" red       60  38  22    5  50  84  214 116 107  #D6746B  167
" magenta   60  38 -12  324  40  78  199 119 167  #C777A7  175
" purple    60  24 -24  277  30  73  165 130 186  #A582BA  140
" blue      60  -2 -25  212  40  74  113 148 189  #7194BD   68
" cyan      60 -18  -8  184  40  62   95 154 158  #5F9A9E   73
"
" ======== ============ ============ ============ ======== =========
" light
" -------- ------------ ------------ ------------ -------- ---------
" base03*   97   0   5   39   6  98  251 246 237  #FBF6ED  230
" base02    92   0   5   43   6  93  236 232 222  #ECE8DE  254
" base01    80   0   0    0   0  78  171 171 171  #C6C6C6  251
" base00    70   0   0    0   0  67  158 158 158  #9E9E9E  246
" base0     50   0   0    0   0  47  119 119 119  #777777  243
" base1*    40   0   0    0   0  37   94  94  94  #5E5E5E  240
" base2     20   0   0    0   0  19   48  48  48  #303030  236
" base3     10   0   0    0   0  11   27  27  27  #1B1B1B  235
" green     50 -21  52   69  90  50  110 127  13  #6E7F0D   64
" yellow    60  -4  64   52 100  65  166 143   0  #A68F00  136
" orange    50  37  54   25  90  75  191  90  19  #BF5A13  130
" red       50  62  46    5  80  87  222  59  44  #DE3B2C  167
" magenta   50  64 -16  324  70  81  207  62 149  #CF3E95  168
" purple    50  53 -52  277  60  82  161  84 209  #A154D1  134
" blue      50   4 -44  212  70  76   58 121 194  #3A79C2   68
" cyan      50 -23 -11  184  70  54   41 131 138  #29838A   30
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
        let s:base03  = "#1B1B1B"
        let s:base02  = "#303030"
        let s:base01  = "#6A6A6A"
        let s:base00  = "#848484"
        let s:base0   = "#9E9E9E"
        let s:base1   = "#ABABAB"
        let s:base2   = "#CCC9C2"
        let s:base3   = "#FBF6ED"
        let s:green   = "#8B964B"
        let s:yellow  = "#BAAB4A"
        let s:orange  = "#BD855E"
        let s:red     = "#D6746B"
        let s:magenta = "#C777A7"
        let s:purple  = "#A582BA"
        let s:blue    = "#7194BD"
        let s:cyan    = "#5F9A9E"

    else
        let s:base03  = "235"
        let s:base02  = "236"
        let s:base01  = "240"
        let s:base00  = "243"
        let s:base0   = "246"
        let s:base1   = "249"
        let s:base2   = "254"
        let s:base3   = "255"
        let s:green   = "106"
        let s:yellow  = "142"
        let s:orange  = "137"
        let s:red     = "167"
        let s:magenta = "175"
        let s:purple  = "140"
        let s:blue    = "68"
        let s:cyan    = "73"
    endif
" }}}
" background: light {{{
else
    if s:HAS_GUI
        let s:base03  = "#FBF6ED"
        let s:base02  = "#ECE8DE"
        let s:base01  = "#C6C6C6"
        let s:base00  = "#9E9E9E"
        let s:base0   = "#777777"
        let s:base1   = "#5E5E5E"
        let s:base2   = "#303030"
        let s:base3   = "#1B1B1B"
        let s:green   = "#6E7F0D"
        let s:yellow  = "#A68F00"
        let s:orange  = "#BF5A13"
        let s:red     = "#DE3B2C"
        let s:magenta = "#CF3E95"
        let s:purple  = "#A154D1"
        let s:blue    = "#3A79C2"
        let s:cyan    = "#29838A"
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
call s:Hi("CursorLineNr",  s:red,    s:base02)
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

call s:Hi("Comment",       s:base00,  s:none)

call s:Hi("Constant",      s:cyan,   s:none)
call s:Hi("String",        s:green,  s:none)
call s:HiLink("Character", "Constant")
call s:HiLink("Number",    "Constant")
call s:HiLink("Boolean",   "Constant")
call s:HiLink("Float",     "Constant")

call s:Hi("Identifier",    s:purple, s:none)
call s:Hi("Function",      s:purple,    s:none)

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

call s:Hi("Type",          s:blue, s:none)
call s:HiLink("StorageClass", "Type")
call s:HiLink("Structure",    "Type")
call s:HiLink("Typedef",      "Type")

call s:Hi("Special",       s:magenta,    s:none)
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
" Braceless {{{

call s:Hi("BracelessIndent", s:none, s:base02)
" }}}
" HTML {{{

call s:Hi("htmlTag",             s:text,   s:none)
call s:Hi("htmlEndTag",          s:text,   s:none)
" }}}
" Patch {{{

call s:Hi("diffAdded",           s:green,  s:none)
" }}}
" Python {{{

call s:Hi("pythonBuiltinObj",    s:yellow, s:none)
call s:Hi("pythonSelf",          s:blue,   s:none)

call s:Hi("yamlKey",             s:purple,  s:none)
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
