" Name:    Stylo
" Author:  Stefan Scherfke
" URL: https://gitlab.com/sscherfke/dotfiles/blob/master/_vim/colors/
" License: OSI approved MIT license (see end of this file)
"
" About ------------------------------------------------------------------- {{{

" Stylo evolved from my old Rasta theme.  The light version uses a bit darker
" and warmer colors while the dark version uses a completely new set of colors
" that look more futuristic.  It also roughly follows the base16/4bit approach
" and uses the first 16 colors provided by the terminal.  It also defines
" 24bit colors for GUIs, though.
"
" Switch between light and dark mode by setting "background=dark" or
" "background=light".
"
" }}} Preamble ----------------------------------------------------------------
" {{{

hi clear
if exists('syntax_on')
    syntax reset
endif

let colors_name = 'stylo'

" let s:USE_TERM_COLORS = ($TERM_PROGRAM ==? 'Apple_Terminal')
let s:HAS_GUI = has('gui_running') || exists('neovim_dot_app') || has('gui_vimr') || &termguicolors
let s:VMODE = s:HAS_GUI ? 'gui' : 'cterm'
" }}}
" Define color values ----------------------------------------------------- {{{

" background: dark {{{
if &background ==? 'dark'
    if s:HAS_GUI
        let s:base00         = "#181A1B"
        let s:base01         = "#1F2224"
        let s:base02         = "#31383C"
        let s:base03         = "#38444B"
        let s:base04         = "#4E616D"
        let s:base05         = "#90B0C4"
        let s:base06         = "#C2DBEB"
        let s:base07         = "#E2ECF4"
        let s:red            = "#E18575"
        let s:orange         = "#D68E4E"
        let s:yellow         = "#BB9A3C"
        let s:green          = "#70AA89"
        let s:cyan           = "#5BAAB0"
        let s:blue           = "#74A1D4"
        let s:purple         = "#919BD0"
        let s:magenta        = "#CD82A6"
        let s:bright_red     = "#F75F2C"
        let s:bright_orange  = "#FFA44A"
        let s:bright_yellow  = "#DEB400"
        let s:bright_green   = "#00A668"
        let s:bright_cyan    = "#00A0A8"
        let s:bright_blue    = "#3596E1"
        let s:bright_purple  = "#6F8AF4"
        let s:bright_magenta = "#E363A7"
    else
        let s:base00         = "234"
        let s:base01         = "235"
        let s:base02         = "8"
        let s:base03         = "238"
        let s:base04         = "240"
        let s:base05         = "110"
        let s:base06         = "7"
        let s:base07         = "15"
        let s:red            = "1"
        let s:orange         = "173"
        let s:yellow         = "3"
        let s:green          = "2"
        let s:cyan           = "6"
        let s:blue           = "4"
        let s:purple         = "5"
        let s:magenta        = "175"
        let s:bright_red     = "9"
        let s:bright_orange  = "215"
        let s:bright_yellow  = "11"
        let s:bright_green   = "10"
        let s:bright_cyan    = "14"
        let s:bright_blue    = "12"
        let s:bright_purple  = "13"
        let s:bright_magenta = "169"
    endif
" }}}

" background: light {{{
else
    if s:HAS_GUI
        let s:base00         = "#FBF6ED"
        let s:base01         = "#ECE8E0"
        let s:base02         = "#D4D4D4"
        let s:base03         = "#BEBEBE"
        let s:base04         = "#919191"
        let s:base05         = "#5E5E5E"
        let s:base06         = "#3B3B3B"
        let s:base07         = "#191919"
        let s:red            = "#A43B31"
        let s:orange         = "#BC5C00"
        let s:yellow         = "#D39100"
        let s:green          = "#52751D"
        let s:cyan           = "#268389"
        let s:blue           = "#2F6099"
        let s:purple         = "#874392"
        let s:magenta        = "#A73454"
        let s:bright_red     = "#DC3A23"
        let s:bright_orange  = "#FF8D48"
        let s:bright_yellow  = "#F6AA00"
        let s:bright_green   = "#77AE00"
        let s:bright_cyan    = "#2B9197"
        let s:bright_blue    = "#0087E6"
        let s:bright_purple  = "#C455D5"
        let s:bright_magenta = "#E34D76"
    else
        let s:base00         = "255"
        let s:base01         = "0"
        let s:base02         = "188"
        let s:base03         = "250"
        let s:base04         = "246"
        let s:base05         = "59"
        let s:base06         = "237"
        let s:base07         = "234"
        let s:red            = "1"
        let s:orange         = "130"
        let s:yellow         = "11"
        let s:green          = "64"
        let s:cyan           = "6"
        let s:blue           = "4"
        let s:purple         = "5"
        let s:magenta        = "96"
        let s:bright_red     = "9"
        let s:bright_orange  = "209"
        let s:bright_yellow  = "214"
        let s:bright_green   = "10"
        let s:bright_cyan    = "37"
        let s:bright_blue    = "12"
        let s:bright_purple  = "13"
        let s:bright_magenta = "168"
    endif
