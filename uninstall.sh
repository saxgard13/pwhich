#!/bin/bash

echo "🗑️ Désinstallation de 'pwhich'..."

# 1. Suppression de l'exécutable système
if [ -f /usr/local/bin/pwhich ]; then
  sudo rm /usr/local/bin/pwhich
  echo "✔ Exécutable /usr/local/bin/pwhich supprimé."
fi

# 2. Suppression du raccourci desktop
if [ -f ~/.local/share/applications/pwhich.desktop ]; then
  rm ~/.local/share/applications/pwhich.desktop
  echo "✔ Raccourci d'application supprimé."
fi

# 3. Mise à jour de la base de données GNOME
update-desktop-database ~/.local/share/applications/ 2>/dev/null

echo "✅ Désinstallation terminée !"
