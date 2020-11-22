#!/bin/sh

################################################################################
# LastPass Menu
#   Uses rofi or dmenu (if rofi is not found) to select a LastPass account and
#   copy its password to the X clipboard using xclip.
#
#   If you add any command line arguments, then this script will suppress
#   the final information message telling the user that the password has
#   been copied to the clipboard.
#
# Convenience / security note:
#   This script does not pass --trust to "lpass login". To prevent lpass-cli
#   from asking you for a second form of authentication, please run "lpass login
#   --trust" in a console once to configure lpass-cli to trust your computer. Be
#   aware that this may expire after 30 days. You may add --trust to the "lpass
#   login" call in this script if you understand the security implications of
#   doing so.
#
# Dependencies:
#   - lpass-cli
#   - rofi or dmenu (prefers rofi by default if it is found)
#   - zenity
#   - Clipboard program compatible with "lpass show -c" (such as xclip)
################################################################################
# Copyright 2017 Joshua Taylor <taylor.joshua88@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
################################################################################

rofi -version &> /dev/null

if [ $? -ne 0 ]; then
    MENU_CMD="dmenu"
    MENU_ARGS=
else
    MENU_CMD="rofi"
    MENU_ARGS=("-dmenu" "-p lpass:" "-theme $HOME/.config/rofi/themes/appsmenu.rasi")
fi

lpass status

if [ $? -ne 0 ]; then
    ZENITY_INPUT="$(sh $HOME/.config/scripts/uname.sh)"

    if [ -z "$ZENITY_INPUT" ]; then
        exit
    fi

    lpass login "$ZENITY_INPUT"

    if [ $? -ne 0 ]; then
        dunstify -u critical -r 701 "Failed to login to LastPass. Please check your credentials and try again."
        exit
    fi
fi

ROFI_SELECTION="$(lpass ls --format '•%an' | grep '•' | tr '•' '\n' | sed '/^$/d' | ${MENU_CMD} ${MENU_ARGS[@]})"

if [ -z "${ROFI_SELECTION}" ]; then
    exit
fi

lpass show -c --password "${ROFI_SELECTION}"

if [ $? -ne 0 ]; then
    dunstify -u critical -r 701 "Login successful but unable to retrieve password for ${ROFI_SELECTION}\n\nTry running this script in a terminal emulator to see error output from lpass."
else
    if [ $# -lt 1 ]; then
        dunstify -r 701 "Password for ${ROFI_SELECTION} saved to clipboard."
    fi
fi