endif
" }}}

" Set background and normal text color {{{
if s:HAS_GUI
    let s:back = s:base00
    let s:text = s:base05
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

call s:Hi("Cursor",        s:base00, s:base03)
call s:Hi("CursorLineNr",  s:red,    s:base01)
call s:Hi("CursorLine",    s:none,   s:base01)
call s:Hi("CursorColumn",  s:none,   s:base01)
call s:Hi("ColorColumn",   s:none,   s:base01)

call s:Hi("FoldColumn",    s:base03, s:none)
call s:Hi("LineNr",        s:base03, s:none)
call s:Hi("SignColumn",    s:base03, s:none)

call s:Hi("VertSplit",     s:base02, s:none)
call s:Hi("StatusLine",    s:base06, s:base02)
call s:Hi("StatusLineNC",  s:base05, s:base02)
call s:Hi("TabLine",       s:base05, s:base03)
call s:Hi("TabLineFill",   s:base05, s:base02)
call s:Hi("TabLineSel",    s:base01, s:blue)

call s:Hi("Visual",        s:base07, s:base02)
call s:Hi("Folded",        s:orange, s:base01)

call s:Hi("Pmenu",         s:base05, s:base01)
call s:Hi("PmenuSbar",     s:base05, s:base02)
call s:Hi("PmenuThumb",    s:base05, s:base05)
call s:Hi("PmenuSel",      s:base01, s:green)
call s:Hi("WildMenu",      s:base01, s:green)

call s:Hi("MatchParen",    s:bright_red,     s:none, s:none, s:underline)
call s:Hi("Directory",     s:blue,           s:none)
call s:Hi("IncSearch",     s:orange, s:none, s:none, s:reverse)
call s:Hi("Search",        s:yellow, s:none, s:none, s:reverse)

call s:Hi("NonText",       s:base02, s:none, s:none, s:bold)
call s:Hi("SpecialKey",    s:base02, s:none, s:none, s:bold)
call s:Hi("Title",         s:blue,   s:none, s:none, s:bold)
call s:Hi("ErrorMsg",      s:red,    s:none, s:none, s:reverse)
call s:Hi("WarningMsg",    s:orange, s:none, s:none, s:bold)
call s:Hi("Question",      s:yellow, s:none, s:none, s:bold)
call s:Hi("MoreMsg",       s:blue,   s:none)
call s:Hi("ModeMsg",       s:green,  s:none)

call s:Hi("DiffFile",      s:purple, s:none, s:none, s:bold)
call s:Hi("DiffText",      s:blue,   s:none, s:none, s:reverse)
call s:Hi("DiffAdd",       s:green,  s:none, s:none, s:reverse)
call s:Hi("DiffDelete",    s:red,    s:none, s:none, s:reverse)
call s:Hi("DiffChange",    s:yellow, s:none, s:none, s:reverse)

call s:Hi("Conceal",       s:blue,   s:none)
call s:Hi("SpellBad",      s:none,   s:none, s:bright_red, s:undercurl)
call s:Hi("SpellCap",      s:none,   s:none, s:blue,       s:undercurl)
call s:Hi("SpellRare",     s:none,   s:none, s:magenta,    s:undercurl)
call s:Hi("SpellLocal",    s:none,   s:none, s:cyan,       s:undercurl)
" }}}
" Highlighting {{{

call s:Hi("Comment",          s:base04,  s:none)

call s:Hi("Constant",         s:cyan,    s:none)
call s:Hi("String",           s:green,   s:none)
call s:HiLink("Character",    "Constant")
call s:HiLink("Number",       "Constant")
call s:HiLink("Boolean",      "Constant")
call s:HiLink("Float",        "Constant")

call s:Hi("Identifier",       s:blue,    s:none)
call s:Hi("Function",         s:blue,    s:none)

call s:Hi("Statement",        s:purple,  s:none)
call s:HiLink("Conditional",  "Statement")
call s:HiLink("Repeat",       "Statement")
call s:HiLink("Label",        "Statement")
call s:HiLink("Operator",     "Statement")
call s:HiLink("Keyword",      "Statement")
call s:HiLink("Exception",    "Statement")

call s:Hi("PreProc",          s:magenta, s:none)
call s:Hi("Include",          s:magenta, s:none)
call s:HiLink("Define",       "Include")
call s:HiLink("Macro",        "Include")
call s:HiLink("PreCondit",    "Include")

call s:Hi("Type",             s:magenta, s:none)
call s:HiLink("StorageClass", "Type")
call s:HiLink("Structure",    "Type")
call s:HiLink("Typedef",      "Type")

call s:Hi("Special",            s:orange,  s:none)
call s:HiLink("SpecialChar",    "Special")
call s:Hi("Tag",                s:green,   s:none)
call s:Hi("Delimiter",          s:magenta, s:none)
call s:HiLink("SpecialComment", "Special")
call s:HiLink("Debug",          "Special")

