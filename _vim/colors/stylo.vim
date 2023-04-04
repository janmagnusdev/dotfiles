" Name:    Stylo
" Author:  Stefan Scherfke
" URL: https://gitlab.com/sscherfke/dotfiles/blob/master/_vim/colors/
"
" Switch between light and dark mode by setting "background=dark" or
" "background=light".
"

hi clear
if exists('syntax_on')
    syntax reset
endif

let colors_name = 'stylo'

let s:HAS_GUI = has('gui_running') || exists('neovim_dot_app') || has('gui_vimr') || &termguicolors
let s:VMODE = s:HAS_GUI ? 'gui' : 'cterm'

" Helpers variables for NONE, bold, ...
let s:none = "NONE"
let s:bold = "bold"
let s:italic = "italic"
let s:reverse = "reverse"
let s:standout = "standout"
let s:undercurl = "undercurl"
let s:underline = "underline"

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

" Generated color values {{{
if &background ==? 'dark'
    if s:HAS_GUI
        let s:base00 = "#18191A"
        let s:base01 = "#222528"
        let s:base02 = "#353B41"
        let s:base03 = "#3D4751"
        let s:base04 = "#68798B"
        let s:base05 = "#96AEC7"
        let s:base06 = "#C8DAEC"
        let s:base07 = "#E4ECF5"
        let s:red = "#CD7B82"
        let s:orange = "#C88F70"
        let s:yellow = "#B29D5A"
        let s:green = "#6EAE8C"
        let s:cyan = "#63ACB0"
        let s:blue = "#70A3D6"
        let s:purple = "#A191D9"
        let s:magenta = "#BE85CB"
        let s:bright_red = "#F34A67"
        let s:bright_orange = "#EE7928"
        let s:bright_yellow = "#CDA712"
        let s:bright_green = "#2DA974"
        let s:bright_cyan = "#1DAAB1"
        let s:bright_blue = "#3395ED"
        let s:bright_purple = "#9369F2"
        let s:bright_magenta = "#BA59D0"
        let s:dim_red = "#80142C"
        let s:dim_orange = "#793807"
        let s:dim_yellow = "#604D05"
        let s:dim_green = "#0A5638"
        let s:dim_cyan = "#04585C"
        let s:dim_blue = "#054C85"
        let s:dim_purple = "#4B288C"
        let s:dim_magenta = "#601E6E"
    else
        let s:base00 = "234"
        let s:base01 = "0"
        let s:base02 = "8"
        let s:base03 = "238"
        let s:base04 = "243"
        let s:base05 = "110"
        let s:base06 = "7"
        let s:base07 = "15"
        let s:red = "1"
        let s:orange = "137"
        let s:yellow = "3"
        let s:green = "2"
        let s:cyan = "6"
        let s:blue = "4"
        let s:purple = "5"
        let s:magenta = "140"
        let s:bright_red = "9"
        let s:bright_orange = "166"
        let s:bright_yellow = "11"
        let s:bright_green = "10"
        let s:bright_cyan = "14"
        let s:bright_blue = "12"
        let s:bright_purple = "13"
        let s:bright_magenta = "134"
        let s:dim_red = "52"
        let s:dim_orange = "52"
        let s:dim_yellow = "58"
        let s:dim_green = "23"
        let s:dim_cyan = "23"
        let s:dim_blue = "24"
        let s:dim_purple = "54"
        let s:dim_magenta = "53"
    endif
