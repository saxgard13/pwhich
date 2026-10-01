#!/bin/bash
set -e

# Allow running the script from any directory
cd "$(dirname "$0")"

echo "🚀 Installing 'pwhich'..."

# 1. Copy the script to /usr/local/bin
sudo cp pwhich.sh /usr/local/bin/pwhich
sudo chmod +x /usr/local/bin/pwhich
echo "✔ Executable copied to /usr/local/bin/pwhich"

# 2. Install the .desktop file for GNOME
mkdir -p ~/.local/share/applications
cp pwhich.desktop ~/.local/share/applications/
echo "✔ .desktop shortcut installed"

# 3. Refresh the application database
update-desktop-database ~/.local/share/applications/ 2>/dev/null || true

echo "✅ Installation completed successfully!"
echo "You can now use the command: pwhich <name>"