call s:Hi("Underlined",       s:none,       s:none, s:none, s:underline)
call s:Hi("Ignore",           s:base02,     s:none)
call s:Hi("Error",            s:bright_red, s:none, s:none, s:bold)
call s:Hi("Todo",             s:magenta,    s:none, s:none, s:bold)
call s:Hi("Whitespace",       s:bright_red, s:none)

" }}}
" Clap {{{
call s:Hi("ClapSpinner",            s:base01, s:blue)
call s:HiLink("ClapInput",   "Visual")
call s:HiLink("ClapDisplay", "Pmenu")
call s:HiLink("ClapPreview", "Pmenu")
call s:HiLink("ClapMatches", "Search")
call s:Hi("ClapCurrentSelection",   s:orange, s:none, s:none, s:bold)
call s:Hi("ClapSelected",           s:green,  s:none, s:none, s:bold.",".s:underline)
call s:Hi("ClapFile",               s:base05, s:none)
call s:Hi("ClapFpath",              s:base05, s:none, s:none, s:bold)
call s:Hi("ClapLinNrColumn",        s:base04, s:none)
for i in range(1, 12)
    call s:Hi("ClapFuzzyMatches".i, s:cyan,   s:none, s:none, s:bold)
endfor
" }}}
" HTML {{{

call s:Hi("htmlTag",             s:text,   s:none)
call s:Hi("htmlEndTag",          s:text,   s:none)
" }}}
" Markdown {{{

call s:Hi("markdownCode",  s:purple,    s:none)
" }}}
" Patch {{{

call s:Hi("diffLine",      s:cyan,      s:none,   s:none,        s:bold)
call s:Hi("diffAdded",     s:green,     s:none,   s:none,        s:none)
call s:Hi("diffRemoved",   s:red,       s:none,   s:none,        s:none)
" }}}
" Python {{{

" call s:Hi("pythonBuiltinObj",    s:yellow, s:none)
call s:Hi("pythonClassVar",      s:orange, s:none)
call s:Hi("pythonExClass",       s:red,    s:none)
" }}}
" YAML {{{
call s:Hi("yamlKey",             s:blue,   s:none)
" }}}
" }}}
" Lightline color scheme--------------------------------------------------- {{{

let s:llcs = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
" Colors:                      ofg       obg          ifg      ibg
let s:llcs.normal.left =     [[s:base01, s:blue],    [s:base06, s:base02]]
let s:llcs.normal.right =    [[s:base06,  s:base02],  [s:base06, s:base02]]
let s:llcs.inactive.right =  [[s:base05,  s:base02],  [s:base05, s:base02]]
let s:llcs.inactive.left =   [[s:base05,  s:base02],  [s:base05, s:base02]]
let s:llcs.insert.left =     [[s:base01, s:green],   [s:base06, s:base02]]
let s:llcs.replace.left =    [[s:base01, s:orange],  [s:base06, s:base02]]
let s:llcs.visual.left =     [[s:base01, s:magenta], [s:base06, s:base02]]
let s:llcs.normal.middle =   [[s:base05, s:base02]]
let s:llcs.inactive.middle = [[s:base05, s:base02]]
let s:llcs.tabline.left = [[s:base05, s:base03]]
let s:llcs.tabline.tabsel = [[s:base01, s:blue]]
let s:llcs.tabline.middle = [[s:base05, s:base02]]
let s:llcs.tabline.right = [[s:base01, s:bright_red]]
let s:llcs.normal.error = [[s:bright_red, s:base02]]
let s:llcs.normal.warning = [[s:yellow, s:base02]]

let g:lightline#colorscheme#stylo#palette = lightline#colorscheme#fill(s:llcs)

" Reload lightline colors when colorscheme is reloaded (e.g, bg is changed)
if exists('g:loaded_lightline')
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endif
" }}}
" Set neovim embedded terminal colors ------------------------------------- {{{
let g:terminal_color_0 = s:base01
let g:terminal_color_1 = s:red
let g:terminal_color_2 = s:green
let g:terminal_color_3 = s:yellow
let g:terminal_color_4 = s:blue
let g:terminal_color_5 = s:purple
let g:terminal_color_6 = s:cyan
let g:terminal_color_7 = s:base06
let g:terminal_color_8 = s:base02
let g:terminal_color_9 = s:bright_red
let g:terminal_color_10 = s:bright_green
let g:terminal_color_11 = s:bright_yellow
let g:terminal_color_12 = s:bright_blue
let g:terminal_color_13 = s:bright_purple
let g:terminal_color_14 = s:bright_cyan
let g:terminal_color_15 = s:base07
" }}}
" License ----------------------------------------------------------------- {{{
"
" The MIT License (MIT)
"
" Copyright (c) 2019 Stefan Scherfke
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
