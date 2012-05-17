"""
This file is executed when the Python interactive shell is started if
$PYTHONSTARTUP is in your environment and points to this file. It's just
regular Python commands, so do what you will. Your ~/.inputrc file can greatly
complement this file.

"""
import os
import sys
sys.path.append(os.path.join(os.getenv('HOME'), '.python'))
del os
del sys


import util

util.setup_colored_promt()
util.setup_tab_completion()
util.setup_persistent_history()
util.setup_pretty_printing()


del util
