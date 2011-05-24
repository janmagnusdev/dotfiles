"""
Gives easy access to ANSI color codes. Attempts to fall back to no color
for certain TERM values. (Mostly stolen from IPython.)

"""

import os
import sys


_COLOR_TEMPLATES = (
    ("black"       , "0;30"),
    ("red"         , "0;31"),
    ("green"       , "0;32"),
    ("brown"       , "0;33"),
    ("blue"        , "0;34"),
    ("purple"      , "0;35"),
    ("cyan"        , "0;36"),
    ("lightgray"   , "0;37"),
    ("darkgray"    , "1;30"),
    ("lightred"    , "1;31"),
    ("lightgreen"  , "1;32"),
    ("yellow"      , "1;33"),
    ("lightblue"   , "1;34"),
    ("lightpurple" , "1;35"),
    ("lightcyan"   , "1;36"),
    ("white"       , "1;37"),
    ("normal"      , "0"),
)

_no_color = ''
_base = '\001\033[%sm\002'


_thismodule = sys.modules[__name__]
_do_color = os.environ.get('TERM') in (
        'xterm-color', 'xterm-256color', 'linux',
        'screen', 'screen-256color', 'screen-bce')

for key, val in _COLOR_TEMPLATES:
    setattr(_thismodule, key, _base % val if _do_color else _no_color)
