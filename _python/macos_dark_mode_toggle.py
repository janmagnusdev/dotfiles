"""
Toggle macOS Dark Mode

"""
# In order to run this script with a keyboard shortcut, create a Contextual
# Workflow in Automator and let it run the following AppleScript:
#
# do shell script "/usr/local/bin/python3 ~/.python/macos_dark_mode_toggle.py"
#
# https://appleinsider.com/articles/18/06/14/how-to-toggle-dark-mode-with-a-keyboard-shortcut-or-the-touch-bar
import subprocess


OSASCRIPT = """
tell application "System Events"
    tell appearance preferences
        set dark mode to {mode}
    end tell
end tell

tell application "Terminal"
    set default settings to settings set "{theme}"
end tell

tell application "Terminal"
    set current settings of tabs of windows to settings set "{theme}"
end tell
"""

TERMINAL_THEMES = {
    False: 'Stylo Light',
    True: 'Stylo Dark',
}


def is_dark_mode():
    result = subprocess.run(
        ['defaults', 'read', '-g', 'AppleInterfaceStyle'],
        text=True,
        capture_output=True,
    )
    return result.returncode == 0 and result.stdout.strip() == 'Dark'


def set_interface_style(dark):
    mode = 'true' if dark else 'false'  # mode can be {true, false, not dark}
    script = OSASCRIPT.format(mode=mode, theme=TERMINAL_THEMES[dark])
    result = subprocess.run(
        ['osascript', '-e', script],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result


if __name__ == '__main__':
    set_interface_style(not is_dark_mode())
