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
" base1*    40   0   0    0   0  37  106 106 106  #6a6a6a  240
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

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "rasta"

python << endpython
import vim

USE_TERM_COLORS = (vim.eval('$TERM_PROGRAM') == 'Apple_Terminal')
HAS_GUI = bool(int(vim.eval('has("gui_running")')))
VMODE = 'gui' if HAS_GUI else 'cterm'

# Define colors
if vim.eval('&background') == 'dark':
    if HAS_GUI:
        base03  = '#1b1b1b'
        base02  = '#303030'
        base01  = '#6a6a6a'
        base00  = '#777777'
        base0   = '#9e9e9e'
        base1   = '#ababab'
        base2   = '#ece8de'
        base3   = '#fbf6ed'
        green   = '#82994c'
        yellow  = '#baad4a'
        orange  = '#bd845e'
        red     = '#d17869'
        magenta = '#c7779e'
        purple  = '#ab82ba'
        blue    = '#7692c4'
        cyan    = '#629ba3'

    else:
        base03  = '235'
        base02  = '236'
        base01  = '240'
        base00  = '243'
        base0   = '246'
        base1   = '249'
        base2   = '254'
        base3   = '255'
        green   = '107'
        yellow  = '143'
        orange  = '137'
        red     = '167'
        magenta = '175'
        purple  = '139'
        blue    = '111'
        cyan    = '73'

else:
    if HAS_GUI:
        base03  = '#fbf6ed'
        base02  = '#ece8de'
        base01  = '#c6c6c6'
        base00  = '#9e9e9e'
        base0   = '#777777'
        base1   = '#5e5e5e'
        base2   = '#303030'
        base3   = '#1b1b1b'
        green   = '#63821A'
        yellow  = '#a39100'
        orange  = '#c25913'
        red     = '#d6452b'
        magenta = '#d13f85'
        purple  = '#b041d9'
        blue    = '#4075d6'
        cyan    = '#2b818f'

    else:
        base03  = '230'
        base02  = '254'
        base01  = '251'
        base00  = '246'
        base0   = '243'
        base1   = '240'
        base2   = '236'
        base3   = '235'
        green   = '64'
        yellow  = '136'
        orange  = '130'
        red     = '167'
        magenta = '168'
        purple  = '134'
        blue    = '68'
        cyan    = '30'

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
hi('Folded',        none,   base02, fmt=underline, sp=base01)

hi('Pmenu',         base0,  base02)
hi('PmenuSel',      base01, base2)
hi('PmenuSbar',     base2,  base0)
hi('PmenuThumb',    base0,  base03)

hi('MatchParen',    red,    none,   fmt=underline)
hi('Directory',     blue,   none)
hi('IncSearch',     orange, none,   fmt=reverse)
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
hi('Comment',       base00, none)

hi('Constant',      cyan,   none)
hi('String',        green,  none)
hi_link('Character', 'Constant')
hi_link('Number',    'Constant')
hi_link('Boolean',   'Constant')
hi_link('Float',     'Constant')

hi('Identifier',    orange, none)
hi('Function',      red,    none)

hi('Statement',     yellow, none)
hi_link('Conditional', 'Statement')
hi_link('Repeat',      'Statement')
hi_link('Label',       'Statement')
hi_link('Operator',    'Statement')
hi_link('Keyword',     'Statement')
hi_link('Exception',   'Statement')

hi('PreProc',       blue,   none)
hi('Include',       blue,   none)
hi_link('Define',    'Include')
hi_link('Macro',     'Include')
hi_link('PreCondit', 'Include')

hi('Type',          purple, none)
hi_link('StorageClass', 'Type')
hi_link('Structure',    'Type')
hi_link('Typedef',      'Type')

hi('Special',       red,    none)
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
hi('pythonBuiltinObj',  yellow, none)
# hi('pythonSelf',        blue, none)


# Lightline color scheme
# ======================
vim.command("let p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}}")
# Colors:                                                             ofg     obg      ifg     ibg
vim.command("let p.normal.left =     [['%s', '%s'], ['%s', '%s']]" % (base02, blue,    base2,  base01))
vim.command("let p.normal.right =    [['%s', '%s'], ['%s', '%s']]" % (base2,  base01,  base2,  base01))
vim.command("let p.inactive.right =  [['%s', '%s'], ['%s', '%s']]" % (base1,  base01,  base1,  base01))
vim.command("let p.inactive.left =   [['%s', '%s'], ['%s', '%s']]" % (base1,  base01,  base1,  base01))
vim.command("let p.insert.left =     [['%s', '%s'], ['%s', '%s']]" % (base02, green,   base2,  base01))
vim.command("let p.replace.left =    [['%s', '%s'], ['%s', '%s']]" % (base02, orange,  base2,  base01))
vim.command("let p.visual.left =     [['%s', '%s'], ['%s', '%s']]" % (base02, magenta, base2,  base01))
vim.command("let p.normal.middle =   [['%s', '%s']]" % (base1, base01))
vim.command("let p.inactive.middle = [['%s', '%s']]" % (base1, base01))

vim.command("let g:lightline#colorscheme#Rasta#palette = lightline#colorscheme#fill(p)")

endpython

" Reload lightline colors when colorscheme is reloaded (e.g, bg is changed)
if exists('g:loaded_lightline')
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endif

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
