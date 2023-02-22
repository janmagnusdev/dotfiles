#!/usr/bin/env bash
# Get, set or toggle dark mode on macOS and Linux
#
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

# TODO: Detect ssh sessions and env var passed from the client (e.g., LC_DARKMODE)?
# if [[ -n "$SSH_TTY" ]]; then

set -Eeuo pipefail

# "/opt/homebrew/bin" is not in PATH when this script is called from AppleScript
if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
    if [[ -d /opt/homebrew ]]; then
        export HOMEBREW_PREFIX="/opt/homebrew"
    else
        export HOMEBREW_PREFIX="/usr/local"
    fi
fi
PATH="$PATH:$HOMEBREW_PREFIX/bin"

# This file is used to store the current mode under Linux
CONFIG_FILE="$HOME/.config/darkmode"

# Theme names for apps like Apple Terminal
# declare -A THEME=(
#     [dark]="Stylo Dark"
#     [light]="Stylo Light"
# )


usage() {
    cat <<EOF
Get, set or toggle dark mode.

Usage: $(basename "${BASH_SOURCE[0]}") [get|set|toggle]

Commands:

  get               Get the current dark mode setting [dark|light]
  set [dark|light]  Set the current explicitly do dark or light
  toggle            Toggle from dark to light or from light to dark

Options:

-h, --help      Print this help and exit
EOF
    exit
}


msg() {
  echo >&2 -e "${1-}"
}


die() {
  local msg=$1
  local code=${2-1}  # default exit status 1
  msg "$msg"
  exit "$code"
}


parse_params() {
    ACTION=''
    MODE=''

    case "${1-}" in
        -h | --help) usage ;;
        get)    ACTION="get";;
        set)
            ACTION="set";
            case "${2-}" in
                light | dark) MODE="$2" ;;
                *) die "Invalid mode. Options: light|dark" ;;
            esac
            ;;
        toggle) ACTION="toggle";;
        *)      die "Usage: dm [get|set|toggle]" ;;
    esac
}


#
# OS specific function for detecting and setting dark mode
#

_macos_is_dark() {
    [[ $(defaults read -g AppleInterfaceStyle 2> /dev/null) = Dark ]]
}


_macos_set() {
    # MODE can be {"true", "false" "not dark"}
    if [[ "$1" = dark ]]; then
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
    # Apple Terminal is currently not needed.
    #
    # tell application \"Terminal\"
    #     set default settings to settings set \"${THEME[$1]}\"
    # end tell
    #
    # tell application \"Terminal\"
    #     set current settings of tabs of windows to settings set \"${THEME[$1]}\"
    # end tell
    # "
    osascript -e "$OSASCRIPT"

    # iTerm2 has its own Python script that auto detects dm:
    # iterm2_dark_mode_toggle.py
}


_linux_is_dark() {
    # Get from KdE ColorScheme
    # [[ $(kreadconfig5 --file $HOME/.config/kdeglobals --group General --key ColorScheme) = BreezeDark ]]

    # Get from Konsole default profile
    # See issue: https://bugs.kde.org/show_bug.cgi?id=414851
    # PROFILE=$(qdbus $KONSOLE_DBUS_SERVICE /Windows/1 org.kde.konsole.Window.defaultProfile)
    # [[ "$PROFILE" = dark ]]

    # Get from config file
    read DM_ENABLED < $CONFIG_FILE
    [[ "$DM_ENABLED" = 1 ]]
}


_linux_set() {
    PROFILE=$1
    if [[ "$1" = dark ]]; then
        DM_VAL=1
        COLOR_SCHEME='BreezeDark'
    else
        DM_VAL=0
        COLOR_SCHEME='BreezeClassic'
    fi
    echo $DM_VAL > $HOME/.config/darkmode
    # Change Plasma color scheme
    plasma-apply-colorscheme "$COLOR_SCHEME"

    # Change Konsole profile
    # $KONSOLE_DBUS_SERVICE only contains the service for the current window, but we
    # want to update *all* windows:
    for service in $(qdbus | grep org.kde.konsole-); do
        qdbus $service /Windows/1 setDefaultProfile "$PROFILE"
        for sid in $(qdbus $service /Windows/1 sessionList); do
            qdbus $service /Sessions/$sid org.kde.konsole.Session.setProfile "$PROFILE" > /dev/null
        done
    done
}


# Bind the OS specific funcs to "_is_dark" and "_set"
uname="$(uname -s)"
if [[ "$uname" == Darwin ]]; then
    _is_dark() { _macos_is_dark; }
    _set() { _macos_set $1; }
elif [[ "$uname" == Linux ]]; then
    touch $CONFIG_FILE
    _is_dark() { _linux_is_dark; }
    _set() { _linux_set $1; }
else
    die "Unsupported OS: $uname"
fi


#
# API functions / entry points
#

get() {
    if _is_dark; then
        echo dark
    else
        echo light
    fi
}

set() {
    mode=$1

    # OS specific setter
    _set $mode

    # vim uses a timer to auto-detect dark/light mode, nothing to do here.
}


toggle() {
    if _is_dark; then
        set light
    else
        set dark
    fi
}


# Parse params and execute the proper action
parse_params "$@"
$ACTION $MODE
