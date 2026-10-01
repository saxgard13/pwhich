#!/bin/bash
set -e

echo "🗑️ Uninstalling 'pwhich'..."

# 1. Remove the system executable
if [ -f /usr/local/bin/pwhich ]; then
  sudo rm /usr/local/bin/pwhich
  echo "✔ Executable /usr/local/bin/pwhich removed."
fi

# 2. Remove the desktop shortcut
if [ -f ~/.local/share/applications/pwhich.desktop ]; then
  rm ~/.local/share/applications/pwhich.desktop
  echo "✔ Application shortcut removed."
fi

# 3. Refresh the application database
update-desktop-database ~/.local/share/applications/ 2>/dev/null || true

echo "✅ Uninstallation completed!"
