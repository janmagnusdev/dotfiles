" Name:    Rasta
" Author:  Stefan Scherfke
" URL:     https://bitbucket.org/ssc/dotfiles/src/tip/_vim/colors
" License: OSI approved MIT license (see end of this file)
"
" About
" =====
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
"
" Color values
" ============
"
" Color    LAB          HSB          RGB          HEX      256-color  Terminal
" ======== ============ ============ ============ ======== =========  ========
" base03*   10   0   0    0   0  11   27  27  27  #1b1b1b  234         8
" base02    20   0   0    0   0  19   48  48  48  #303030  236         0
" base01    45   0   0    0   0  42  106 106 106  #6a6a6a  242        10
" base00    50   0   0    0   0  47  119 119 119  #777777  243        11
" base0     65   0   0    0   0  62  158 158 158  #9e9e9e  247        12
" base1*    70   0   0    0   0  67  171 171 171  #ababab  249        14
" base2     92   0   5   43   6  93  236 232 222  #ece8de  254         7
" base3     97   0   5   39   6  98  251 246 237  #fbf6ed  230        15
" -------- ------------ ------------ ------------ -------- ---------  --------
" dark
" -------- ------------ ------------ ------------ -------- ---------  --------
" green     60 -27  51   78  70  61  123 156  46  #7b9c2e  106         2
" yellow    70  -7  70   53  90  75  191 171  19  #bfab13  142         3
" orange    60  29  46   24  70  82  209 122  63  #d17a3f  172         9
" red       50  46  36    9  70  78  199  81  60  #c7513c  160         1
" magenta   60  49  -9  331  50  85  217 108 161  #d96ca1  169         5
" violet    50  22 -20  284  30  60  141 107 153  #8d6b99   97        13
" blue      60   7 -40  219  50  84  107 144 214  #6b90d6   68         4
" cyan      60 -19 -13  188  50  65   83 115 166  #539ba6   73         6
" -------- ------------ ------------ ------------ -------- ---------  --------
" light
" -------- ------------ ------------ ------------ -------- ---------  --------
" yellow    60  -6  64   53 100  64  163 145   0  #a39100  136         3

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "rasta"

python << endpython
import vim

USE_TERM_COLORS = (vim.eval('$TERM_PROGRAM') == 'Apple_Terminal')
HAS_GUI = bool(int(vim.eval('has("gui_running")')))


# Define colors
if HAS_GUI:
    VMODE = 'gui'
    base03   = '#1b1b1b'
    base02   = '#303030'
    base01   = '#6a6a6a'
    base00   = '#777777'
    base0    = '#9e9e9e'
    base1    = '#ababab'
    base2    = '#ece8de'
    base3    = '#fbf6ed'
    green    = '#7b9c2e'
    yellow   = '#bfab13'
    orange   = '#d17a3f'
    red      = '#c7513c'
    magenta  = '#d96ca1'
    violet   = '#8d6b99'
    blue     = '#6b90d6'
    cyan     = '#539ba6'

    # Fix colors for light background
    yellow_light = '#a39100'

elif USE_TERM_COLORS:
    VMODE = 'cterm'
    base03   = '8'   # light black
    base02   = '0'   # black
    base01   = '10'  # light green
    base00   = '11'  # light yellow
    base0    = '12'  # light blue
    base1    = '14'  # light cyan
    base2    = '7'   # white
    base3    = '15'  # light white
    yellow   = '3'   # yellow
    orange   = '9'   # light red
    red      = '1'   # red
    magenta  = '5'   # magenta
    violet   = '13'  # light magenta
    blue     = '4'   # blue
    cyan     = '6'   # cyan
    green    = '2'   # green

    # "Fix" colors for light background
    yellow_light = yellow

else:
    VMODE = 'cterm'
    base03   = '235'
    base02   = '236'
    base01   = '240'
    base00   = '243'
    base0    = '246'
    base1    = '249'
    base2    = '254'
    base3    = '255'
    green    = '106'
    yellow   = '142'
    orange   = '172'
    red      = '160'
    magenta  = '169'
    violet   = '97'
    blue     = '68'
    cyan     = '73'

    # Fix colors for light background
    yellow_light = '136'

# Light scheme (invert base colors)
if vim.eval('&background') == 'light':
    base03, base3 = base3, base03
    base02, base2 = base2, base02
    base01, base1 = base1, base01
    base00, base0 = base0, base00
    yellow = yellow_light

# Set background and normal text color
if HAS_GUI:
    back = base03
    text = base1
else:
    back = 'NONE'
    text = 'NONE'

none = 'NONE'
bold = 'bold'
reverse = 'reverse'
standout = 'standout'
undercurl = 'undercurl'
underline = 'underline'


