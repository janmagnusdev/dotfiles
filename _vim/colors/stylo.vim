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
        let s:base00  = "#191A1C"
        let s:base01  = "#1F2225"
        let s:base02  = "#2C343A"
        let s:base03  = "#36444F"
        let s:base04  = "#4C6272"
        let s:base05  = "#90AFC0"
        let s:base06  = "#C2D9EB"
        let s:base07  = "#E4ECF4"
        let s:red     = "#DA7F71"
        let s:orange  = "#CE8A4F"
        let s:yellow  = "#A99F3A"
        let s:green   = "#62AF8D"
        let s:cyan    = "#5EACB3"
        let s:blue    = "#75A3D3"
        let s:purple  = "#939AD1"
        let s:magenta = "#CD83A6"
    else
        let s:base00  = "10"
        let s:base01  = "0"
        let s:base02  = "8"
        let s:base03  = "11"
        let s:base04  = "12"
        let s:base05  = "14"
        let s:base06  = "7"
        let s:base07  = "15"
        let s:red     = "1"
        let s:orange  = "9"
        let s:yellow  = "3"
        let s:green   = "2"
        let s:cyan    = "6"
        let s:blue    = "4"
        let s:purple  = "5"
        let s:magenta = "13"
    endif
" }}}

" background: light {{{
else
    if s:HAS_GUI
        let s:base00  = "#FBF6ED"
        let s:base01  = "#ECE8DF"
        let s:base02  = "#D5D5D5"
        let s:base03  = "#C0BFBF"
        let s:base04  = "#919191"
        let s:base05  = "#5E5E5E"
        let s:base06  = "#2F2F2F"
        let s:base07  = "#1A1A1A"
        let s:red     = "#A7261C"
        let s:orange  = "#964003"
        let s:yellow  = "#B48805"
        let s:green   = "#566603"
        let s:cyan    = "#0B6C72"
        let s:blue    = "#3B6293"
        let s:purple  = "#90338C"
        let s:magenta = "#A0285C"
    else
        let s:base00  = "10"
        let s:base01  = "0"
        let s:base02  = "8"
        let s:base03  = "11"
        let s:base04  = "12"
        let s:base05  = "14"
        let s:base06  = "7"
        let s:base07  = "15"
        let s:red     = "1"
        let s:orange  = "9"
        let s:yellow  = "3"
        let s:green   = "2"
        let s:cyan    = "6"
        let s:blue    = "4"
        let s:purple  = "5"
        let s:magenta = "13"
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

call s:Hi("FoldColumn",    s:base02, s:none)
call s:Hi("LineNr",        s:base02, s:none)
call s:Hi("SignColumn",    s:base02, s:none)

call s:Hi("VertSplit",     s:base02, s:none)
call s:Hi("StatusLine",    s:base06, s:base02)
call s:Hi("StatusLineNC",  s:base05, s:base02)
call s:Hi("TabLine",       s:base05, s:base03)
call s:Hi("TabLineFill",   s:base05, s:base02)
call s:Hi("TabLineSel",    s:base01, s:blue)

call s:Hi("Visual",        s:base07, s:base02)
call s:Hi("Folded",        s:orange, s:base01)

call s:Hi("Pmenu",         s:base04, s:base01)
call s:Hi("PmenuSbar",     s:base05, s:base02)
call s:Hi("PmenuThumb",    s:base05, s:base05)
call s:Hi("PmenuSel",      s:base01, s:green)
call s:Hi("WildMenu",      s:base01, s:green)

call s:Hi("MatchParen",    s:red,    s:none,   s:none,    s:underline)
call s:Hi("Directory",     s:blue,   s:none)
call s:Hi("IncSearch",     s:orange, s:none,   s:none,    s:reverse)
call s:Hi("Search",        s:yellow, s:none,   s:none,    s:reverse)

call s:Hi("NonText",       s:base02, s:none,   s:none,    s:bold)
call s:Hi("SpecialKey",    s:base02, s:none,   s:none,    s:bold)
call s:Hi("Title",         s:blue,   s:none,   s:none,    s:bold)
call s:Hi("ErrorMsg",      s:red,    s:none,   s:none,    s:reverse)
call s:Hi("WarningMsg",    s:red,    s:none,   s:none,    s:bold)
call s:Hi("Question",      s:orange, s:none,   s:none,    s:bold)
call s:Hi("MoreMsg",       s:blue,   s:none)
call s:Hi("ModeMsg",       s:green,  s:none)

