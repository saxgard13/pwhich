#!/bin/bash

# Si aucun argument n'est fourni (ex: lancement via le menu d'applications)
if [ -z "$1" ]; then
    echo "🔍 pwhich - Inspecteur de paquets"
    echo "----------------------------------------"
    read -p "Entrez le nom du paquet/logiciel à vérifier : " app
    echo ""
else
    app="$1"
fi

# Si l'utilisateur valide à vide, on quitte
if [ -z "$app" ]; then
    echo "Aucun nom fourni. Annulation."
    read -p "Appuie sur Entrée pour fermer..."
    exit 0
fi

echo "🔍 Recherche d'origine pour : $app"
echo "----------------------------------------"

# 1. Localisation du binaire système
bin=$(which "$app" 2>/dev/null)
if [ -n "$bin" ]; then
    echo "📍 Exécutable : $bin"
else
    echo "📍 Exécutable : Non trouvé dans le PATH"
fi
echo ""

# 2. Recherche APT / DEB
deb=$(dpkg -l "*$app*" 2>/dev/null | grep ^ii)
if [ -n "$deb" ]; then
    echo "📦 Paquet APT (DEB) :"
    echo "$deb" | awk '{printf "   - %-25s %-20s\n", $2, $3}'
    echo ""
fi

# 3. Recherche Snap
if command -v snap &>/dev/null; then
    snap_res=$(snap list 2>/dev/null | grep -i "$app")
    if [ -n "$snap_res" ]; then
        echo "🟢 Paquet Snap :"
        echo "$snap_res" | awk '{printf "   - %-25s %-20s\n", $1, $2}'
        echo ""
    fi
fi

# 4. Recherche Flatpak
if command -v flatpak &>/dev/null; then
    fp_res=$(flatpak list 2>/dev/null | grep -i "$app")
    if [ -n "$fp_res" ]; then
        echo "🔵 Paquet Flatpak :"
        echo "$fp_res" | awk '{printf "   - %-25s %-20s (%s)\n", $1, $2, $3}'
        echo ""
    fi
fi

echo "----------------------------------------"

# Maintient la fenêtre ouverte si lancée depuis l'interface graphique
if [ ! -t 0 ] || [ -z "$1" ]; then
    read -p "Appuie sur Entrée pour quitter..."
fi