def hi(group, fg, bg, sp=none, fmt=none):
    """Execute ``hi <group> <VMODE>fg=<fg> <VMODE>bg=<bg> <VMODE>sp=<sp>
    <VMODE>=<fmt>``."""
    fg = '%sfg=%s' % (VMODE, fg)
    bg = '%sbg=%s' % (VMODE, bg)
    sp = '%ssp=%s' % (VMODE, sp) if HAS_GUI else ''
    fmt = '%s=%s' % (VMODE, fmt)
    vim.command('hi %s %s %s %s %s' % (group, fg, bg, sp, fmt))


def hi_link(group, target):
    """Execute ``hi link <group> <target>``."""
    vim.command('hi link %s %s' % (group, target))


# General interface
hi('Normal',        text,   back)

hi('Cursor',        base03, base0)
hi('CursorLineNr',  base1,  base02)
hi('CursorLine',    none,   base02)
hi('CursorColumn',  none,   base02)
hi('ColorColumn',   none,   base02)

hi('FoldColumn',    base01, none)
hi('LineNr',        base01, none)
hi('SignColumn',    base01, none)

hi('VertSplit',     base01, base01)
hi('StatusLine',    base2,  base01)
hi('StatusLineNC',  base1,  base01)
hi('TabLine',       base0,  base01)
hi('TabLineFill',   base0,  base01)
hi('TabLineSel',    base0,  base00)

hi('Visual',        base3,  base01)
hi('Folded',        none,   base02, fmt=underline, sp=base0)

hi('Pmenu',         base0,  base02)
hi('PmenuSel',      base01, base2)
hi('PmenuSbar',     base2,  base0)
hi('PmenuThumb',    base0,  base03)

hi('MatchParen',    red,    none,   fmt=underline)
hi('Directory',     blue,   none)
hi('IncSearch',     orange, none,   fmt=standout)
hi('Search',        yellow, none,   fmt=reverse)
hi('WildMenu',      base03, base0)

hi('NonText',       base01, none,   fmt=bold)
hi('SpecialKey',    base01, none,   fmt=bold)
hi('Title',         orange, none,   fmt=bold)
hi('ErrorMsg',      red,    none,   fmt=reverse)
hi('WarningMsg',    red,    none,   fmt=bold)
hi('Question',      orange, none,   fmt=bold)
hi('MoreMsg',       blue,   none)
hi('ModeMsg',       green,  none)

hi('DiffAdd',       green,  none,   fmt=reverse)
hi('DiffDelete',    red,    none,   fmt=reverse)
hi('DiffChange',    yellow, none,   fmt=reverse)
hi('DiffText',      blue,   none,   fmt=reverse)

hi('Conceal',       blue,   none)
hi('SpellBad',      none,   none,   sp=red,     fmt=undercurl)
hi('SpellCap',      none,   none,   sp=blue,    fmt=undercurl)
hi('SpellRare',     none,   none,   sp=magenta, fmt=undercurl)
hi('SpellLocal',    none,   none,   sp=cyan,    fmt=undercurl)

# Highlighting
hi('Comment',       base01, none)

hi('Constant',      cyan,   none)
hi('String',        green,  none)
hi_link('Character', 'Constant')
hi_link('Number',    'Constant')
hi_link('Boolean',   'Constant')
hi_link('Float',     'Constant')

hi('Identifier',    blue, none)
hi('Function',      orange, none)

hi('Statement',     yellow, none)
hi_link('Conditional', 'Statement')
hi_link('Repeat',      'Statement')
hi_link('Label',       'Statement')
# hi_link('Operator',    'Statement')
hi('Operator',      none,   none)
hi_link('Keyword',     'Statement')
hi_link('Exception',   'Statement')

hi('PreProc',       violet, none)
hi('Include',       yellow, none)
hi_link('Define',    'Include')
hi_link('Macro',     'Include')
hi_link('PreCondit', 'Include')

hi('Type',          red,   none)
hi_link('StorageClass', 'Type')
hi_link('Structure',    'Type')
hi_link('Typedef',      'Type')

hi('Special',       orange, none)
hi_link('SpecialChar',    'Special')
hi('Tag',           green,  none)
hi_link('Delimiter',      'Special')
hi_link('SpecialComment', 'Special')
hi_link('Debug',          'Special')

hi('Underlined',    none,   none,   fmt=underline)
hi('Ignore',        base01, none)
hi('Error',         red,    none,   fmt=bold)
hi('Todo',          magenta,none,   fmt=bold)

# HTML
hi('htmlTag',       text,   none)
hi('htmlEndTag',    text,   none)

# Lycosa Explorer
hi('LycosaSelected', green, none)

# Python
hi('pythonBuiltinObj',  blue,   none)

endpython

" =======
" License
" =======
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