else
    if s:HAS_GUI
        let s:base00 = "#FBF6ED"
        let s:base01 = "#ECE8E0"
        let s:base02 = "#D4D4D4"
        let s:base03 = "#C7C7C7"
        let s:base04 = "#919191"
        let s:base05 = "#5E5E5E"
        let s:base06 = "#3C3C3C"
        let s:base07 = "#191919"
        let s:red = "#A43C31"
        let s:orange = "#BA5C00"
        let s:yellow = "#C78800"
        let s:green = "#52751D"
        let s:cyan = "#268389"
        let s:blue = "#2F5F98"
        let s:purple = "#874292"
        let s:magenta = "#A63352"
        let s:bright_red = "#CA4134"
        let s:bright_orange = "#E27415"
        let s:bright_yellow = "#EAA000"
        let s:bright_green = "#618F00"
        let s:bright_cyan = "#0D8D94"
        let s:bright_blue = "#2F78CA"
        let s:bright_purple = "#A54BB4"
        let s:bright_magenta = "#C44164"
        let s:dim_red = "#ECCCC7"
        let s:dim_orange = "#ECCEBC"
        let s:dim_yellow = "#E8D1B1"
        let s:dim_green = "#C8DDB1"
        let s:dim_cyan = "#AEDFE2"
        let s:dim_blue = "#C5D6ED"
        let s:dim_purple = "#E3CCE6"
        let s:dim_magenta = "#EDCBD0"
    else
        let s:base00 = "231"
        let s:base01 = "0"
        let s:base02 = "8"
        let s:base03 = "251"
        let s:base04 = "246"
        let s:base05 = "59"
        let s:base06 = "7"
        let s:base07 = "15"
        let s:red = "1"
        let s:orange = "130"
        let s:yellow = "3"
        let s:green = "2"
        let s:cyan = "6"
        let s:blue = "4"
        let s:purple = "5"
        let s:magenta = "125"
        let s:bright_red = "9"
        let s:bright_orange = "166"
        let s:bright_yellow = "11"
        let s:bright_green = "10"
        let s:bright_cyan = "14"
        let s:bright_blue = "12"
        let s:bright_purple = "13"
        let s:bright_magenta = "168"
        let s:dim_red = "224"
        let s:dim_orange = "224"
        let s:dim_yellow = "223"
        let s:dim_green = "151"
        let s:dim_cyan = "152"
        let s:dim_blue = "189"
        let s:dim_purple = "225"
        let s:dim_magenta = "224"
    endif
endif

" Set background and normal text color
if s:HAS_GUI
    let s:back = s:base00
    let s:text = s:base05
else
    let s:back = "NONE"
    let s:text = "NONE"
endif

" Set neovim embedded terminal colors
call s:Hi("TermColor0", s:base01, s:none)
call s:Hi("TermColor1", s:red, s:none)
call s:Hi("TermColor2", s:green, s:none)
call s:Hi("TermColor3", s:yellow, s:none)
call s:Hi("TermColor4", s:blue, s:none)
call s:Hi("TermColor5", s:purple, s:none)
call s:Hi("TermColor6", s:cyan, s:none)
call s:Hi("TermColor7", s:base06, s:none)
call s:Hi("TermColor8", s:base02, s:none)
call s:Hi("TermColor9", s:bright_red, s:none)
call s:Hi("TermColor10", s:bright_green, s:none)
call s:Hi("TermColor11", s:bright_yellow, s:none)
call s:Hi("TermColor12", s:bright_blue, s:none)
call s:Hi("TermColor13", s:bright_purple, s:none)
call s:Hi("TermColor14", s:bright_cyan, s:none)
call s:Hi("TermColor15", s:base07, s:none)
" }}} Generated color values

" General interface

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

call s:Hi("FloatBorder",   s:base05, s:base01)
call s:Hi("Pmenu",         s:base05, s:base01)
call s:Hi("PmenuSbar",     s:base05, s:base02)
call s:Hi("PmenuThumb",    s:base05, s:base05)
call s:Hi("PmenuSel",      s:base01, s:green)
call s:Hi("WildMenu",      s:base01, s:green)

call s:Hi("MatchParen",    s:bright_red,     s:none, s:none, s:underline)
call s:Hi("Directory",     s:blue,           s:none)
call s:Hi("IncSearch",     s:bright_orange, s:none, s:none, s:reverse)
call s:Hi("Search",        s:bright_yellow, s:none, s:none, s:reverse)

call s:Hi("NonText",       s:base02, s:none, s:none, s:bold)
call s:Hi("SpecialKey",    s:base02, s:none, s:none, s:bold)
call s:Hi("Title",         s:purple, s:none, s:none, s:bold)
call s:Hi("ErrorMsg",      s:red,    s:none, s:none, s:reverse)
call s:Hi("WarningMsg",    s:yellow, s:none, s:none, s:bold)
call s:Hi("Question",      s:purple, s:none, s:none, s:bold)
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