call s:Hi("DiffFile",      s:purple, s:none,   s:none,    s:bold)
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

call s:Hi("Comment",       s:base04,  s:none)

call s:Hi("Constant",      s:cyan,   s:none)
call s:Hi("String",        s:green,  s:none)
call s:HiLink("Character", "Constant")
call s:HiLink("Number",    "Constant")
call s:HiLink("Boolean",   "Constant")
call s:HiLink("Float",     "Constant")

call s:Hi("Identifier",    s:blue, s:none)
call s:Hi("Function",      s:blue, s:none)

call s:Hi("Statement",     s:yellow, s:none)
call s:HiLink("Conditional", "Statement")
call s:HiLink("Repeat",      "Statement")
call s:HiLink("Label",       "Statement")
call s:HiLink("Operator",    "Statement")
call s:HiLink("Keyword",     "Statement")
call s:HiLink("Exception",   "Statement")

call s:Hi("PreProc",       s:purple, s:none)
call s:Hi("Include",       s:blue,   s:none)
call s:HiLink("Define",    "Include")
call s:HiLink("Macro",     "Include")
call s:HiLink("PreCondit", "Include")

call s:Hi("Type",          s:orange, s:none)
call s:HiLink("StorageClass", "Type")
call s:HiLink("Structure",    "Type")
call s:HiLink("Typedef",      "Type")

call s:Hi("Special",       s:magenta, s:none)
call s:HiLink("SpecialChar",    "Special")
call s:Hi("Tag",           s:green,   s:none)
call s:HiLink("Delimiter",      "Special")
call s:HiLink("SpecialComment", "Special")
call s:HiLink("Debug",          "Special")

call s:Hi("Underlined",    s:none,   s:none,   s:none,    s:underline)
call s:Hi("Ignore",        s:base02, s:none)
call s:Hi("Error",         s:red,    s:none,   s:none,    s:bold)
call s:Hi("Todo",          s:magenta,s:none,   s:none,    s:bold)
call s:Hi("Whitespace",    s:red,    s:none)

" }}}
" Braceless {{{

" call s:Hi("BracelessIndent", s:none, s:base01)
call s:Hi("BracelessIndent", s:base02, s:none, s:none, s:reverse)
" }}}
" Clap {{{
call s:HiLink("ClapInput",   "Visual")
call s:HiLink("ClapDisplay", "Pmenu")
call s:HiLink("ClapPreview", "PmenuSel")
call s:HiLink("ClapMatches", "Search")
call s:HiLink("ClapFpath",   "Directory")
call s:Hi("ClapSelected", s:purple, s:none, s:none, s:bold.",".s:underline)
call s:Hi("ClapCurrentSelection", s:magenta, s:none, s:none, s:bold)
" }}}
" HTML {{{

call s:Hi("htmlTag",             s:text,   s:none)
call s:Hi("htmlEndTag",          s:text,   s:none)
" }}}
" Patch {{{

call s:Hi("diffAdded",           s:green,  s:none)
" }}}
" Python {{{

" call s:Hi("pythonBuiltinObj",    s:yellow, s:none)
call s:Hi("pythonClassVar",      s:purple, s:none)
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
let s:llcs.tabline.right = [[s:base01, s:red]]
let s:llcs.normal.error = [[s:red, s:base02]]
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
let g:terminal_color_0 = s:base02
let g:terminal_color_1 = s:red
let g:terminal_color_2 = s:green
let g:terminal_color_3 = s:yellow
let g:terminal_color_4 = s:blue
let g:terminal_color_5 = s:purple
let g:terminal_color_6 = s:cyan
let g:terminal_color_7 = s:base05
let g:terminal_color_8 = s:base02
let g:terminal_color_9 = s:red
let g:terminal_color_10 = s:green
let g:terminal_color_11 = s:yellow
let g:terminal_color_12 = s:blue
let g:terminal_color_13 = s:purple
let g:terminal_color_14 = s:cyan
let g:terminal_color_15 = s:base05
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
