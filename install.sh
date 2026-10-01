#!/bin/bash
set -e

# Permet de lancer le script depuis n'importe quel dossier
cd "$(dirname "$0")"

echo "🚀 Installation de 'pwhich'..."

# 1. Copie du script vers /usr/local/bin
sudo cp pwhich.sh /usr/local/bin/pwhich
sudo chmod +x /usr/local/bin/pwhich
echo "✔ Exécutable copié dans /usr/local/bin/pwhich"

# 2. Installation du fichier .desktop pour GNOME
mkdir -p ~/.local/share/applications
cp pwhich.desktop ~/.local/share/applications/
echo "✔ Raccourci .desktop installé"

# 3. Rafraîchissement de la base de données des applications
update-desktop-database ~/.local/share/applications/ 2>/dev/null || true

echo "✅ Installation terminée avec succès !"
echo "Tu peux maintenant utiliser la commande : pwhich <nom>"
