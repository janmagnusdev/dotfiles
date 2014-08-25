# encoding: utf-8
"""
Utility functions for my Python prompt
======================================

"""
import os
import rlcompleter
import subprocess
import sys


class colors:
    black = '30'
    darkred = '31'
    darkgreen = '32'
    brown = '33'
    darkblue = '34'
    purple = '35'
    teal = '36'
    lightgray = '37'
    darkgray = '30;01'
    red = '31;01'
    green = '32;01'
    yellow = '33;01'
    blue = '34;01'
    fuchsia = '35;01'
    turquoise = '36;01'
    white = '37;01'


def setup_colored_promt():
    """
    Sets-up a colored promt if readline is available.

    Unfortunately, libedit-based readline doesn’t work with that.

    """
    try:
        import readline
    except ImportError:
        return

    if has_libedit():
        return

    sys.ps1 = '\001\033[0;%sm\002>>> \001\033[0m\002' % colors.darkgreen
    sys.ps2 = '\001\033[0;%sm\002... \001\033[0m\002' % colors.darkred
    # sys.ps1 = '\x1b[%sm>>> \x1b[0m' % colors.darkgreen
    # sys.ps2 = '\x1b[%sm... \x1b[0m' % colors.darkred


def setup_persistent_history():
    """Sets-up a persistent history in *~/.pyhistory*."""
    try:
        import atexit
        import readline
    except ImportError:
        return

    histfile = os.path.expanduser('~/.pyhistory')
    try:
        readline.read_history_file(histfile)
    except IOError:
        pass
    atexit.register(readline.write_history_file, histfile)


def setup_tab_completion():
    """Sets up tab completion."""
    try:
        import readline
    except ImportError:
        return

    completer = Completer()
    if has_libedit():
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind('tab: complete')
    readline.set_completer(completer.complete)


def setup_pretty_printing():
    """Enables pretty printing of lists to stdout."""
    sys.displayhook = pp_displayhook


def has_libedit():
    """
    Checks whether Pyhton uses Mac OS X’ libedit instead of the real
    readline module.

    """
    import readline

    if sys.platform != 'darwin':
        return False

    cmd = ['otool', '-L', readline.__file__]
    if hasattr(subprocess, 'check_output'):
        out = subprocess.check_output(cmd).decode()
    else:  # Delete this to drop Python 2.6 support
        out, _ = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                stderr=subprocess.PIPE).communicate()
        out = out.decode()

    if 'libedit' in out:
        return True

    return False


def pp_displayhook(value):
    """Uses :func:`pprint.pprint` to print *value* to stdout."""
    if value is not None:
        try:  # Python 2.7 and 3.x
            import builtins
        except ImportError:  # Python 2.6
            import __builtin__ as builtins

        builtins._ = value

        import pprint
        pprint.pprint(value)


class Completer(rlcompleter.Completer):
    """
    Extends Python defaults :class:`~rlcompleter.Completer`. If you are on
    the beginning of a line, a tab is inserted instead of performing
    completion.

    Inspired by `rlcompleter_ng
    <http://codespeak.net/svn/user/antocuni/hack/rlcompleter_ng.py>`_

    """
    def __init__(self, *args, **kwargs):
        rlcompleter.Completer.__init__(self, *args, **kwargs)

    def complete(self, text, state):
        """
        Returns a *tab* if you are on the beginning of a line or the next
        next possible completion else.

        """
        if text == '':
            return ['\t', None][state]
        else:
            return rlcompleter.Completer.complete(self, text, state)

    def attr_matches(self, text):
        """
        Strips *a.b.* from *a.b.c* when listing the available completion
        candidates to produce a cleaner output.

        """
        # Strip "a.b." from "a.b.c" for all matches
        matches = rlcompleter.Completer.attr_matches(self, text)
        matches = [attr[attr.rfind('.') + 1:] for attr in matches]

        expr, attr = text.rsplit('.', 1)

        # Return the common prefix of all matches
        prefix = self._common_prefix(matches)
        if prefix and prefix != attr:
            return ['%s.%s' % (expr, prefix)]

        # Add '' to the matches to prevent the automatic completion of the
        # common prefix.
        # Without it, "sys.path<tab>" would produce "path" and not display
        # the available methods ("path" and various "path_*").
        return matches + [' ']

    def _common_prefix(self, names):
        """Returns the common prefix of all strings in *names*."""
        for i, letters in enumerate(zip(*names)):
            for l1, l2 in zip(letters[:-1], letters[1:]):
                if l1 != l2:
                    return names[0][:i]
        return names[0][:i+1]
