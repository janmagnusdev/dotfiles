"""
Utility functions for my Python prompt
"""
import os
import rlcompleter
import subprocess
import sys


def e(v):
    """Escape color value *v*."""
    return f"\033[0;{v}m"


class c:
    reset = "\033[0m"
    red = e("31")
    green = e("32")
    yellow = e("33")
    blue = e("34")
    purple = e("35")
    cyan = e("36")
    bright_green = e("92")
    bright_yellow = e("93")
    bright_blue = e("94")
    bright_cyan = e("96")


def setup_colored_promt():
    """Set-up a colored promt if readline is available.

    Unfortunately, libedit-based readline doesn't work with that.

    """
    try:
        import readline
    except ImportError:
        return

    sys.ps1 = f"{c.bright_cyan}❯{c.bright_green}❯{c.yellow}❯{c.reset} "
    sys.ps2 = f"{c.cyan}.{c.green}.{c.yellow}.{c.reset} "


def setup_persistent_history():
    """Sets-up a persistent history in *~/.pyhistory*."""
    try:
        import atexit
        import readline
    except ImportError:
        return

    histfile = os.path.expanduser("~/.pyhistory")
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
        readline.parse_and_bind("tab: complete")
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

    if sys.platform != "darwin":
        return False

    cmd = ["otool", "-L", readline.__file__]
    out = subprocess.check_output(cmd).decode()

    if "libedit" in out:
        return True

    return False


def pp_displayhook(value):
    """Uses :func:`pprint.pprint` to print *value* to stdout."""
    if value is not None:
        import builtins

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

    def complete(self, text, state):
        """Return a *tab* if you are on the beginning of a line or the next
        next possible completion else.

        """
        if text == "":
            return ["\t", None][state]
        else:
            return rlcompleter.Completer.complete(self, text, state)

    def attr_matches(self, text):
        """Strip *a.b.* from *a.b.c* when listing the available completion
        candidates to produce a cleaner output.

        """
        # Strip "a.b." from "a.b.c" for all matches
        matches = rlcompleter.Completer.attr_matches(self, text)
        matches = [attr[attr.rfind(".") + 1 :] for attr in matches]

        expr, attr = text.rsplit(".", 1)

        # Return the common prefix of all matches
        prefix = self._common_prefix(matches)
        if prefix and prefix != attr:
            return [f"{expr}.{prefix}"]

        # Add '' to the matches to prevent the automatic completion of the
        # common prefix.
        # Without it, "sys.path<tab>" would produce "path" and not display
        # the available methods ("path" and various "path_*").
        return matches + [" "]

    def _common_prefix(self, names):
        """Return the common prefix of all strings in *names*."""
        for i, letters in enumerate(zip(*names)):
            for l1, l2 in zip(letters[:-1], letters[1:]):
                if l1 != l2:
                    return names[0][:i]
        return names[0][: i + 1]
