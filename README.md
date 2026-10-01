# 🔍 pwhich (Package Which)

**pwhich** est un utilitaire en ligne de commande et une application graphique légère pour **Ubuntu / Linux**. Il permet d'auditer et d'identifier rapidement l'origine d'un paquet ou d'un exécutable parmi les différents gestionnaires de paquets (**APT/DEB**, **Snap** et **Flatpak**).

---

## ✨ Fonctionnalités

- **Recherche unifiée** : Interroge simultanément APT (`dpkg`), Snap et Flatpak.
- **Localisation des binaires** : Affiche le chemin d'accès de l'exécutable et, s'il s'agit d'un lien symbolique, sa cible réelle.
- **Gestion des noms partiels** : Filtre intelligemment les paquets correspondants.
- **Raccourci d'application GNOME** : Intégration au menu des applications avec lancement en terminal interactif.
- **Installation système** : Disponible globalement via `/usr/local/bin/pwhich`.

---

## 🛠️ Structure du projet

* pwhich.sh : Script Shell principal
* pwhich.desktop : Fichier Desktop Entry (raccourci GNOME)
* install.sh : Script d'installation automatique
* uninstall.sh : Script de désinstallation
* README.md : Documentation du projet

---

## 📋 Prérequis

- Ubuntu / Debian (ou dérivé) : la recherche APT repose sur `dpkg`.
- `bash` et `sudo` (pour copier l'exécutable dans `/usr/local/bin`).
- Optionnel : `snap` et `flatpak`. Ils sont ignorés s'ils ne sont pas installés.

---

## 🚀 Installation

1. Cloner le dépôt et se placer dans le dossier du projet :
   git clone https://github.com/saxgard13/pwhich.git
   cd pwhich

2. Lancer l'installation :
   ./install.sh

Le script d'installation va :
- Copier l'exécutable dans `/usr/local/bin/pwhich`.
- Installer le fichier `.desktop` dans `~/.local/share/applications/`.
- Mettre à jour la base de données des applications du système.

---

## 💡 Utilisation

### En ligne de commande (Terminal)

Tu peux lancer l'outil depuis n'importe quel dossier :

pwhich keepassxc
pwhich firefox
pwhich docker

Sans argument, `pwhich` demande le nom à inspecter.

L'option `--pause` garde le terminal ouvert à la fin (utilisée par le raccourci du menu d'applications) :

pwhich --pause

### Via l'interface graphique (Menu d'applications)

1. Ouvre le lanceur d'applications d'Ubuntu (Super / Touche Windows).
2. Cherche « pwhich ».
3. Clique sur l'icône : un terminal s'ouvre et te demande le nom du logiciel à inspecter.

---

## 🖥️ Exemple de sortie

🔍 Recherche d'origine pour : firefox
----------------------------------------
📍 Exécutable : /usr/bin/firefox

📦 Paquet APT (DEB) :
   - firefox              1:1snap1-0ubuntu9.1 

🟢 Paquet Snap :
   - firefox              157.0-1             
----------------------------------------

Si l'exécutable est un lien symbolique, une ligne supplémentaire indique sa cible :

📍 Exécutable : /usr/bin/c++
🔗 Lien vers  : /usr/bin/x86_64-linux-gnu-g++-15

---

## 🗑️ Désinstallation

Pour retirer totalement l'application du système :

./uninstall.sh