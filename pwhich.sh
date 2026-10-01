#!/bin/bash

# --pause: keep the window open at the end (launch from the application menu)
pause=false
if [ "$1" = "--pause" ]; then
    pause=true
    shift
fi

# If no argument is given, ask for the name interactively.
# read without a custom IFS strips leading and trailing whitespace.
if [ -z "$1" ]; then
    echo "🔍 pwhich - Package inspector"
    echo "----------------------------------------"
    read -r -p "Enter the package/software name to check: " app
    echo ""
else
    read -r app <<< "$1"
fi

# If the user submits an empty name, exit
if [ -z "$app" ]; then
    echo "No name provided. Cancelled."
    if [ "$pause" = true ]; then
        read -r -p "Press Enter to close..."
    fi
    exit 0
fi

echo "🔍 Looking up origin of: $app"
echo "----------------------------------------"

# 1. System binary location
bin=$(type -P -- "$app")
if [ -n "$bin" ]; then
    echo "📍 Executable: $bin"
    # Show the real target if the executable is a symbolic link
    real=$(readlink -f -- "$bin")
    if [ "$real" != "$bin" ]; then
        echo "🔗 Links to  : $real"
    fi
else
    echo "📍 Executable: Not found in PATH"
fi
echo ""

# 2. APT / DEB lookup
deb=$(dpkg -l -- "*$app*" 2>/dev/null | grep ^ii)
if [ -n "$deb" ]; then
    echo "📦 APT package (DEB):"
    echo "$deb" | awk '{printf "   - %-25s %-20s\n", $2, $3}'
    echo ""
fi

# 3. Snap lookup
if command -v snap &>/dev/null; then
    snap_res=$(snap list 2>/dev/null | grep -iF -- "$app")
    if [ -n "$snap_res" ]; then
        echo "🟢 Snap package:"
        echo "$snap_res" | awk '{printf "   - %-25s %-20s\n", $1, $2}'
        echo ""
    fi
fi

# 4. Flatpak lookup
if command -v flatpak &>/dev/null; then
    fp_res=$(flatpak list 2>/dev/null | grep -iF -- "$app")
    if [ -n "$fp_res" ]; then
        echo "🔵 Flatpak package:"
        echo "$fp_res" | awk '{printf "   - %-25s %-20s (%s)\n", $1, $2, $3}'
        echo ""
    fi
fi

echo "----------------------------------------"

# Keep the window open when launched from the graphical interface
if [ "$pause" = true ]; then
    read -r -p "Press Enter to exit..."
fi