" Highlighting

call s:Hi("Comment",          s:magenta, s:none, s:none, s:italic)

call s:Hi("Constant",         s:yellow,  s:none)
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

call s:Hi("Special",            s:cyan,  s:none)
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

" Clap
call s:Hi("ClapShadow",             s:none,   s:base02)
call s:Hi("ClapSpinner",            s:blue,   s:dim_blue)
call s:HiLink("ClapInput",   "Visual")
call s:Hi("ClapDisplay",            s:base05, s:base01)
call s:Hi("ClapPreview",            s:text,   s:base01)
call s:HiLink("ClapMatches", "Search")
call s:Hi("ClapCurrentSelection",   s:green,  s:none, s:none, s:bold)
call s:Hi("ClapSelected",           s:yellow, s:none, s:none, s:bold.",".s:underline)
call s:Hi("ClapBuffersNumber",      s:blue,   s:none)
call s:Hi("ClapBuffersNumberBracket", s:blue, s:none)
call s:Hi("ClapBuffersFsize",       s:base04, s:none)
call s:Hi("ClapBuffersFname",       s:purple, s:none)
call s:Hi("ClapFile",               s:base05, s:none)
call s:Hi("ClapFpath",              s:purple, s:none)
call s:Hi("ClapLinNrColumn",        s:base04, s:none)
call s:Hi("ClapColumn",             s:base04, s:none)
for i in range(1, 12)
    call s:Hi("ClapFuzzyMatches".i, s:bright_blue,   s:none, s:none, s:bold)
endfor

" HTML
call s:Hi("htmlTag",             s:text,   s:none)
call s:Hi("htmlEndTag",          s:text,   s:none)

" Markdown
call s:Hi("markdownCode",  s:purple,    s:none)

" Patch
call s:Hi("diffLine",      s:cyan,      s:none,   s:none,        s:bold)
call s:Hi("diffAdded",     s:green,     s:none,   s:none,        s:none)
call s:Hi("diffRemoved",   s:red,       s:none,   s:none,        s:none)

" Python
call s:Hi("pythonClassVar",      s:cyan,   s:none)
call s:Hi("pythonExClass",       s:red,    s:none)

" YAML
call s:Hi("yamlKey",             s:blue,   s:none)

" Lightline color scheme
let s:llcs = {'normal': {}, 'inactive': {}, 'command': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
" Colors:                      ofg              obg              ifg       ibg
let s:llcs.normal.left =     [[s:blue,          s:dim_blue],    [s:base06, s:base02]]
let s:llcs.normal.right =    [[s:base06,        s:base02],      [s:base06, s:base02]]
let s:llcs.inactive.right =  [[s:base05,        s:base02],      [s:base05, s:base02]]
let s:llcs.inactive.left =   [[s:base05,        s:base02],      [s:base05, s:base02]]
let s:llcs.command.left =    [[s:yellow,        s:dim_yellow],    [s:base06, s:base02]]
let s:llcs.insert.left =     [[s:green,         s:dim_green],   [s:base06, s:base02]]
let s:llcs.replace.left =    [[s:orange,        s:dim_orange],  [s:base06, s:base02]]
let s:llcs.visual.left =     [[s:magenta,       s:dim_magenta], [s:base06, s:base02]]
let s:llcs.normal.middle =   [[s:base05,        s:base02]]
let s:llcs.inactive.middle = [[s:base05,        s:base02]]
let s:llcs.tabline.left =    [[s:base05,        s:base03]]
let s:llcs.tabline.tabsel =  [[s:blue,          s:dim_blue]]
let s:llcs.tabline.middle =  [[s:base05,        s:base02]]
let s:llcs.tabline.right =   [[s:red,           s:dim_red]]
let s:llcs.normal.error =    [[s:bright_red,    s:base02]]
let s:llcs.normal.warning =  [[s:bright_yellow, s:base02]]

let g:lightline#colorscheme#stylo#palette = lightline#colorscheme#fill(s:llcs)

" Reload lightline colors when colorscheme is reloaded (e.g, bg is changed)
if exists('g:loaded_lightline')
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endif
