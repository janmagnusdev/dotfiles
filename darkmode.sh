#!/usr/bin/env bash
#
# Usage:
#
#   dm [get|set|toggle]
#
# Commands:
#
#   get               Get the current dark mode setting [Dark|Light]
#   set [Dark|Light]  Set the current explicitly do Dark or Light
#   toggle            Toggle from Dark to Light or from Light to Tark
#

# TODO: Document polling processes for
#       - iterm2: has its own (Python) process with an event loop
#       - vim: SetBackgroundMode with a timer

# TODO: Detect ssh sessions and env var passed fromthe client (e.g., LC_DARKMODE)?
# if [[ -n "$SSH_TTY" ]]; then

# macOS
# =====
#
# In order to run this script with a keyboard shortcut, create a Contextual
# Workflow in Automator and let it run the following AppleScript:
#
# Do shell script "~/.local/bin/dm toggle"
#
# https://appleinsider.com/articles/18/06/14/how-to-toggle-dark-mode-with-a-keyboard-shortcut-or-the-touch-bar
#
# Then open *System Settings > Keyboard > Shortcuts > Services* and add
# a shortcut like "Cmd+Option+D"

CONFIG_FILE="$HOME/.config/darkmode"
declare -A THEME=(
    [Dark]="Stylo Dark"
    [Light]="Stylo Light"
)


_macos_is_dark() {
    [[ $(defaults read -g AppleInterfaceStyle 2> /dev/null) = Dark ]]
}

_macos_set() {
    # MODE can be {"true", "false" "not dark"}
    if [[ "$1" = Dark ]]; then
        MODE="true"
    else
        MODE="false"
    fi
    OSASCRIPT="
    tell application \"System Events\"
        tell appearance preferences
            set dark mode to $MODE
        end tell
    end tell
    "
    # tell application \"Terminal\"
    #     set default settings to settings set \"${THEME[$1]}\"
    # end tell
    #
    # tell application \"Terminal\"
    #     set current settings of tabs of windows to settings set \"${THEME[$1]}\"
    # end tell
    # "
    osascript -e "$OSASCRIPT"
}

_linux_is_dark() {
    # Get from KdE ColorScheme
    # [[ $(kreadconfig5 --file $HOME/.config/kdeglobals --group General --key ColorScheme) = BreezeDark ]]

    # Get from Konsole default profile
    # See issue: https://bugs.kde.org/show_bug.cgi?id=414851
    # PROFILE=$(qdbus $KONSOLE_DBUS_SERVICE /Windows/1 org.kde.konsole.Window.defaultProfile)
    # [[ "$PROFILE" = Dark ]]

    # Get from config file
    read DM_ENABLED < $CONFIG_FILE
    [[ "$DM_ENABLED" = 1 ]]
}

_linux_set() {
    PROFILE=$1
    if [[ "$1" = Dark ]]; then
        DM_VAL=1
    else
        DM_VAL=0
    fi
    echo $DM_VAL > $HOME/.config/darkmode
    for sid in $(qdbus $KONSOLE_DBUS_SERVICE /Windows/1 sessionList); do
        # qdbus $KONSOLE_DBUS_SERVICE $KONSOLE_DBUS_SESSION org.kde.konsole.Session.setProfile "$PROFILE"
        qdbus $KONSOLE_DBUS_SERVICE /Sessions/$sid org.kde.konsole.Session.setProfile "$PROFILE" > /dev/null
    done
}

_get() {
    if _is_dark; then
        echo Dark
    else
        echo Light
    fi
}

_toggle() {
    if _is_dark; then
        _set Light
    else
        _set Dark
    fi
}

uname="$(uname -s)"
if [[ "$uname" == Darwin ]]; then
    _is_dark() { _macos_is_dark; }
    _set() { _macos_set $1; }
elif [[ "$uname" == Linux ]]; then
    touch $CONFIG_FILE
    _is_dark() { _linux_is_dark; }
    _set() { _linux_set $1; }
else
    echo "Unsupported OS: $UNAME"
    exit 1
fi


case $1 in
    get)    _get;;
    set)    _set "$2";;
    toggle) _toggle;;
    *)      echo "Usage: dm [get|set|toggle]"; exit 1;;
esac
